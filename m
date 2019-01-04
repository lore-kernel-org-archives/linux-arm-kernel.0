Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3644AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:44:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDEE52184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CskgBnSZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5NLY8yF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEE52184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4dqFXTCtoG5B8zWYgZTV2n41W58nm26tR339lMYptPk=; b=CskgBnSZ77lDgx
	MKFTbsqIIMjmDDmJfn3450fF9wUAtCuvoSkj11dd9T/J+Gvzk2eKJZl0hfrLBqoE1vWfZ2LwozOST
	8GsoGgZozPsEVNlpW32DhYtzo76teYxQt/m3swtpMl2sGBkFqKbWzI/I0+bTjnO/PM8tsYh0ogm7A
	HRiesqG1YTtIQyXjmi+8UHmqUQNDgY7sXZijfDnWobR5lhGD0Am0fGNcVb6RWvaJPL1/LEMP45skS
	bcC+xXi/zDoPBurQk4qWFFqcjlOvVIeOCev6zhDnkr1+cKxXiDUWDV35gGZqFKyoYoUfJCzSyHc4o
	+mjqFwRCOrE0MYsAxM6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfM2A-0002E7-QH; Fri, 04 Jan 2019 09:44:54 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfM27-0002DD-9X
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 09:44:53 +0000
Received: by mail-pl1-x643.google.com with SMTP id b5so17221710plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 01:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1MG9cGxllvxcFxqe5/7vWOoA1Mh9LTZ2vq6D1pcTPoI=;
 b=j5NLY8yFJNAfhdYLl5QwcLqQeYHDAz0znfBJy5meFTErqfVSUpbpEHcBhyjx+PEWOQ
 QVtECS/uHnxSMKHGyk60CKDJoEip0ssV5dUVUa4j5xZQbYcmL7+OpcXPL03AGytijW8C
 qAWY/RAyow6cs3p3W6OmMOFcQA6s2BiZ5jYqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1MG9cGxllvxcFxqe5/7vWOoA1Mh9LTZ2vq6D1pcTPoI=;
 b=c8PoZibmskBwFINtthF/BxiWnhM2L3cVZfOMDCjFabmRbqBCZo0eESJYlRmQi9Vkcu
 MUbsGJaJ6+dl+ZcV3anjuU6LDKj9lDliCa2Cx+qI+dcGwx2ytPy+TB/EuVa28O5jzoT1
 BqGckOn7BHNT93w+XmlGZFfleSe7A5f8QSv76QTpvlCOldwFCrdgrphAGqXGpXhMqZ2V
 ZRZRhKkE92ZJ6fu/+niOgr/T80X5AZKgaenHvBwx2gEqIYhUwKpIShlJyN3ElDdWKDVq
 ANWazBI8CFwxsh3qsFTW4Yg8gaBTxzSrFjQ1XRhctI6jYJGJH7RdLzCCUoBoXJ+nvViL
 4NGg==
X-Gm-Message-State: AJcUukdCLN9zUlThX7EU//zENRkwVLNMfNeBJKc5kTlnl7b3vIqEWPiv
 7QHo6idtPJ2Nag38f67vHanE6aYyNH4=
X-Google-Smtp-Source: ALg8bN7Qz0zqMgAdptul9ZPCkzU4LRNafsSXh5INPi6BjlWZ77mnMJqFOIsOXW52CKTFlGp+boRVSA==
X-Received: by 2002:a17:902:e290:: with SMTP id
 cf16mr51346700plb.81.1546595087296; 
 Fri, 04 Jan 2019 01:44:47 -0800 (PST)
Received: from localhost ([122.166.131.155])
 by smtp.gmail.com with ESMTPSA id u126sm121771528pgb.2.2019.01.04.01.44.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Jan 2019 01:44:46 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Valentin Schneider <valentin.schneider@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] cpufreq: scpi/scmi: Fix freeing of dynamic OPPs
Date: Fri,  4 Jan 2019 15:14:33 +0530
Message-Id: <7dddbeabb434225d9b3d02600ea4a2313622ca26.1546594910.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_014451_331816_96E29ACE 
X-CRM114-Status: GOOD (  17.10  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 "4 . 20" <stable@vger.kernel.org>, dietmar.eggemann@arm.com,
 quentin.perret@arm.com, Douglas.Raillard@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since the commit 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from
_dev_pm_opp_remove_table()"), dynamically created OPP aren't
automatically removed anymore by dev_pm_opp_cpumask_remove_table(). This
affects the scpi and scmi cpufreq drivers which no longer free OPPs on
failures or on invocations of the policy->exit() callback.

Create a generic OPP helper dev_pm_opp_remove_all_dynamic() which can be
called from these drivers instead of dev_pm_opp_cpumask_remove_table().

In dev_pm_opp_remove_all_dynamic(), we need to make sure that the
opp_list isn't getting accessed simultaneously from other parts of the
OPP core while the helper is freeing dynamic OPPs, i.e. we can't drop
the opp_table->lock while traversing through the OPP list. And to
accomplish that, this patch also creates _opp_kref_release_unlocked()
which can be called from this new helper with the opp_table lock already
held.

Cc: 4.20 <stable@vger.kernel.org> # v4.20
Reported-by: Valentin Schneider <valentin.schneider@arm.com>
Fixes: 2a4eb7358aba ("OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/scmi-cpufreq.c |  4 +--
 drivers/cpufreq/scpi-cpufreq.c |  4 +--
 drivers/opp/core.c             | 63 +++++++++++++++++++++++++++++++---
 include/linux/pm_opp.h         |  5 +++
 4 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 50b1551ba894..c2e66528f5ee 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -176,7 +176,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-	dev_pm_opp_cpumask_remove_table(policy->cpus);
+	dev_pm_opp_remove_all_dynamic(cpu_dev);
 
 	return ret;
 }
@@ -188,7 +188,7 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	kfree(priv);
-	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
+	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 87a98ec77773..99449738faa4 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -177,7 +177,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-	dev_pm_opp_cpumask_remove_table(policy->cpus);
+	dev_pm_opp_remove_all_dynamic(cpu_dev);
 
 	return ret;
 }
@@ -190,7 +190,7 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 	clk_put(priv->clk);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	kfree(priv);
-	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
+	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
 
 	return 0;
 }
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e5507add8f04..18f1639dbc4a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -988,11 +988,9 @@ void _opp_free(struct dev_pm_opp *opp)
 	kfree(opp);
 }
 
-static void _opp_kref_release(struct kref *kref)
+static void _opp_kref_release(struct dev_pm_opp *opp,
+			      struct opp_table *opp_table)
 {
-	struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
-	struct opp_table *opp_table = opp->opp_table;
-
 	/*
 	 * Notify the changes in the availability of the operable
 	 * frequency/voltage list.
@@ -1002,7 +1000,22 @@ static void _opp_kref_release(struct kref *kref)
 	opp_debug_remove_one(opp);
 	list_del(&opp->node);
 	kfree(opp);
+}
 
+static void _opp_kref_release_unlocked(struct kref *kref)
+{
+	struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
+	struct opp_table *opp_table = opp->opp_table;
+
+	_opp_kref_release(opp, opp_table);
+}
+
+static void _opp_kref_release_locked(struct kref *kref)
+{
+	struct dev_pm_opp *opp = container_of(kref, struct dev_pm_opp, kref);
+	struct opp_table *opp_table = opp->opp_table;
+
+	_opp_kref_release(opp, opp_table);
 	mutex_unlock(&opp_table->lock);
 }
 
@@ -1013,10 +1026,16 @@ void dev_pm_opp_get(struct dev_pm_opp *opp)
 
 void dev_pm_opp_put(struct dev_pm_opp *opp)
 {
-	kref_put_mutex(&opp->kref, _opp_kref_release, &opp->opp_table->lock);
+	kref_put_mutex(&opp->kref, _opp_kref_release_locked,
+		       &opp->opp_table->lock);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put);
 
+static void dev_pm_opp_put_unlocked(struct dev_pm_opp *opp)
+{
+	kref_put(&opp->kref, _opp_kref_release_unlocked);
+}
+
 /**
  * dev_pm_opp_remove()  - Remove an OPP from OPP table
  * @dev:	device for which we do this operation
@@ -1060,6 +1079,40 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 
+/**
+ * dev_pm_opp_remove_all_dynamic() - Remove all dynamically created OPPs
+ * @dev:	device for which we do this operation
+ *
+ * This function removes all dynamically created OPPs from the opp table.
+ */
+void dev_pm_opp_remove_all_dynamic(struct device *dev)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *opp, *temp;
+	int count = 0;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return;
+
+	mutex_lock(&opp_table->lock);
+	list_for_each_entry_safe(opp, temp, &opp_table->opp_list, node) {
+		if (opp->dynamic) {
+			dev_pm_opp_put_unlocked(opp);
+			count++;
+		}
+	}
+	mutex_unlock(&opp_table->lock);
+
+	/* Drop the references taken by dev_pm_opp_add() */
+	while (count--)
+		dev_pm_opp_put_opp_table(opp_table);
+
+	/* Drop the reference taken by _find_opp_table() */
+	dev_pm_opp_put_opp_table(opp_table);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
+
 struct dev_pm_opp *_opp_allocate(struct opp_table *table)
 {
 	struct dev_pm_opp *opp;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0a2a88e5a383..b895f4e79868 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -108,6 +108,7 @@ void dev_pm_opp_put(struct dev_pm_opp *opp);
 int dev_pm_opp_add(struct device *dev, unsigned long freq,
 		   unsigned long u_volt);
 void dev_pm_opp_remove(struct device *dev, unsigned long freq);
+void dev_pm_opp_remove_all_dynamic(struct device *dev);
 
 int dev_pm_opp_enable(struct device *dev, unsigned long freq);
 
@@ -217,6 +218,10 @@ static inline void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 {
 }
 
+static inline void dev_pm_opp_remove_all_dynamic(struct device *dev)
+{
+}
+
 static inline int dev_pm_opp_enable(struct device *dev, unsigned long freq)
 {
 	return 0;
-- 
2.19.1.568.g152ad8e3369a


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

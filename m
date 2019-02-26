Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCA9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:54:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF3B2184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g9S7lSgF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpiV1C7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF3B2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=u7eutKaHc+DoU+KTP5zxhR7TQiZqRCAH7VZDPDoKHdk=; b=g9S7lSgFLNfngJjO6owfBSvFSy
	A4ootn8wMa5Do9cHPfJ/rDDP+SwOwV8wtZEZj/FHmZz2kQZNiLh0394/9A2NNwVV6FBwbjkFK5uiL
	1o9RdWnd9uoBKUO9Eu41q08QsEqbumGqPG+H0jzRf1TKSvVfpCBcMDxFvY4upAKafa+UHdKula99I
	Fmzzl1xCLQ2L/CdHn+vI7hIiKVowDaaFnKlA1G+v2RWW30jdMgcnV0BIUCASUawNHIscbYucd9aH/
	gAUpJvPUKjwWkBtmI5PSxyyT0aD1RlNBca7A4GUGBjb/6/tMHJ6DutF3iqmkgebYSH/GwW8pYOGCc
	H2+qg/DA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gye7z-0005Pe-SR; Tue, 26 Feb 2019 14:54:39 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gye7w-0005Ng-1A
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:54:37 +0000
Received: by mail-lj1-x243.google.com with SMTP id z20so11005050ljj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 06:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4olRHrO4OGLzrA6TD5Q8IXYA3EOf33sfuFLg1Ze1+T8=;
 b=UpiV1C7XUoRlE7eOlCQ7dZ0FXppFbUeWVKE+mS8DyVTrfoC9wQDiLrkZaRPQsDkffg
 7LmpX1qQeqw7pZ4AGLlqSYJuLMPQL08U8CWEQRAzNONsI4X0V9xyDVzPq8sh0WB4flM1
 esuF0lZLmPD4DVxaFMIq1+6Wc29pnSH+8Dkuhnz8A0Be9Wg7PKAiatg7BMtzX4BoINze
 +uZ4OPlROTt/bcxixY1D8S0MKU4u5tchRwXrsbPR5KkeD5uTBeH7HE6rueq/yA4Bnf6o
 4giH0pEncr3VbdMzT1AqQ2na2sJZ2g7M9VVfBr+gsFBFrcJbgHblsvCVf/AUAccBFciE
 Kkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4olRHrO4OGLzrA6TD5Q8IXYA3EOf33sfuFLg1Ze1+T8=;
 b=dJjpAFdpmcT0rLGHtYBlLYRMpb+fsFlPA+DxWsf/2Jnl4EpmjIEJA2uhQkvIYj7wZh
 i3telZ39Nyrc8okg7iRGmlXVWClK8nkSz1fQrLBsxU3YSEUz1+hpZqN36LorWm1uBH6g
 37eKxiJUJonei4jymLB6LmdhIy6zIJao6ScFYxLjADW07POpsPNKVgfbdr6gpWG63BZB
 b2HuQCVlWiClu7cP2AzMHR2ahHqphDpqVCyiOJElRB6DapdNofLEoVjlJg6ChjQFZnWs
 DZpQHzfcJkyNWuuZpQmzITxWKA8SbyWFzYFp9x5g5zgjVSbPkdszfTUYmeIJtWndGQT7
 Bnhg==
X-Gm-Message-State: AHQUAubnMdWx+3nqu8jAZaFDtJchpWEYXmDBi5zYJd5pl85MnBt0J6ox
 vEohmPJbkOTGmlWJPUIoiTFung==
X-Google-Smtp-Source: AHgI3IYhRgfMci2gWG7XJv/qsPRrrRxzcro7TN2Y9E2w5Y3G0gGzKJM7bcSXjPp5ZRxr+TyG33XsbQ==
X-Received: by 2002:a2e:9916:: with SMTP id v22mr13192461lji.68.1551192872994; 
 Tue, 26 Feb 2019 06:54:32 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id t11sm2206554ljj.92.2019.02.26.06.54.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 06:54:32 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 1/8] PM / Domains: Add a generic data pointer to the
 genpd_power_state struct
Date: Tue, 26 Feb 2019 15:54:08 +0100
Message-Id: <20190226145415.19411-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_065436_068301_1F339085 
X-CRM114-Status: GOOD (  19.06  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, linux-arm-msm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Let's add a data pointer to the genpd_power_state struct, to allow a genpd
backend driver to store per state specific data. To introduce the pointer,
we need to change the way genpd deals with freeing of the corresponding
allocated data.

More precisely, let's clarify the responsibility of whom that shall free
the data, by adding a ->free_states() callback to the struct
generic_pm_domain. The one allocating the data shall assign the callback,
to allow genpd to invoke it from genpd_remove().

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v11:
	- Add a callback for freeing allocated power states.

---
 drivers/base/power/domain.c | 12 ++++++++++--
 include/linux/pm_domain.h   |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2c334c01fc43..03885c003c6a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1685,6 +1685,12 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 }
 EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
 
+static void genpd_free_default_power_state(struct genpd_power_state *states,
+					   unsigned int state_count)
+{
+	kfree(states);
+}
+
 static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
 {
 	struct genpd_power_state *state;
@@ -1695,7 +1701,7 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
 
 	genpd->states = state;
 	genpd->state_count = 1;
-	genpd->free = state;
+	genpd->free_states = genpd_free_default_power_state;
 
 	return 0;
 }
@@ -1811,7 +1817,9 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
 	cancel_work_sync(&genpd->power_off_work);
-	kfree(genpd->free);
+	if (genpd->free_states)
+		genpd->free_states(genpd->states, genpd->state_count);
+
 	pr_debug("%s: removed %s\n", __func__, genpd->name);
 
 	return 0;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 1ed5874bcee0..8e1399231753 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -69,6 +69,7 @@ struct genpd_power_state {
 	s64 residency_ns;
 	struct fwnode_handle *fwnode;
 	ktime_t idle_time;
+	void *data;
 };
 
 struct genpd_lock_ops;
@@ -110,9 +111,10 @@ struct generic_pm_domain {
 			   struct device *dev);
 	unsigned int flags;		/* Bit field of configs for genpd */
 	struct genpd_power_state *states;
+	void (*free_states)(struct genpd_power_state *states,
+			    unsigned int state_count);
 	unsigned int state_count; /* number of states */
 	unsigned int state_idx; /* state that genpd will go to when off */
-	void *free; /* Free the state that was allocated for default */
 	ktime_t on_time;
 	ktime_t accounting_time;
 	const struct genpd_lock_ops *lock_ops;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

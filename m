Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D463C00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:58:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588FF2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BMEOT6QK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCNOViW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588FF2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6FkwjFkDOMzdMtfn5RB6rmiONtcDnEXsqoRGeNMpPQg=; b=BMEOT6QKVJiH4TkYxAuNv1SPCU
	HbPsux44era1jJuHYTfIL7ApbIi0rdKd4O20PYaEN4oHf84vFY8r+zJBzKbrRweRfA97roIhxTqHK
	CiAG1MZjZEZt/sWcOC05qn7+mGtzgilMMRw6zIHrn81lJZo9o/L3XX2chC+Tnh7tmXh/68H/+CiY0
	8lRBuaN2sOApi37sCrKhk4yW7PZ7zTu0oBKKtqc+CcqBeTi8KtvpsiwHIC/ipg/zBVA0WdA/DvLaR
	8k2rrHv4QWZwpjQqYKDQyho/XtbabjCBQYdam7tBb0WWN5DqPWWI0afoqKaVpbpK1mso2E5Z0YlXY
	DyR8fpng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz5M0-0007HH-6J; Wed, 27 Feb 2019 19:58:56 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz5Lo-00076q-LO
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 19:58:46 +0000
Received: by mail-lj1-x242.google.com with SMTP id z20so14985401ljj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 11:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XKFXfVA/MFOFOm3N3DxhXtUoRuHmZYEZxmpq4iLOsS0=;
 b=BCNOViW05Viv/rVAqgh4Vsn2bB/S6rmx007nW5Zwfg3vOsf2oiUNr2cy+h1kftVC1O
 bu8OYpbnjns/sJO3ZVm2y2mMVvfyKc5T8ToLluuy4Ym+LbQsz5Bw8NYC596JvipOH2k9
 4hUg069/roFn9YCZWfP6Ya/L0OOyZxOhQvrivrUoEomsZXKx4S3j/C7bhV/lcIWBHY/9
 ZS+1Z69pFXGch6UfZOAc3Y2359plZH2U7Sx37NqdNH25je5jjhYblLPfuyWaY58vBevx
 uUqpLXxkYkaERvVNnnVdnmP1OxIeXVmuPuDi5S71RyTevI9kwdjMnD2n17nhk0uMunLa
 Fqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XKFXfVA/MFOFOm3N3DxhXtUoRuHmZYEZxmpq4iLOsS0=;
 b=nSHKQ4Ny2/pAvRGlnTjv8QFP3jtZ/VgD/eTZPNPBH86tOZWtcGsWGXnQymnmlTSaSy
 Xt5eAdIJqn3+6pIOJQDoSfG8kD9ymJQNNnIOdQpxnXxueF1fdGMV+6l/SN/EJigjelpr
 YJqnbvfNEAwe00lyBpe9GQN1sLsAQW0J3dVl1DEBvlhPRu79UlalfGnSNbYCigfIxZeX
 AuH/J7edPet7uNxL3FYLKZLndcZL7ts/FjxZdjO+Ac8z2pX0EWwfUl7jS0g83BH7gd4B
 o+L5blDyLhUdUjTmGNzwaR3zzoaw2+F4wtC4Mt3Pm/PHOAANgDCNTxRZQQu9e9gLIosy
 vAnw==
X-Gm-Message-State: AHQUAuYPJk7z3ydvBwAmIaJJMu/YZu1NA8N7VXg+Kt2pWa+xozF+UJG7
 Et2zBtLEtTmpLGt2Dvs0CaN0DQ==
X-Google-Smtp-Source: APXvYqwoEEWsyKRDgF2ZqvMiwFnQqs7Nd2PwXFGAP3pHpMx7U5f+SRreNguy4ZpIWPZAhCu2g6hqmg==
X-Received: by 2002:a2e:9916:: with SMTP id v22mr2435944lji.68.1551297522613; 
 Wed, 27 Feb 2019 11:58:42 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id z128sm723802lfa.60.2019.02.27.11.58.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 27 Feb 2019 11:58:41 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v12 1/4] PM / Domains: Add a generic data pointer to the
 genpd_power_state struct
Date: Wed, 27 Feb 2019 20:58:33 +0100
Message-Id: <20190227195836.24739-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227195836.24739-1-ulf.hansson@linaro.org>
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_115844_695706_E4484A35 
X-CRM114-Status: GOOD (  18.80  )
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

Changes in v12:
	- None.

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

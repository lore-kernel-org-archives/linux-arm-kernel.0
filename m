Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263E5C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:48:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC91421104
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hymFKSt0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WF/uDC6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC91421104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=n1NXSTYUjdGLo1lZxducsN4u+WLm1UXcD2M6xA3PL8k=; b=hymFKSt0bi9EEYyA9a3n5NS5r9
	uBvHO80q57OJ2guMbEoP9oL52g0FgJR7/SFwmCb7/a6dq0ujW69WCwqZCSbDxJre3V4SlGxqHIpwF
	Q7dag/ydwcQp8YEGke1mQfBDKySLyWQ9EwnsQgYWrNhH2ZCIDgegxVoBLMyw/zZsbPut208c8uKgR
	5CsONL1N+phk+jmU1BZV+YlPhpGbsIMVML4sWi4k/xCM2/UwHQGjWNjDdwtJiI9S0LoKSKbBt4EGF
	idKmun98O3st/VXu4F82Lz9n2RYBbmWII+r22UdIqlwj9bYlFdpjjNE7yEefhppmY1p/AJxY6o+Dx
	FzLCKI1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQQi-0002Jr-Ff; Thu, 29 Nov 2018 17:48:48 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPK-00016h-SV
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:47:26 +0000
Received: by mail-lf1-x143.google.com with SMTP id f23so2076469lfc.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2OFzyl7DYqM+TKMo2yE9Sged+x4IOY1BMaINc0irzbk=;
 b=WF/uDC6cto89UDdfBnGrf81NlzZ26+j7fWxzr3FcUZ6bWkeWgWVSaZuoeSFwtlCJcl
 ngNYcGXO/yOYk1SP4DlEzNaHgCCudJxCxzVB9V/lGel5iAWprOmMJl3y0UydtSlM96+S
 vrGMzuCnis/xZHu8BwGfiah6JjJ2lyvNiNMLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2OFzyl7DYqM+TKMo2yE9Sged+x4IOY1BMaINc0irzbk=;
 b=cVpmIsi5xvmlVYb21U++PvP8CvESAqNBgKqmwqqxGjU47IFdf+xxXFHmrXPDoZK6rg
 u3/EmcizGfmRgDno4JWeFxxZAQZoJUUudCf0xiaTisPNoiyAQRvzuO1mh7+OiJV20Iov
 DK7THyHb6pw/g7IaIL+Ytjpg3VaVmnNc1GtXWXd7CtLxN8P3Fa2uV0H+850/e679+Dkd
 4UtS5q/J1UMZcJENgfnaJ8zPX+Ntpt/Q7mx2XrNmMXPTc/+Mc/2EXPMJh6GiwMmJZ8Ww
 FrlJkHjGQg++/pULZ9D2NANwF2z5KB4V1iNv6EkTAjXSovu5JE348+7Vv2qx39p7ci7C
 JOqQ==
X-Gm-Message-State: AA+aEWZxjtTupBZ3tZFhZmysbGcStwqP1Aag4VOZPF+7/dKo73e8YBT0
 McsnPSNZQnarpyPVqtL+pb2NFg==
X-Google-Smtp-Source: AFSGD/WcONLGmNXYECO9oNRUxrjzh2zAGhw9wIqkXq80q8IdpwQYFhZTN3X/sVmIELfDUDxcx4LF2Q==
X-Received: by 2002:a19:2c92:: with SMTP id s140mr1622412lfs.42.1543513630200; 
 Thu, 29 Nov 2018 09:47:10 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:09 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 01/27] PM / Domains: Add generic data pointer to
 genpd_power_state struct
Date: Thu, 29 Nov 2018 18:46:34 +0100
Message-Id: <20181129174700.16585-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094723_034544_4C3B33E7 
X-CRM114-Status: GOOD (  19.72  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 linux-arm-msm@vger.kernel.org,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Let's add a data pointer to the genpd_power_state struct, to allow a genpd
backend driver to store per state specific data. In order to introduce the
pointer, we also need to adopt how genpd frees the allocated data for the
default genpd_power_state struct, that it may allocate at pm_genpd_init().

More precisely, let's use an internal genpd flag to understand when the
states needs to be freed by genpd. When freeing the states data in
genpd_remove(), let's also clear the corresponding genpd->states pointer
and reset the genpd->state_count. In this way, a genpd backend driver
becomes aware of when there is state specific data for it to free.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Update the patch allow backend drivers to free the states specific
	  data during genpd removal. Due to this added complexity, I decided to
	  keep the patch separate, rather than fold it into the patch that makes
	  use of the new void pointer, which was suggested by Rafael.
	- Claim authorship of the patch as lots of changes has been done since
	  the original pick up from Lina Iyer.

---
 drivers/base/power/domain.c | 8 ++++++--
 include/linux/pm_domain.h   | 3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7f38a92b444a..e27b91d36a2a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1620,7 +1620,7 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
 
 	genpd->states = state;
 	genpd->state_count = 1;
-	genpd->free = state;
+	genpd->free_state = true;
 
 	return 0;
 }
@@ -1736,7 +1736,11 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
 	cancel_work_sync(&genpd->power_off_work);
-	kfree(genpd->free);
+	if (genpd->free_state) {
+		kfree(genpd->states);
+		genpd->states = NULL;
+		genpd->state_count = 0;
+	}
 	pr_debug("%s: removed %s\n", __func__, genpd->name);
 
 	return 0;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 3b5d7280e52e..f9e09bd4152c 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -69,6 +69,7 @@ struct genpd_power_state {
 	s64 residency_ns;
 	struct fwnode_handle *fwnode;
 	ktime_t idle_time;
+	void *data;
 };
 
 struct genpd_lock_ops;
@@ -110,7 +111,7 @@ struct generic_pm_domain {
 	struct genpd_power_state *states;
 	unsigned int state_count; /* number of states */
 	unsigned int state_idx; /* state that genpd will go to when off */
-	void *free; /* Free the state that was allocated for default */
+	bool free_state; /* Free the state that was allocated for default */
 	ktime_t on_time;
 	ktime_t accounting_time;
 	const struct genpd_lock_ops *lock_ops;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

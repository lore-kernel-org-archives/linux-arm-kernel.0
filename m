Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F29C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:52:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD0821019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OZQN5rX6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsyItLbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD0821019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GzPVcdt6JaqBaO3tfK1IUrySRyUBCJZxoViKA02wG6E=; b=OZQN5rX64AT4BXvAKv8i3gR5G6
	wopES9/Flr02eSsKY0glhzsc2Q3ZpxHR0SMs3VbFDVX1IoFc9JmYL2Vj2A5+ammemQV2HN7JmH04j
	mBIGukUBlc7GTHnSXheuIw+VEgsYuE+5ojmvY/kxVSx5LpS5gNVoltTGJECyhFnoq0uvURr5WRezL
	dediwojKCLFW1pvMLnsfMtM0c1rImV/481n1dThz+veU6QevQfknJ6dky3XBt/Q21yMtlDJq2mCKW
	C1ay5twEPgexYMQHTnOAalvZd078tADLeznDu4Zkm4shxAJBhZsgtghgLL8ZaX43j1tXk20EHjfAq
	hjs6hcKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQUG-00070M-V8; Thu, 29 Nov 2018 17:52:28 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPv-0001XZ-FV
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:48:09 +0000
Received: by mail-lj1-x241.google.com with SMTP id v15-v6so2504757ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RFaG8cXFhArmCpS6rP1BJYuJ7tPHpHBulh3EEudBMoM=;
 b=YsyItLbVHbH3tNLzCiQMEYnmNZdjcvUx83pMpRN5YHP4Kjmhe6ZXEntFzFIP+AgDbr
 qJwxSlvke/NW59tkmG9joPEpjGPElE19RUBmi1WUnO9dFz/sBAqaNSjy1xznLW4+AKe/
 4lyBldpmHWjI+AbKgVIYPcICKOGDXesumiTy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RFaG8cXFhArmCpS6rP1BJYuJ7tPHpHBulh3EEudBMoM=;
 b=knCGoCsK6kfnrJpUlQ0dJn/UhMmOLh41iKznNvU87gNcKRVwNToFOnwDKQCo1NF/kv
 Q3DkvnLlPKpyzl0Mg66gHob/+z/h89fZopj8kE4ZEm3MBzlQ42JR28kAvY/QZ0949ZUw
 K1aqL6AR0ukjegNQFiAR9SSWCqGAuuDkG03iaRXtYYAJ6GO4s9QuvjANEpWistCFWmPP
 PrHdrJiWRYK/dnUel3ux+adkXz7ZNvPsg9/RECHLct1tWUDizVRSjKDrRYlniqern2hG
 nOQwm2veA9zk2BGXeEH8zy6QQPOWE/X8plRjwLaO7P6mUZ/Z25oMNhu74SHGJTBhOnME
 ATSg==
X-Gm-Message-State: AA+aEWZDdY+s4pti8nl+sCKtyNWIyp9B8LvyVWkrebnbrjuCIVirDViA
 XZyVxoPkhN6jIp2+lwPu5ql9mA==
X-Google-Smtp-Source: AFSGD/WVodyz08Ry3gytrKNYSqfpWR2+qsmxRgCgsjxMAmnxCpSQnymL3the+lKJOkCI1ZjncfMR9g==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr1536589ljo.10.1543513666911; 
 Thu, 29 Nov 2018 09:47:46 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:46 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 22/27] drivers: firmware: psci: Attach the CPU's device to
 its PM domain
Date: Thu, 29 Nov 2018 18:46:55 +0100
Message-Id: <20181129174700.16585-23-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094800_139474_1BC66532 
X-CRM114-Status: GOOD (  18.89  )
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

In order to allow the CPU to be power managed through a potential PM domain
and the corresponding topology, it needs to be attached to it. For that
reason, check if the PM domain data structures have been initiated for PSCI
and if so, let's try to attach the CPU device to its PM domain.

However, before attaching the CPU to its PM domain, we need to check
whether the PSCI firmware supports OS initiated mode or not. If that isn't
the case, we rely solely on the cpuidle framework to deal with the idle
state selection, which means we need to parse DT and convert the
hierarchical described domain idle states into regular cpuidle states,
hence let's do that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Attach CPU devices to their PM domains, regardless of OSI mode or PC
	  mode.
	- For PC mode, convert domain idle states to generic cpuidle states
	  to let the cpuidle driver manage them.

---
 drivers/firmware/psci/psci.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 5b481e91ccab..94cd0431b004 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -327,7 +327,7 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 	u32 *psci_states;
 	struct device_node *state_node;
 
-	psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
+	psci_states = kcalloc(CPUIDLE_STATE_MAX, sizeof(*psci_states),
 			GFP_KERNEL);
 	if (!psci_states)
 		return -ENOMEM;
@@ -351,6 +351,26 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		goto free_mem;
 	}
 
+	/*
+	 * If the hierarchical CPU topology is used, let's attach the CPU device
+	 * to its corresponding PM domain. If OSI mode isn't supported, pick up
+	 * the additional cpuidle states, from the domain idle states described
+	 * in the hierarchical DT layout, as to enable the cpuidle driver to
+	 * manage them.
+	 */
+	if (psci_dt_topology) {
+		if (!psci_has_osi_support()) {
+			ret = psci_dt_pm_domains_parse_states(drv, cpu_node,
+							      psci_states);
+			if (ret)
+				goto free_mem;
+		}
+
+		ret = psci_dt_attach_cpu(cpu);
+		if (ret)
+			goto free_mem;
+	}
+
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
 	return 0;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2E8C43610
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:51:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016D221019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BouVSnDc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/5EWbX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016D221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rZ4da0qqmTB4ErU9A8NrrogU18URfNiVKhc+Zkp6BXY=; b=BouVSnDceljltuxu8J1YvaRF0J
	M5e9egsxeOu7tU0IpsEnVn1PGwgQbl27b8O+BbvJKqAGdtbnXZh6J6KIWHYxD8HJ4epfxx41XmoiJ
	OwJJvR0f7i1kGBnWnFYrAYdnpzax83wy9FPjacRAmLakmzP8Di83BsMlJKHULEilOn4j02rfHbruw
	x+CngLtQCUZ6klk69uSEPpy7osFTwaalO5+PA+juK9+iJv5rH0+St7EMDPL/XgO9bD3tOK9ObxASx
	NbFVMhF4ISQKxrIGi7lKxUUq/nJGhbPA695NALvP959haavrxzB9LBCJoQGgyzTIVQPNokNZW7uig
	YVjda8kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQTK-0005zp-RW; Thu, 29 Nov 2018 17:51:30 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPi-0001Ja-6x
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:47:58 +0000
Received: by mail-lj1-x241.google.com with SMTP id k19-v6so2511696lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PgU1c1CxxtqSBW5JefCvIK+xCW7iLG8npYRcb1HuKE4=;
 b=B/5EWbX/4pIf3Oc3G2zdHEoTEbgIGKaLe3sWcikr1JnH0hv2gk3BnxwQr4TUdob0pS
 GBHcOVwcErj08YkbJF+3nI8Qeiz3paCDoblCXvk3zQCosYDQzVJJ3Zu2ag+TMhbtAuwy
 JVyxj/mbnkShjM0JtEpEnU0awLd8+vHoqWDi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PgU1c1CxxtqSBW5JefCvIK+xCW7iLG8npYRcb1HuKE4=;
 b=bbeb+68DxXFWfhu7vLyyg88UYjZ2IJUyo6b7oKZf/TiPPXtTBk6rHbCve1n/QgTmam
 2aunnjHeQLhv/3Vffi313qaY3k0Ds3PjL5XixaS+8/X0xPpMpAZhyU4BTVj3bz+/1ra0
 tqTE1a5gXjhy7IbUbxhHhSLXZ6xWRq1OWWVqMTVINoll1KbtB7ETev9AE+WHrTrcnrBJ
 rwYGrffnWRH5NpUcOMufELElhE4l77UKW//3olGiACJzaNTweBR9YU08mAr2k0QtMqzG
 /CdTTowcMArCdPc5wgWMvqlfLm4gOySaIdfszpLG6Af0IeCA/VM8+FOU8VIiomGb2Zmj
 fNKQ==
X-Gm-Message-State: AA+aEWZ7ZIocEh2jupYQqXnCkETXQSzYfGCJ9VepuasfBT62BzQWmam/
 SKIiDPzwoRzfpfJjjnkfMKcHlw==
X-Google-Smtp-Source: AFSGD/WczsUHri23WmBiaft8WE6DWc6NG5zksmRIXHH/fM1XFB8rrAvVA/6TldZECosGbxyL5A6+UQ==
X-Received: by 2002:a2e:85d3:: with SMTP id
 h19-v6mr1678736ljj.82.1543513656433; 
 Thu, 29 Nov 2018 09:47:36 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:35 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 16/27] drivers: firmware: psci: Prepare to use OS
 initiated suspend mode
Date: Thu, 29 Nov 2018 18:46:49 +0100
Message-Id: <20181129174700.16585-17-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094747_107366_F2AA72FB 
X-CRM114-Status: GOOD (  17.95  )
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

To enable the OS initiated mode, the CPU topology needs to be described
using the hierarchical model in DT. When used, the idle state bits for the
CPU are created by ORing the bits for PM domain's idle state.

Let's prepare the PSCI driver to deal with this, via introducing a per CPU
variable called domain_state and by adding internal helpers to read/write
the value of the variable.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Use __this_cpu_read|write() rather than this_cpu_read|write().

---
 drivers/firmware/psci/psci.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 4f0cbc95e41b..8dbcdecc2ae4 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -87,8 +87,19 @@ static u32 psci_function_id[PSCI_FN_MAX];
 				(PSCI_1_0_EXT_POWER_STATE_ID_MASK | \
 				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
 
+static DEFINE_PER_CPU(u32, domain_state);
 static u32 psci_cpu_suspend_feature;
 
+static inline u32 psci_get_domain_state(void)
+{
+	return __this_cpu_read(domain_state);
+}
+
+static inline void psci_set_domain_state(u32 state)
+{
+	__this_cpu_write(domain_state, state);
+}
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
@@ -187,6 +198,8 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
 
 	fn = psci_function_id[PSCI_FN_CPU_ON];
 	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
+	/* Clear the domain state to start fresh. */
+	psci_set_domain_state(0);
 	return psci_to_linux_errno(err);
 }
 
@@ -409,15 +422,17 @@ int psci_cpu_init_idle(struct cpuidle_driver *drv, unsigned int cpu)
 static int psci_suspend_finisher(unsigned long index)
 {
 	u32 *state = __this_cpu_read(psci_power_state);
+	u32 composite_state = state[index - 1] | psci_get_domain_state();
 
-	return psci_ops.cpu_suspend(state[index - 1],
-				    __pa_symbol(cpu_resume));
+	return psci_ops.cpu_suspend(composite_state, __pa_symbol(cpu_resume));
 }
 
 int psci_cpu_suspend_enter(unsigned long index)
 {
 	int ret;
 	u32 *state = __this_cpu_read(psci_power_state);
+	u32 composite_state = state[index - 1] | psci_get_domain_state();
+
 	/*
 	 * idle state index 0 corresponds to wfi, should never be called
 	 * from the cpu_suspend operations
@@ -425,11 +440,14 @@ int psci_cpu_suspend_enter(unsigned long index)
 	if (WARN_ON_ONCE(!index))
 		return -EINVAL;
 
-	if (!psci_power_state_loses_context(state[index - 1]))
-		ret = psci_ops.cpu_suspend(state[index - 1], 0);
+	if (!psci_power_state_loses_context(composite_state))
+		ret = psci_ops.cpu_suspend(composite_state, 0);
 	else
 		ret = cpu_suspend(index, psci_suspend_finisher);
 
+	/* Clear the domain state to start fresh when back from idle. */
+	psci_set_domain_state(0);
+
 	return ret;
 }
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

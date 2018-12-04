Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7EDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:46:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA4220834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AZP1IqKb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CiRdQNWV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="btzc5G+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA4220834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kAOUvOlwVzRVWz3Dv9ou+j0SSohM8kf7Rb9ZUFepgsc=; b=AZP1IqKbeFSCjKBon0GBgf0Im
	MLix+GXXJiaj1i9Ly+c+zgrjIRVgrQmvoUqNLed+79qO6VdtyDzEiVIomHfJ54CMbb9ZG45b0nHNj
	ra/lHMZhnjlO/DmunymaP4GcmdaZU5VIECEiqX3FGiVAcWSlfE5JG8qpO0XpMuMBJRVzqb6K+w0X1
	rN5jkO8uP0aDtka2q7bMWA5YZslJvWHhMH9Glzynp7NcuTC3yVV8gnR7PRYPBM1rzPGuBayKGkWrx
	HpiGo3IKuqMxbA4DIaRTkFl6W867nzCEyPPmgAUIQF5jwbOqZtP/xlXGurrMpsAIae4AJMxhVFsyF
	ch7mC7CUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFhy-0003C6-At; Tue, 04 Dec 2018 18:46:10 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFhu-0003Ad-G1
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 18:46:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id A76F660B12; Tue,  4 Dec 2018 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543949155;
 bh=ZLGTIeBFFVX1ZNJJ5w0lXe7Xj+C8O0WjP0rfloUjyvU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CiRdQNWVuVWhcbGfTBKiRC2eVeELWng4b+7X+2XOmzPVao0sAdJsIWTPYXGclau/9
 h1t1SdAm05aX93ZK5mX6PZ2hLNtZ2tlOEKfsNO0tOdL4ujfmbQCPQ/5fiukbDX1AVC
 9rOpaiSVrp2HM7WmP9YguAm7XNpWZ5STW30B6m6U=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: ilina@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 61A406014B;
 Tue,  4 Dec 2018 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543949154;
 bh=ZLGTIeBFFVX1ZNJJ5w0lXe7Xj+C8O0WjP0rfloUjyvU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=btzc5G+3S6o/GN/hS89p4Zk4ssf9cnb3VaolKX11/58z3GS5YILrCmYzHqy0kIGkp
 UafFlXdbusfbGnGp8kv/H7gQEm6HwOI8YEShvdf9D3PbHBpEdmwmOk4I34Ywx43eHT
 0OTKtL66oFbkmgd0M8K/G/Jw+mHsuMWIkbBVAw2k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61A406014B
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Tue, 4 Dec 2018 11:45:53 -0700
From: Lina Iyer <ilina@codeaurora.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 21/27] drivers: firmware: psci: Add a helper to
 attach a CPU to its PM domain
Message-ID: <20181204184553.GO18262@codeaurora.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-22-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129174700.16585-22-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_104606_580055_3B838987 
X-CRM114-Status: GOOD (  14.63  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>,
 linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29 2018 at 10:50 -0700, Ulf Hansson wrote:
>Introduce a new PSCI DT helper function, psci_dt_attach_cpu(), which takes
>a CPU number as an in-parameter and attaches the CPU's struct device to its
>corresponding PM domain. Additionally, the helper prepares the CPU to be
>power managed via runtime PM, which is the last step needed to enable the
>interaction with the PM domain through the runtime PM callbacks.
>
>Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>---
>
>Changes in v10:
>	- New patch: Replaces "PM / Domains: Add helper functions to
>	  attach/detach CPUs to/from genpd".
>
>---
> drivers/firmware/psci/psci.h           |  1 +
> drivers/firmware/psci/psci_pm_domain.c | 19 +++++++++++++++++++
> 2 files changed, 20 insertions(+)
>
>diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
>index 05af462cc96e..fbc9980dee69 100644
>--- a/drivers/firmware/psci/psci.h
>+++ b/drivers/firmware/psci/psci.h
>@@ -15,6 +15,7 @@ int psci_dt_parse_state_node(struct device_node *np, u32 *state);
> int psci_dt_init_pm_domains(struct device_node *np);
> int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
> 			struct device_node *cpu_node, u32 *psci_states);
>+int psci_dt_attach_cpu(int cpu);
> #else
> static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
> #endif
>diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
>index 6c9d6a644c7f..b0fa7da8a0ce 100644
>--- a/drivers/firmware/psci/psci_pm_domain.c
>+++ b/drivers/firmware/psci/psci_pm_domain.c
>@@ -12,8 +12,10 @@
> #include <linux/device.h>
> #include <linux/kernel.h>
> #include <linux/pm_domain.h>
>+#include <linux/pm_runtime.h>
> #include <linux/slab.h>
> #include <linux/string.h>
>+#include <linux/cpu.h>
> #include <linux/cpuidle.h>
> #include <linux/cpu_pm.h>
>
>@@ -367,4 +369,21 @@ int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
>
> 	return 0;
> }
>+
>+int psci_dt_attach_cpu(int cpu)
>+{
>+	struct device *dev = get_cpu_device(cpu);
>+	int ret;
>+
>+	ret = dev_pm_domain_attach(dev, true);
>+	if (ret)
>+		return ret;
>+
>+	pm_runtime_irq_safe(dev);
>+	pm_runtime_get_noresume(dev);
>+	pm_runtime_set_active(dev);
You would want to set this only if the CPU is online. Otherwise we will
not power down the domain, if the CPU was never brought online.
>+	pm_runtime_enable(dev);
>+
>+	return 0;
>+}
> #endif
>-- 
>2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

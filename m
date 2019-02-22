Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CEAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:03:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61C620700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SbtO/usX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61C620700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dA3ppTruo0m7bncuHddrv3GUUGFiSsC4F0fjMiKaopg=; b=SbtO/usX7Lbs29
	GdwQJXEt4ReIag4kuGDelJ3VGO1t/mZHOPwB/8n/fuWxoyRtVcIcnWd38ytWTUMdNRsm5SMn+Hb5M
	ErS4ObzYhfgkLNjFuXyrVimwfRcdU5EOmZCQjQNXxgtmL1VIp1oMKM48VmdXYtGxLRitsBI6MxcKv
	yBpM9klVYc+XQ7BiUX+/Rh6CSrr5Eslw8tjuFvMbQ+aS2v2z8dFym4BAnVoOcyDLsOH3jSidssJ+Y
	yRTCAAzYJ4cAiheifE4g9TLMsRMcSgzJZh2O+7nFTCJAQM4vxmcS1zDBxDmAelnRJjuhh7MA3a9tk
	30CcnD14ibJGz3aKtCMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx7fo-0004kX-Ni; Fri, 22 Feb 2019 10:03:16 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx7fm-0004kE-C0
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 10:03:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58DF680D;
 Fri, 22 Feb 2019 02:03:13 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 486573F703;
 Fri, 22 Feb 2019 02:03:12 -0800 (PST)
Date: Fri, 22 Feb 2019 10:03:05 +0000
From: Will Deacon <will.deacon@arm.com>
To: Chen Zhou <chenzhou10@huawei.com>
Subject: Re: [PATCH] arm64: kdump: fix warning message about failed to stop
 secondary CPUs
Message-ID: <20190222100305.GA31945@fuggles.cambridge.arm.com>
References: <20190222014625.107640-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222014625.107640-1-chenzhou10@huawei.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_020314_415339_19A124E8 
X-CRM114-Status: GOOD (  14.24  )
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
Cc: catalin.marinas@arm.com, cj.chengjian@huawei.com,
 linux-arm-kernel@lists.infradead.org, takahiro.akashi@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 09:46:25AM +0800, Chen Zhou wrote:
> The local variable mask indicates non-boot cpus. Just print the num
> of failing to stop secondary CPUs using varaible waiting_for_crash_ipi.

Why? Also s/varaible/variable/

> Also replace two pr_warning with the shorter pr_warn.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  arch/arm64/kernel/smp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 824de70..a4a952e 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -989,7 +989,7 @@ void smp_send_stop(void)
>  		udelay(1);
>  
>  	if (num_online_cpus() > 1)
> -		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
> +		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
>  			   cpumask_pr_args(cpu_online_mask));
>  
>  	sdei_mask_local_cpu();
> @@ -1030,8 +1030,8 @@ void crash_smp_send_stop(void)
>  		udelay(1);
>  
>  	if (atomic_read(&waiting_for_crash_ipi) > 0)
> -		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
> -			   cpumask_pr_args(&mask));
> +		pr_warn("SMP: failed to stop secondary CPUs %d\n",
> +				atomic_read(&waiting_for_crash_ipi));

But now this message doesn't make any sense.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

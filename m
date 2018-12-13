Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B3FC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:42:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF76D20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sOG1cULV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF76D20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6SyQhw26akYmA/ijk8mUTjKf7P3tGONwC5uFOd8Dt/0=; b=sOG1cULV4oMVda
	b6gwi3qQtH2VX1lp6Z+OPEKF4gPg2YdhQyLXG/Ii7y9Bx79Ixv2xWKgH/vW+KRnONUCBv6KB14jU3
	YBZsUcefpHdOsH5VEEoTPSfAF2BIOKZNrhFsZG/5N4Dox1yYTQw69143XnukVUVpsLzhyPLGgEfU1
	Oj6DNq0zhMZ5vv9nIfRaIQr3PwrK1HVggsK8RzciVzvN17k+NmvflS7EHtzAIsHgw4u/Y9/NmGl/o
	7sWW522GzaGnKjA5Yr8ERBa/6UsdnI6nR/9DEkuxMY5uxlMXvmPgkbflkntCK+Hs9cT0Ljfe3/Z43
	fo2ENlF+1DJn/xrqKzZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXT7p-0007bF-9W; Thu, 13 Dec 2018 15:42:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXT7m-0007aN-Si
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 15:42:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC12380D;
 Thu, 13 Dec 2018 07:41:54 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98FF73F614;
 Thu, 13 Dec 2018 07:41:53 -0800 (PST)
Date: Thu, 13 Dec 2018 15:41:44 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH] ARM: vexpress/realview: consolidate immitation CPU hotplug
Message-ID: <20181213154133.GA17614@e107155-lin>
References: <E1gXQA4-0007Cl-Qw@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1gXQA4-0007Cl-Qw@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_074206_930480_C64662B1 
X-CRM114-Status: GOOD (  15.43  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, linux-arm-kernel@lists.infradead.org,
 Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 12:32:16PM +0000, Russell King wrote:
> The only difference between the hotplug implementation for Realview
> and Versatile Express are the bit in the auxiliary control register
> to disable coherency.  Combine the two implentations accounting for
> that difference.
>
> Rename the functions to try to discourage cargo-cult copying of this
> code.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> Please note that this hasn't been compile tested yet.
>
Yes, I had a fix a missed callee site that needs to use unified
versatile_immitation_cpu_die to compile it.

[...]

> diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
> index 742499bac6d0..63c9784f063f 100644
> --- a/arch/arm/mach-vexpress/platsmp.c
> +++ b/arch/arm/mach-vexpress/platsmp.c
> @@ -82,6 +82,13 @@ static void __init vexpress_smp_dt_prepare_cpus(unsigned int max_cpus)
>  	vexpress_flags_set(__pa_symbol(versatile_secondary_startup));
>  }
>
> +#ifdef CONFIG_HOTPLUG_CPU
> +static void vexpress_cpu_die(unsigned int cpu)
> +{
> +	versatile_cpu_die(cpu, 0x40);

This should be versatile_immitation_cpu_die(cpu, 0x40)

With that, it looks fine and passed a hotplug tests for a quick/short period
on my TC2. So for mach-vexpress part,

Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

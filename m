Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C72C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:19:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ADDA2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sznRRqbs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Il6uGhC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADDA2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YUu/iLnyfQjtU7VXOu0GqnW3pGhCoNirYugGRlkdfl8=; b=sznRRqbsBA1ZRN
	T+WCuxyyFa4TGJOdxf334ICmAwJ4Tumn2Z2KbCA9VaG0JtwJWShV7yOJqXwSihPElrbQlC/mBNlZx
	YbMz5z8YF3zYh+ahBKQh2tyHTIB6B7jNqbBHDb3QOyYbHoleJBfaeTOId4NfbQMHW7zwjsuR+NF+F
	QWvEE6016renWzp1ZRDtx4u0d7qrlAgJErwdulrGzMWm2xqBZdPru53cz8bBBVSDXY+r+cBWxYl4D
	qSs/w5bTDTSGWVA4ZGObr3WiJ/a/dOkZWlCDsTZEz0DMdb5yIc+JdDuEC/sMr72nFXWjOT9IC263g
	081EJpprcVBWQ67/oTDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX2Xc-0004it-2T; Wed, 12 Dec 2018 11:19:00 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX2XY-0004h6-QI
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 11:18:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BxKd+YwHGYdrxARq3kXgSHmovZBWuL6oUFFKRzsqLV8=; b=Il6uGhC6ZUbfYIE5BcEkDBQzo
 03hSAnJOP1Y2Lfc5Bds4BhQw0p+rCYpY+kplyswODYYd+kC5BLSA9rNgSeuZouJfB/2p5Hje/MWR7
 FZyxq6PuJ4ty5v02st7ee2IoCIbXglBoAJ1iKW1JM4Fw2uyaHAoDYdYfkrnJg6w7yZxCE=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:54067)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gX2XI-0004Kc-7E; Wed, 12 Dec 2018 11:18:40 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gX2XE-0005JN-3P; Wed, 12 Dec 2018 11:18:36 +0000
Date: Wed, 12 Dec 2018 11:18:34 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/5] ARM: actions: Localize some variables
Message-ID: <20181212111834.GJ30658@n2100.armlinux.org.uk>
References: <20181211080759.3150-1-linus.walleij@linaro.org>
 <20181211080759.3150-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211080759.3150-2-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_031856_848601_729CEE8A 
X-CRM114-Status: GOOD (  15.35  )
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
Cc: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 09:07:56AM +0100, Linus Walleij wrote:
> The ncores and scu_base_addr variables are only used
> inside s500_smp_prepare_cpus() so no need to have them
> static local.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-actions/platsmp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
> index 02d17ed0ca31..98fbcaa764a5 100644
> --- a/arch/arm/mach-actions/platsmp.c
> +++ b/arch/arm/mach-actions/platsmp.c
> @@ -34,11 +34,8 @@
>  #define OWL_SPS_PG_CTL_ACK_CPU2	BIT(21)
>  #define OWL_SPS_PG_CTL_ACK_CPU3	BIT(22)
>  
> -static void __iomem *scu_base_addr;
>  static void __iomem *sps_base_addr;
>  static void __iomem *timer_base_addr;
> -static int ncores;
> -
>  static DEFINE_SPINLOCK(boot_lock);
>  
>  void owl_secondary_startup(void);
> @@ -113,7 +110,9 @@ static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  
>  static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
>  {
> +	static void __iomem *scu_base_addr;
>  	struct device_node *node;
> +	static int ncores;

Do these need to be static?  We only prepare once.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

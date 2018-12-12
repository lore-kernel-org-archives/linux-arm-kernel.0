Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDE6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:30:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C371420839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GXc1csn7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Dw1cQDiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C371420839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vlm1fl5XFmWyE4+1qlI203nvrW9l9O0MTwsa3aXmEeA=; b=GXc1csn796OOZy
	WNWaE4zVVmLS/utP1SMKRXyHYpBl3A30RviMFxejUyU2WDZGExZcZWw9QuubNTv9YpycVwWIR2N5T
	7iYRcIHJdLKInLwV1VAHRIHuGYY/Rx/yv9RDG/wy67ihbzCA/g8cQypLD/UKIfR58g9UtrBceaA5G
	D8mQ4D6Yid0ZbzsuzNeyI8PfrpJ1yxqcSKyFnJN7qYgA9S8CV8ZxI1MaKPl44wjqaT1fqE1fGyRXj
	5uhJ/o65nWOvAlvY86RabP4eEr0EGRtqFk+Of6ZRWYKBpOM3yuHmSomZKQYvvcjSZ+p85xNBOIdBG
	IA1/tiHyKyqYlzNtnEzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX2j6-00012g-9y; Wed, 12 Dec 2018 11:30:52 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX2j2-0000zv-1Y
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 11:30:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NpopePdbSzhyFIzzGev6iBN1iprvdcYgpm8KbmHygE0=; b=Dw1cQDiQ7wOK+lVxIvlSzTQgt
 euwHGwGH87w7RgksBaMi8gUzZ/zFNAaoz2mCLOx0zkwJicchw+j9D2kmkB+wV098c4G4uJJp2Sfoc
 qM+oygXu2DAzL8yyL0T3p2QAKBFirMy0Rc4DLK3oayvMjLhdWmydx1x84ve7em14JAW/o=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:43990)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gX2im-0004Ni-5n; Wed, 12 Dec 2018 11:30:32 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gX2ih-0005S2-ES; Wed, 12 Dec 2018 11:30:27 +0000
Date: Wed, 12 Dec 2018 11:30:25 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 5/5] RFT: ARM: actions: Simplify secondary boot
Message-ID: <20181212113025.GL30658@n2100.armlinux.org.uk>
References: <20181211080759.3150-1-linus.walleij@linaro.org>
 <20181211080759.3150-5-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211080759.3150-5-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_033048_086832_23884307 
X-CRM114-Status: GOOD (  24.17  )
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

On Tue, Dec 11, 2018 at 09:07:59AM +0100, Linus Walleij wrote:
> The Actions SMP boot contain some cargo cult code that
> we need to get rid of: it uses a probably completely
> unnecessary spinlock (the ARM core SMP code will lock
> properly already) and tries to keep CPUs in the "pen"
> (CPU enclosure) using the custom variable that should
> only be used with ARM Versatile test chips.
> 
> Simply drop this and also remove the smp_send_reschedule()
> that no other ARM machine is using to start a secondary
> CPU and just send arch_send_wakeup_ipi_mask() to kick
> secondary CPUs out of WFI.
> 
> Reported-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This patch was made after talking to Russell about ARM
> machines doing pointless "pen holding" and using
> pointless boot locks. Would be great if you can test
> if it simply works like this, make sure both CPUs
> come up, I usually just start a few dummy processes
> and cat /proc/interrupts to see that the different
> CPUs are getting work done.

Provided it does work:

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Also, be sure to exercise the hotplug paths during testing, not
simply "does it still boot".

Thanks.

> ---
>  arch/arm/mach-actions/platsmp.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
> index 26ddc12ea4a7..c19477fed340 100644
> --- a/arch/arm/mach-actions/platsmp.c
> +++ b/arch/arm/mach-actions/platsmp.c
> @@ -36,7 +36,6 @@
>  
>  static void __iomem *sps_base_addr;
>  static void __iomem *timer_base_addr;
> -static DEFINE_SPINLOCK(boot_lock);
>  
>  static int s500_wakeup_secondary(unsigned int cpu)
>  {
> @@ -79,7 +78,6 @@ static int s500_wakeup_secondary(unsigned int cpu)
>  
>  static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
> -	unsigned long timeout;
>  	int ret;
>  
>  	ret = s500_wakeup_secondary(cpu);
> @@ -88,20 +86,10 @@ static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  
>  	udelay(10);
>  
> -	spin_lock(&boot_lock);
> -
> -	smp_send_reschedule(cpu);
> -
> -	timeout = jiffies + (1 * HZ);
> -	while (time_before(jiffies, timeout)) {
> -		if (pen_release == -1)
> -			break;
> -	}
> -
>  	writel(0, timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
>  	writel(0, timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
>  
> -	spin_unlock(&boot_lock);
> +	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
>  
>  	return 0;
>  }
> -- 
> 2.19.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951E4C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:14:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9FA2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YQiKM5aN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Jm5aUOpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9FA2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6cHxKAQjJ+SeSfD05JkrSe9jg8zFbtEfTBPUlTdBgzo=; b=YQiKM5aNcna0XP
	g4MjGNZ88i8/RMeuJnHnmBTUlKOBQ0YiAvL4eTfhI8s6KVV9AmRRLCgEUu3v9+8e5DKnDQbxQyR+H
	VQA1Js3Sf3X+uS9NpUG2psdyx75ksCxvYatlusZ6GLZAplrjjT2MTbmuB6xHeJrpwBvaF7YMZn7ld
	UgtHZb19IIKbIJRuxsp+qEG5aDT7O/RFRnbGLIv1eYxMW7ViOddCSTxvxlldnXjOgL+pFfTv7T/hP
	3BwBxf8L5qQtusJPK9Ckf0Fodfh07rR6DM8JsmSnkP1DpSDZo3OgDHIE2VMnM9lmy4OEJLZFjkt+Y
	XtK0MNfcla7QMz6RNxpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXnIo-0001jA-7O; Fri, 14 Dec 2018 13:14:50 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXnIg-0001Qt-VO
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 13:14:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I+z6LiHczflJfpmQx838ZM5Qt9r6byCH4yniN8uAUIo=; b=Jm5aUOpvXi9S/jy80LxYA0U8W
 /TslPv/juiDEkOUfUq7zwydWz+n1upezTPE7hdKnFPD7uric+isg7L649+uJN5LAtfAmfpfUAmc9c
 hM+BQiY71FB1B9hPxXITT6vevnAfTaFWeVkXzjkMD3v2TWwmYP/bp7yWzqXx0oYED8gxs=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:60278)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gXnGH-0008N4-Gy; Fri, 14 Dec 2018 13:12:13 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gXnG9-0003gF-I7; Fri, 14 Dec 2018 13:12:05 +0000
Date: Fri, 14 Dec 2018 13:12:00 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 9/9] ARM: smp: remove arch-provided "pen_release"
Message-ID: <20181214131200.GL9507@n2100.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVIY-0008DI-MU@rmk-PC.armlinux.org.uk>
 <20181214043923.2gusomvei424vw7m@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181214043923.2gusomvei424vw7m@vireshk-i7>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_051443_152116_8ACE325D 
X-CRM114-Status: GOOD (  27.03  )
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
Cc: Barry Song <baohua@kernel.org>, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-oxnas@groups.io,
 Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, linux-omap@vger.kernel.org,
 linux-soc@vger.kernel.org, Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 10:09:23AM +0530, Viresh Kumar wrote:
> On 13-12-18, 18:01, Russell King wrote:
> > diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
> > index 909b97c0b237..815333fc320c 100644
> > --- a/arch/arm/mach-spear/generic.h
> > +++ b/arch/arm/mach-spear/generic.h
> > @@ -20,6 +20,8 @@
> >  
> >  #include <asm/mach/time.h>
> >  
> > +extern volatile int prima2_pen_release;
> 
>                        prima2 ?
> 
> I haven't tried but this may cause build regressions as well, I am
> surprised on how this passed for you.

Thanks.

These patches aren't all build tested - I don't see the point of wasting
hours build testing when these platforms /really/ need something better.

This is not supposed to be a finished patch, but a patch to get folk
to do something about this issue.

Please fix this issue properly.  I can't give you a patch to do that,
you need to sort it yourself, but failure to do anything _will_ result
in an updated version of this patch being merged.

> >  extern void spear13xx_timer_init(void);
> >  extern void spear3xx_timer_init(void);
> >  extern struct pl022_ssp_controller pl022_plat_data;
> > diff --git a/arch/arm/mach-spear/headsmp.S b/arch/arm/mach-spear/headsmp.S
> > index c52192dc3d9f..6e250b6c0aa2 100644
> > --- a/arch/arm/mach-spear/headsmp.S
> > +++ b/arch/arm/mach-spear/headsmp.S
> > @@ -43,5 +43,5 @@ pen:	ldr	r7, [r6]
> >  
> >  	.align
> >  1:	.long	.
> > -	.long	pen_release
> > +	.long	spear_pen_release
> >  ENDPROC(spear13xx_secondary_startup)
> > diff --git a/arch/arm/mach-spear/hotplug.c b/arch/arm/mach-spear/hotplug.c
> > index 12edd1cf8a12..0dd84f609627 100644
> > --- a/arch/arm/mach-spear/hotplug.c
> > +++ b/arch/arm/mach-spear/hotplug.c
> > @@ -16,6 +16,8 @@
> >  #include <asm/cp15.h>
> >  #include <asm/smp_plat.h>
> >  
> > +#include "generic.h"
> > +
> >  static inline void cpu_enter_lowpower(void)
> >  {
> >  	unsigned int v;
> > @@ -57,7 +59,7 @@ static inline void spear13xx_do_lowpower(unsigned int cpu, int *spurious)
> >  	for (;;) {
> >  		wfi();
> >  
> > -		if (pen_release == cpu) {
> > +		if (spear_pen_release == cpu) {
> >  			/*
> >  			 * OK, proper wakeup, we're done
> >  			 */
> > diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
> > index 39038a03836a..b1ff4bb86f6d 100644
> > --- a/arch/arm/mach-spear/platsmp.c
> > +++ b/arch/arm/mach-spear/platsmp.c
> > @@ -20,16 +20,21 @@
> >  #include <mach/spear.h>
> >  #include "generic.h"
> >  
> > +/* XXX spear_pen_release is cargo culted code - DO NOT COPY XXX */
> > +volatile int spear_pen_release = -1;
> > +
> >  /*
> > - * Write pen_release in a way that is guaranteed to be visible to all
> > - * observers, irrespective of whether they're taking part in coherency
> > + * XXX CARGO CULTED CODE - DO NOT COPY XXX
> > + *
> > + * Write spear_pen_release in a way that is guaranteed to be visible to
> > + * all observers, irrespective of whether they're taking part in coherency
> >   * or not.  This is necessary for the hotplug code to work reliably.
> >   */
> > -static void write_pen_release(int val)
> > +static void spear_write_pen_release(int val)
> >  {
> > -	pen_release = val;
> > +	spear_pen_release = val;
> >  	smp_wmb();
> > -	sync_cache_w(&pen_release);
> > +	sync_cache_w(&spear_pen_release);
> >  }
> >  
> >  static DEFINE_SPINLOCK(boot_lock);
> > @@ -42,7 +47,7 @@ static void spear13xx_secondary_init(unsigned int cpu)
> >  	 * let the primary processor know we're out of the
> >  	 * pen, then head off into the C entry point
> >  	 */
> > -	write_pen_release(-1);
> > +	spear_write_pen_release(-1);
> >  
> >  	/*
> >  	 * Synchronise with the boot thread.
> > @@ -64,17 +69,17 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
> >  	/*
> >  	 * The secondary processor is waiting to be released from
> >  	 * the holding pen - release it, then wait for it to flag
> > -	 * that it has been released by resetting pen_release.
> > +	 * that it has been released by resetting spear_pen_release.
> >  	 *
> > -	 * Note that "pen_release" is the hardware CPU ID, whereas
> > +	 * Note that "spear_pen_release" is the hardware CPU ID, whereas
> >  	 * "cpu" is Linux's internal ID.
> >  	 */
> > -	write_pen_release(cpu);
> > +	spear_write_pen_release(cpu);
> >  
> >  	timeout = jiffies + (1 * HZ);
> >  	while (time_before(jiffies, timeout)) {
> >  		smp_rmb();
> > -		if (pen_release == -1)
> > +		if (spear_pen_release == -1)
> >  			break;
> >  
> >  		udelay(10);
> > @@ -86,7 +91,7 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
> >  	 */
> >  	spin_unlock(&boot_lock);
> >  
> > -	return pen_release != -1 ? -ENOSYS : 0;
> > +	return spear_pen_release != -1 ? -ENOSYS : 0;
> >  }
> >  
> >  /*
> > -- 
> > 2.7.4
> 
> -- 
> viresh
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

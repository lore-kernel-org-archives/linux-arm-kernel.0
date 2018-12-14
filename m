Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF301C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:39:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61362086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GYutOdxr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7tU/14N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61362086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=76xieHbzW91cyFw+APuAxA/MjlJfjjWDL4BU+TxOFxM=; b=GYutOdxr2Gag52
	44fh496gA3wi3b5HxhOKsZ5OXZ3koEpKbt9LpM8ryGOb9E95g6p+C/keh5wK31NUN3j2HaqLTx1hO
	/iaBTe7UEuvQrqwf88PuJSM01Jnq9A4GS8RJRYzhuvMUKLLMhpox3WszYgulgA3gDB8BF342vzqMt
	BYGLavUshogwQoHhUnQNt/qqZCh8anHhSC/jpoSsFEXad17AqWwP809WMb0iAIwFvRDXgaf5+XzUv
	JOBnwCLY/QmPLtCIi+gmigF7vcuHAltuRInFV+qisl26VoSDpueUaMp8QYVCZfOPYDcZHadrV6cbT
	0Um30/HTJI3EkQNA0flw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXfGI-0000l8-N3; Fri, 14 Dec 2018 04:39:42 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXfGF-0000kZ-97
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 04:39:40 +0000
Received: by mail-pl1-x642.google.com with SMTP id z23so2136787plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 20:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Wm46+gCBb/GrPQsEFMjcLSy/VE1v0jQaxtkPmPGh0ao=;
 b=i7tU/14NTwLoVMEICkqyYZr9CmC5J8bLcHG/RJd4XQPPN/sB0Zy221BXo9IgJafXyR
 +I2u9aJT3SFiVM7ZZnWrLH2ooDA5sox+R48TckRT0oda4E37bCd697nYg02GYgiPGmCF
 8JOVcHm4BURRhqlolAsedj1/Op4Lkh3iJKrvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Wm46+gCBb/GrPQsEFMjcLSy/VE1v0jQaxtkPmPGh0ao=;
 b=EwzjtsPQjy6OWnnqpAZvkZZnrQZrkhj2TNU1fNNjdaiWMZ4Am/vJqiR50AfSAdQSNw
 6k5ppa5o46iW5sB5TMQ4G4/BG0PQGc/IKYKG9DoZ75Isrrdv7LNG1ebtXERXKQADZhas
 1X51Z/26NvDgYYV4daqZE0ricZjZsG71qiaIkd47hhnaZO368p9MtOFpOAit+1jIBsia
 Y9qoWPeFTH8hMlJKxNdQz7wSdkyu7oLtiM3JNUYiq0pzGn1TjkDR+RhqhP6uX2orGC1R
 +TbuYrIfz8JX2ybPIXDwuIC8RT+XE/Ead1g6dPWk6ZHhoEEMMcjsjPqV7r2FkVSX+L0z
 h/Mw==
X-Gm-Message-State: AA+aEWY/7AsqVJ8BR+RphTM8cCufm+wPHYv0Zb1yKruBxXl32pILd07E
 wuJcjXOyckzJqy5Rx4t9K+Aiwg==
X-Google-Smtp-Source: AFSGD/W0S5nekaLD21bR0Iw6PR6NGeVSr5+HQ4VBP9Eiu6iCdda7YE8I1kB77IUhf+tNoVk5at5Z6A==
X-Received: by 2002:a17:902:a98c:: with SMTP id
 bh12mr1541811plb.31.1544762366373; 
 Thu, 13 Dec 2018 20:39:26 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id j21sm4868266pfn.175.2018.12.13.20.39.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Dec 2018 20:39:25 -0800 (PST)
Date: Fri, 14 Dec 2018 10:09:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 9/9] ARM: smp: remove arch-provided "pen_release"
Message-ID: <20181214043923.2gusomvei424vw7m@vireshk-i7>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVIY-0008DI-MU@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1gXVIY-0008DI-MU@rmk-PC.armlinux.org.uk>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_203939_333924_17EF23E1 
X-CRM114-Status: GOOD (  22.58  )
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
 linux-arm-msm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-omap@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, linux-oxnas@groups.io,
 linux-soc@vger.kernel.org, Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 13-12-18, 18:01, Russell King wrote:
> diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
> index 909b97c0b237..815333fc320c 100644
> --- a/arch/arm/mach-spear/generic.h
> +++ b/arch/arm/mach-spear/generic.h
> @@ -20,6 +20,8 @@
>  
>  #include <asm/mach/time.h>
>  
> +extern volatile int prima2_pen_release;

                       prima2 ?

I haven't tried but this may cause build regressions as well, I am
surprised on how this passed for you.

>  extern void spear13xx_timer_init(void);
>  extern void spear3xx_timer_init(void);
>  extern struct pl022_ssp_controller pl022_plat_data;
> diff --git a/arch/arm/mach-spear/headsmp.S b/arch/arm/mach-spear/headsmp.S
> index c52192dc3d9f..6e250b6c0aa2 100644
> --- a/arch/arm/mach-spear/headsmp.S
> +++ b/arch/arm/mach-spear/headsmp.S
> @@ -43,5 +43,5 @@ pen:	ldr	r7, [r6]
>  
>  	.align
>  1:	.long	.
> -	.long	pen_release
> +	.long	spear_pen_release
>  ENDPROC(spear13xx_secondary_startup)
> diff --git a/arch/arm/mach-spear/hotplug.c b/arch/arm/mach-spear/hotplug.c
> index 12edd1cf8a12..0dd84f609627 100644
> --- a/arch/arm/mach-spear/hotplug.c
> +++ b/arch/arm/mach-spear/hotplug.c
> @@ -16,6 +16,8 @@
>  #include <asm/cp15.h>
>  #include <asm/smp_plat.h>
>  
> +#include "generic.h"
> +
>  static inline void cpu_enter_lowpower(void)
>  {
>  	unsigned int v;
> @@ -57,7 +59,7 @@ static inline void spear13xx_do_lowpower(unsigned int cpu, int *spurious)
>  	for (;;) {
>  		wfi();
>  
> -		if (pen_release == cpu) {
> +		if (spear_pen_release == cpu) {
>  			/*
>  			 * OK, proper wakeup, we're done
>  			 */
> diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
> index 39038a03836a..b1ff4bb86f6d 100644
> --- a/arch/arm/mach-spear/platsmp.c
> +++ b/arch/arm/mach-spear/platsmp.c
> @@ -20,16 +20,21 @@
>  #include <mach/spear.h>
>  #include "generic.h"
>  
> +/* XXX spear_pen_release is cargo culted code - DO NOT COPY XXX */
> +volatile int spear_pen_release = -1;
> +
>  /*
> - * Write pen_release in a way that is guaranteed to be visible to all
> - * observers, irrespective of whether they're taking part in coherency
> + * XXX CARGO CULTED CODE - DO NOT COPY XXX
> + *
> + * Write spear_pen_release in a way that is guaranteed to be visible to
> + * all observers, irrespective of whether they're taking part in coherency
>   * or not.  This is necessary for the hotplug code to work reliably.
>   */
> -static void write_pen_release(int val)
> +static void spear_write_pen_release(int val)
>  {
> -	pen_release = val;
> +	spear_pen_release = val;
>  	smp_wmb();
> -	sync_cache_w(&pen_release);
> +	sync_cache_w(&spear_pen_release);
>  }
>  
>  static DEFINE_SPINLOCK(boot_lock);
> @@ -42,7 +47,7 @@ static void spear13xx_secondary_init(unsigned int cpu)
>  	 * let the primary processor know we're out of the
>  	 * pen, then head off into the C entry point
>  	 */
> -	write_pen_release(-1);
> +	spear_write_pen_release(-1);
>  
>  	/*
>  	 * Synchronise with the boot thread.
> @@ -64,17 +69,17 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	/*
>  	 * The secondary processor is waiting to be released from
>  	 * the holding pen - release it, then wait for it to flag
> -	 * that it has been released by resetting pen_release.
> +	 * that it has been released by resetting spear_pen_release.
>  	 *
> -	 * Note that "pen_release" is the hardware CPU ID, whereas
> +	 * Note that "spear_pen_release" is the hardware CPU ID, whereas
>  	 * "cpu" is Linux's internal ID.
>  	 */
> -	write_pen_release(cpu);
> +	spear_write_pen_release(cpu);
>  
>  	timeout = jiffies + (1 * HZ);
>  	while (time_before(jiffies, timeout)) {
>  		smp_rmb();
> -		if (pen_release == -1)
> +		if (spear_pen_release == -1)
>  			break;
>  
>  		udelay(10);
> @@ -86,7 +91,7 @@ static int spear13xx_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	 */
>  	spin_unlock(&boot_lock);
>  
> -	return pen_release != -1 ? -ENOSYS : 0;
> +	return spear_pen_release != -1 ? -ENOSYS : 0;
>  }
>  
>  /*
> -- 
> 2.7.4

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

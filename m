Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F0CC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:02:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2FA2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N6DBmihV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXaoitKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2FA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LfxYC4LFKmRv2XIo/sOCCp2OwJPXppfj4L7w1S4O4d0=; b=N6DBmihVHe8fQ1
	eaKABkZYQhEdmgKH9veqAtlJI+U+cg9BdDmZXUtZyQYT1s/FhgBSpkSc9mRTmH4DGry5SdWR/N5Jz
	tebbY4MLl/b/V3Ouda/MRHBkm91xGfTHUH4FPO/DXZm1XWPxngm2X6J1E9aljGWZOH3gl7amrYw6+
	jBNaY7LdaIkZ154iB1Y7JYy6OOxP8zZHkk5yw3HJgs9t6pMH00OUUfD5daID7KfwTg3CK/VmH2vgS
	7Rf2MPA0L0RJOLxe4o1Nzvs3of/szrakZIKHmnt5SPhXRtuoRQmj0zGG8YWynaZM39FjrMEv35DOM
	WtjGoplXfLZToSZfFnQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXPh8-00040X-0E; Thu, 13 Dec 2018 12:02:22 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXPgy-0003xY-CR
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:02:19 +0000
Received: by mail-pf1-x444.google.com with SMTP id 64so1014320pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 04:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LHuprlnP0hv28Hall877F3lNVwuPuKtOryopyY3gY1E=;
 b=YXaoitKfg53BzKxLh6jINlZxa2uVAAAF0kT3m/GEx5eMdLhm2HRGe7VPgrupWAFg0H
 v3i6wbnKeVfu8zutAT3KWtmYtozvaEuszf5XFYlWnLjLFfcpf0y8dqugFmFGTh04/MJi
 KAVXSIsSAQNzGOelB8Jyy7dQLB+Ev9HuZcse4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LHuprlnP0hv28Hall877F3lNVwuPuKtOryopyY3gY1E=;
 b=eZn0lJ1pfn8gXPfutjyOxaE435iPQiBb0jcAZIGsSZPP8r6A2ZKuhCJYf6Hr1mMlOt
 fvGgXf0WQR4vIp5qgXiczcCZsdnU0z0Aaa94GOY3KmV70VUGm3ZO5J8Qxg08ZeO3bC5a
 MBepUiSoN403od7/6hIZ2UaHkpR8CEvRII+Nthbud+LQ5dp6Zk5/XInqIEKR++dPp2d2
 iC+7rJKzT80q/cUB00ZjtZ0gdRjNDHqFLi+wV8UeIX3RJ9B2C5jOr4lErjJIua2LRS8w
 kDmU9RMadq/zCyDyvY46ugiSuPE/zGCneSiR2Wt0PguBu0zD4uPoiQoBN5GsM1OOk9LI
 R6cA==
X-Gm-Message-State: AA+aEWZ91NhqT5RuYJWgFInthAXzlt0QRZa0/XyKuCxH81upy+mlZccR
 o6dxrOqDv742Tn3DOxBXq3VMExf0nw==
X-Google-Smtp-Source: AFSGD/XZiY44Vmctum79wR6GUzgv0MifWnPPdehzSjh07wWvoy1J9gjzaJiPDk0B3yWsrY4Rgb+R4w==
X-Received: by 2002:a63:5722:: with SMTP id l34mr21676934pgb.118.1544702521349; 
 Thu, 13 Dec 2018 04:02:01 -0800 (PST)
Received: from mani ([103.59.133.81])
 by smtp.gmail.com with ESMTPSA id d11sm2331352pgi.25.2018.12.13.04.01.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 04:02:00 -0800 (PST)
Date: Thu, 13 Dec 2018 17:31:53 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Russell King <rmk+kernel@armlinux.org.uk>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 5/5] ARM: actions: remove boot_lock and pen_release
Message-ID: <20181213120153.GA18173@mani>
References: <E1gXPav-00064t-KY@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1gXPav-00064t-KY@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_040212_436327_E192A35D 
X-CRM114-Status: GOOD (  19.29  )
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
Cc: linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org,
 linux-actions@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 11:55:57AM +0000, Russell King wrote:
> The actions SMP implementation has several issues:
> 
> 1. pen_release is only ever read and compared to -1, and is defined in
>    arch/arm/kernel/smp.c to be -1.  This test will always succeed.
> 
> 2. we are already guaranteed to be single threaded while bringing up a
>    CPU, so the spinlock makes no sense, remove it.
> 
> 3. owl_secondary_startup() is not referenced nor defined, the prototype
>    is redundant, remove it.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Hi Russel,

Is this patch a superset of https://www.spinics.net/lists/arm-kernel/msg694546.html?

Andreas: Will you be able to test this patch or Linus's series on S500 based board?

Thanks,
Mani

> ---
>  arch/arm/mach-actions/platsmp.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
> index 3efaa10efc43..4fd479c948e6 100644
> --- a/arch/arm/mach-actions/platsmp.c
> +++ b/arch/arm/mach-actions/platsmp.c
> @@ -39,10 +39,6 @@ static void __iomem *sps_base_addr;
>  static void __iomem *timer_base_addr;
>  static int ncores;
>  
> -static DEFINE_SPINLOCK(boot_lock);
> -
> -void owl_secondary_startup(void);
> -
>  static int s500_wakeup_secondary(unsigned int cpu)
>  {
>  	int ret;
> @@ -84,7 +80,6 @@ static int s500_wakeup_secondary(unsigned int cpu)
>  
>  static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
> -	unsigned long timeout;
>  	int ret;
>  
>  	ret = s500_wakeup_secondary(cpu);
> @@ -93,21 +88,11 @@ static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  
>  	udelay(10);
>  
> -	spin_lock(&boot_lock);
> -
>  	smp_send_reschedule(cpu);
>  
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
> -
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

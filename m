Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AFCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:41:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844F52075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zc2wljDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844F52075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lPeKfO0KByq1pFpmbysyEMHlym3K8gd3fkccxtyyBE8=; b=Zc2wljDiNWG+fc
	uGH+6NeLng8O2CoCBNUicMT8Zbkl5yTnhmt39po4mArfMzCKc1eoWJJrXfHZWg8a1X3sDuypewOBB
	pI20fskq8rQylefrbhxU9XUC5eb/DvqWUaM9dHlmNtxLlGFxtMLDk7snzB365P9etWXmLIdET/XcI
	fqhvK4NIE4iMTUsPw2SbtSlA0XOWWYWxVJI6/WxKFwGtx1Ux5OgoFBsrBKtzTo0QTEdGCMf2mYFEG
	nZkcmZxsbpI1STsn24YTOxMxRiJZPNAbqpScdSHeTwxGHx5X0EbkXvd//j/IjHMBD9sOiIZuT/e76
	7L9u+jfO1laZ2KCzPVzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gucna-0001wR-8K; Fri, 15 Feb 2019 12:40:58 +0000
Received: from mail-qt1-f173.google.com ([209.85.160.173])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucnX-0001w8-CP
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:40:57 +0000
Received: by mail-qt1-f173.google.com with SMTP id y20so10576033qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 04:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oWP6xAHnYvItQWo7Np1VMBPbbSPhSuumEFIjrDoboCI=;
 b=Nf0cfVPg0yRBWWTX6dfelF7IiUNhxhKPHJfJNViT7wt+nIPKOyWZ0+Fzfit2IDBzrC
 2YVhPjVyRlGZVEH3TzSTvmC5sL9fdSNXzkQ4gRDmhi+IjbpIUkpzTqIhVnsDfFmF9CrH
 IG93Palwz/D/nosRMkWUuTNsZzkvTM8ug8SQwaCER3uvvdt02xGLCDtfd7aZUKM44bcX
 AyPP1aBUiWI+R2abqtSLX2pqPKMtrBjwG/3cj39BNqjfpRrcahxdNn1s7otram6EyVTf
 nTdUf8JoLuhJCXuntyKJcfIaQj5rUJMHgWayKPOGf6G9eObO1yn8pmOKSkLpjITuzMPr
 /BrA==
X-Gm-Message-State: AHQUAuY3Th+x6Vbw7nu5DhRqZ+Ghd87OWYZoz+DlCO21VFax3E5sjlnG
 gM/2H8uxBgSzbYjIxpXdVeokTIo5TXkDldpNLgs=
X-Google-Smtp-Source: AHgI3IbW4oJO22s/ehgnYNPSBZuikgL/3vLtDILgCGW3qXscB+Ge7gUFujvApRH+OYiEWiwVP8nnfUe81C5cuamxfTo=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr7202237qtb.319.1550234453648; 
 Fri, 15 Feb 2019 04:40:53 -0800 (PST)
MIME-Version: 1.0
References: <pull-1548949376-511005@atomide.com>
In-Reply-To: <pull-1548949376-511005@atomide.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 13:40:36 +0100
Message-ID: <CAK8P3a1Me9rDbvv7ZTybnxMP=yUNr+aSRfdGUfevf=tXJfo2kQ@mail.gmail.com>
Subject: Re: [GIT PULL] omap soc regression fixes for v5.0-rc cycle
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_044055_425037_DAEACC56 
X-CRM114-Status: GOOD (  12.39  )
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 4:44 PM Tony Lindgren <tony@atomide.com> wrote:
-----
> SoC fixes for omaps for v5.0-rc cycle
>
> This series contains two SoC regression fixes and one uninitialized
> variable fix:
>
> - Fix inverted nirq pin handling for omap5 that started producing
>   warnings with earlier GIC direction checks and took a while to
>   understand and confirm. Basically there are two sys_nirq pins
>   that are bypassing peripheral modules and inverted automatically
>   by the SoC and need to be handled with a custom irq_set_type()
>
> - Recent ti-sysc changes caused a regression to the pwm-omap-dmtimer
>   code where the device tree handling code for timer source clock
>   gets confused. It looks like we can remove that code eventually,
>   but for now we just drop a bogus pm_runtime_irq_safe() for the
>   timers with the related quirks caused by pm_runtime_irq_safe(),
>   and have the standard assigned-clocks and assigned-clock-parents
>   deal with setting the source clock
>
> - Fix potentially uninitialized value for display init code if
>   regmap_read() fails

Pulled into arm/fixes branch, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

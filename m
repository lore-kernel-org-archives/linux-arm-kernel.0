Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D5EC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:52:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBD920989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sUf5tfjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBD920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Trkn3raHvD+CE+X4uxCP61a4l0R1JKcvg8Mda2HGiIA=; b=sUf5tfjVr1bj+z
	oxYyWgrBYlQrlPoi/VLraWIdCRneQSHG3WYCLnaFoCa67elQSAKL2h7eoywvFvJCFyiRmc2g75+7y
	0NK69loqVyVY8vr8x0vjjkLt47ouJeNrH/LbWQRrQj3Et5/CofJKBbnlMIMGLzHZRCpAUM7aV1b0Y
	ukU3Pvu2d6f1ye5xTnz9A22h6UZ7HRLiWXtiSgThbP7Z3HWligAEW27mIt/u2GyxNJdSkbGzbDyHC
	EuibJkesgq8Nyxz1ZmkVPM3WSBmpc/MPbJt6yLy7brBaQie6y60Br+abYMCXAsvzlgWX+0Wu9mVco
	sKGdDvLG9WU5OOYFbfeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goxml-0003Hv-SS; Wed, 30 Jan 2019 21:52:43 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goxmf-0003HN-Hi
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 21:52:42 +0000
Received: by mail-qt1-f195.google.com with SMTP id u47so1329296qtj.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 13:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D5MCUPhsuNxJMpwlVWhHP+WACgMlu/aXwgrfIAXemW0=;
 b=S5mQ2BQgp5/OEyHW649j1mmtjQwH1N9arjP4g3BGR6YS8vyofM2iqA1nmsQmXlpPC1
 QDFLcCMMuqXBWh33Cf81rM7zCTfpC+9bvM1T4A80zb7wDapSopmO30uBbq4N5H67a5X3
 3WvPSgI+zMajAFIuGijE9fcuOidjCQ9wbIFhBzCNp1g4ndwfG7wNkDHqzJb+wjpT0GdP
 UEGXcK9e1an052pDk/FKYbiax1HJ6yM5EgmFsSYiW1gjGy8X9KPHqCIfDoesjLnpezWq
 a+2r3NAuTo1IZ+Ev5rBVlcF8GatPl3rltcZspV5pPUrWT4Hsfun51VEHXL/J/m59NZfr
 FuhQ==
X-Gm-Message-State: AJcUukclp46362Izstf6nCqQTzFNNvFr7x0O30v8W6Nev9MpT/x9gCXk
 3ytGFn9B8cDiU5gN7W+E7Pec8rGkdNn7LhIdwyY=
X-Google-Smtp-Source: ALg8bN5E5AbYhFvlTjYCWilnGKSPwIvbHVZ9bQSXYy9c4jOCtnElqb+QCaciombgv2NKYvCoZ6Agk3/1bZ42fgIviiM=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr29506805qvm.149.1548885156669; 
 Wed, 30 Jan 2019 13:52:36 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdYRiWZbkduBRxQdPC_1hJjQJCYhX9NFB31t1Su1CSBNyw@mail.gmail.com>
In-Reply-To: <CACRpkdYRiWZbkduBRxQdPC_1hJjQJCYhX9NFB31t1Su1CSBNyw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 22:52:20 +0100
Message-ID: <CAK8P3a1GK3sZ+1pFS-4y5EgsV0ttA0OsYrmdmSzrJc8me26J7A@mail.gmail.com>
Subject: Re: [GIT PULL] SPEAr defconfig update
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_135241_298854_5056A649 
X-CRM114-Status: GOOD (  11.44  )
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
Cc: viresh kumar <viresh.kumar@linaro.org>, arm-soc <arm@kernel.org>,
 shiraz hashim <shiraz.linux.kernel@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 1:30 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi ARM SoC maintainers,
>
> this:
> 1. updates the SPEAr 3xx defconfig
> 2. replaces the fbdev PL11x framebuffer driver with the DRM PL11x driver
>    in the defconfig
>
> This has the ACK of the SPEAr maintainer Viresh Kumar. I don't think
> there even is a SPEAr git tree so I send this from my GPIO tree. If they
> have other plans, they can say so now :D
>
> Please pull it into ARM SoC in the appropriate place, next kernel is

I have a similar comment to the nomadik update, though there
is only one non-obvious option: why do you turn on CONFIG_PREEMPT=y?

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

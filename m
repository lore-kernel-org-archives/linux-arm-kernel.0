Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88223C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:29:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5494820672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mWW9ZFrA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1XHZgDaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5494820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XrX3Yabbxv64xrxSOUEYCaF8OLUjFHRj7UIXz5g0jdI=; b=mWW9ZFrA82YJdU
	GT/JFuvWG1UvVkgOco71C09VAiJvJLDmUGdazUXD47tS9Qknokoq8JAV6Qqkhx7I/USYbipwzK2Hb
	ncherT2uxMgRSutHV9aBJ0OSTwiJNO28vJeu6fuTFtVtH/nnG0+Ej0PgVusAk/W/CmlKNlOH4YxtX
	upA3DP/gTlikEl51/6SCdL1Q/lBzjZLlWeqoA+OokIXwcor7xJK4sScn4TGzhNOrTLTkaLloKI/jS
	dl6hrnyNaa99EXLy72JusI5T2iekExNbuPF5Sfl99N7CtmUb2WWaG4CqiiwlPqRi5EEskQLOSzaLq
	0u/BiV3gZvPlTABKothw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXD0H-0001CZ-75; Wed, 12 Dec 2018 22:29:17 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCoi-0007Yh-EK
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:21 +0000
Received: by mail-lj1-x241.google.com with SMTP id e5-v6so12263lja.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=EOSFiqST9jUIOZg+9siKNV/8a4h+KeMDJAfX+RVgF8I=;
 b=1XHZgDaXynOeiD0F2QvntmxQsUbFtqihMSRTnSvCHf7pTwhDPcjJ0wN2PuSBeQgYAg
 cBygs3H9OlfW8h+NX59gvXWoU8Le8ISknorgLCVp1kM6AbYE6+yZBYZJQgljWOQTZj/a
 jDDsgUrj9a+I0/xoQDmrmIef/Xt+Nc5ZePBmNgPzyA9BMkOt4LyD1eEdfKhmlVNqLOWL
 jQxWxgu+P5FntWSrYdS15WFIUJUvhSvpQtmS8jjrOcuJQYA47YQkARZO1Idab4bL2p93
 OX+Cvx447OzCDnn7Zyu/b2fxNFcW1x5YdJf9c9R2Z9ky88ohMSfPnyPyBqHrHyDt07IR
 ykKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EOSFiqST9jUIOZg+9siKNV/8a4h+KeMDJAfX+RVgF8I=;
 b=jP2pNlC5BpPnkF3qv4ZSYcjPDTFKmQhLoDsYtO6bQk70hbsMAHPu11w2pBdLBAZg6I
 N4nZxrGMTguymbc63twwcUzNKonOcNkWg+ijVVqrOovkXOIvjMcpxvxfM2tOIznlvhBX
 CAvghkbXZJQ3HG8wyJ5CHIPj4Fl1jO9xYLYAMrIh1S9hZ8Wuo2KNR5o8dztQIMJvrNFs
 +xTU8FGfB99/sPa07TNNuj/k08osFjimyw8Sq+hUu702qA8a7WdhflJBhCYz5Xo0sl/s
 7am54+TArftbciKFDv42uyc48qFSHsUJhL6/JF3BmSOdCbE2dB7W7lG/rfPi6TN5h14P
 brXQ==
X-Gm-Message-State: AA+aEWYWlf3M3ORvfTAI6VrmubvmHMMwTcSOfokoKNLtXa9xkR/9DilG
 /uJC1/145fldmbepF7dt6G6jIQ==
X-Google-Smtp-Source: AFSGD/Uonc3cqenAzPz+Rl7aJq/9mEyRcEOWep6AlhDwOJ9oHeqF92hJmjGCmP5yNfSaMYHTOrbCvQ==
X-Received: by 2002:a2e:868c:: with SMTP id
 l12-v6mr14837372lji.90.1544653028807; 
 Wed, 12 Dec 2018 14:17:08 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id i143sm712lfg.74.2018.12.12.14.17.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:17:07 -0800 (PST)
Date: Wed, 12 Dec 2018 14:02:02 -0800
From: Olof Johansson <olof@lixom.net>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [GIT PULL] Gemini changes for v4.21
Message-ID: <20181212220202.hpovoj2w32gvqrgj@localhost>
References: <CACRpkdaoLLt6CZ0OT=cRgg0R0435hdx3hdTdEvW4Wk-6S80bwA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdaoLLt6CZ0OT=cRgg0R0435hdx3hdTdEvW4Wk-6S80bwA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141720_510760_F260905F 
X-CRM114-Status: GOOD (  18.22  )
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
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 08, 2018 at 11:33:54PM +0100, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> here are some Gemini patches for v4.21, mostly
> related to me getting flash to alternate properly on
> two routers and the USB bindings being in place so
> we can at least register the blocks. Then some additional
> flash-related partitioning and parsing fix-up.
> 
> Please pull it in on some appropriate DTS branch!
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
> tags/gemini-dts
> 
> for you to fetch changes up to f18fd0f560eb3b798f9835fbd09fad1a27235e13:
> 
>   ARM: dts: Bump Gemini platforms to use 100ms debounce (2018-12-08
> 23:21:49 +0100)
> 
> ----------------------------------------------------------------
> Gemini DTS updates for v4.21:
> - Fix the erroneous partition table on D-Link DIR-685
> - Multiplex flash usage with other usage using pin control
>   handling (merged to the MTD tree)
> - Use the RedBoot partition parser on SQ201
> - Add the USB blocks (DT bindings merged in the last merge
>   window)
> - Bump the debounce times a bit to avoid bouncing
> 
> ----------------------------------------------------------------
> Linus Walleij (5):
>       ARM: dts: Fix up the D-Link DIR-685 MTD partition info
>       ARM: dts: Enable Gemini flash access
>       ARM: dts: Fix up SQ201 flash access
>       ARM: dts: Add the FOTG210 USB host to Gemini boards
>       ARM: dts: Bump Gemini platforms to use 100ms debounce

Merged, thanks!

It might be a good idea to previs these patches with the platform (most others
do), so "ARM: dts: gemini: ...". Something to think about for future material,
this is fine for now.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

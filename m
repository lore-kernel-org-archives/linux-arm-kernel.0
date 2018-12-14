Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F4BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:10:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDCB20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aznO+ZZ4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ap2L4HzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDCB20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SJyOtijjCYoaP+kPAkJx+/sN1q1i3legBYhjQZlkoUE=; b=aznO+ZZ4unLsLQ
	mM6wSFA5YktVZafA3qY164fCGwGelNJIBfQXkd9kOOYZgZiI9kwgZxPaKDyQ7KNAk5BSXjVZKXRF8
	uwzZWfy/pQ38+i3+J6sJGqnfIIqKSPBmPYSUDy6u8sfRLZQzl/xyC1TBwWA15UBn0iTRePCgWEpYW
	8eO826mAA6GBzUYVmA4BqwIzLFlUfVkYVYZ1S6b2jeslydEXtvetHxpfbf0TwvtmEEuSZC9UM6++2
	RMRsGoYwH/J5hnlrOzJ/r9gFdigfJ3kZ+EcDR8svjLqXE6CAVKVWSDPjYGmRhl4TqmETiTwYveBLo
	Sp6xVyzSytpBico2Sgtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXp6w-0008W7-Di; Fri, 14 Dec 2018 15:10:42 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp6u-0008Vn-80
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:10:41 +0000
Received: by mail-lf1-x142.google.com with SMTP id a16so4500989lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 07:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ySdAwoMV9ecWwNuVXyN/PwdKaCodW7say3bAls6Pdzg=;
 b=Ap2L4HzILAnfGHpGEPa/2XwnCTQwScCXhJuDuJLlCP3wjfVCsFTGM+nNMao6M9yBsG
 KPchK5gxbDhPyWu0oNthsMucsPwwEOINsUgoorGKdGuONHM/bDA5I9du5gsUHh44MPvv
 yO+Q33zBc1EgTj0hmq1tHLwNQh70Lex7WVP3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ySdAwoMV9ecWwNuVXyN/PwdKaCodW7say3bAls6Pdzg=;
 b=toIq9wCWytp1InLNe7aW+XeAPSKNeGgD6wF+hhGgKzXzGGMy/xGjIgCYN8HgXmHY00
 GxkpTsd4NMx4idd37VFG/kEtOEzBaHwv6KAM1fAGRuJtnZJiv/307wx9osvjsJaHggWA
 2Ey+p6OU3myDkXCWZVLKyu7/Hixwj2xpRnazJDphRxG4uGQeKY9OMfvqg1UKSNY+ze64
 JedN1ZxZDPLpyaGODZEpRIiM1xWh2aeiNDQW/14c89bi6kOSFPJ1nSIJWW+SQHTA55z9
 8DerDKAM9IkpKg1Xrzm9qFT2IOPonTnlNWGFq/5upN4nMBO6tPCLcZj5DJabHM0xnVYA
 zV9w==
X-Gm-Message-State: AA+aEWae406VbplgP3NUnLAik6WqNNHh9Cc8IklcH4TiM5fb+6cOLi29
 5CFQlcxJ4mn9k9ujPWJgcaPbNRjadxX7yaZcV81vRw==
X-Google-Smtp-Source: AFSGD/WChux3sVVvk3mxQNw0RHyH+xiF7l3NtOPybnzzi8fzGKAyhkbnfjJjYwUZ7e54fDYZkspAE3Qf1HwembYzav8=
X-Received: by 2002:a19:c801:: with SMTP id y1mr1988556lff.53.1544800228491;
 Fri, 14 Dec 2018 07:10:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.50931fbda5c95345087740e4c1ef5a57fdd53480.1544104801.git-series.maxime.ripard@bootlin.com>
 <fe8fc20bb7850e5f829c1b8d15beea7040dc6c9a.1544104801.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <fe8fc20bb7850e5f829c1b8d15beea7040dc6c9a.1544104801.git-series.maxime.ripard@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Dec 2018 16:10:16 +0100
Message-ID: <CACRpkdZy6wcAe1ypZaephqLVuvSDdZeGWyvpDBqg0ryZkm8hig@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: sun7i: bananapi: Add GPIO banks regulators
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_071040_289717_989765D8 
X-CRM114-Status: GOOD (  10.46  )
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
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 3:02 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> The bananapi has all its bank regulators tied to the 3v3 static regulator.
> Make sure it's properly represented.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

I suppose the DT bindings are already modified?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

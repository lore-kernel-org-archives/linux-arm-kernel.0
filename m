Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7241FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:40:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E23C218C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LoI9Ycuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E23C218C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VNZg5PLUbha2v5B6r9UpRFsoTFTTYV3xYTHolPZBKUY=; b=LoI9YcuwG9LtDm
	EXHm6iRiY2HLiNQUwsbMNdQn12G2GPOGVNO5LiQ06Om0B62jP14PZ+eQ3djLWT40XoBhz3qt17qvt
	Rq33EzXvDrRwRjv1YMTuSYmT1uXO7BotLs75jFY0A8DF2kYuyFByqIN+xc2DVcSu0+ip1VKJVxLA4
	0sIhM729++TZL2RFJzo4Aj4iiKXwteEEE84U27gl32dFjiYtTmDtWqBcBhfRvfzrwNter1JjxlgZS
	Etm8gsdXjFU+sRYvpog/B3SFumJJ36Q4dJO/0nfskO5ar1n826NBGJJ7MOVG7AaVrjGOk1+kZjHrp
	JgeT1qs7z8CqR8ME/uDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0RH-0002C5-4c; Thu, 20 Dec 2018 15:40:43 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0RB-0002Ai-Cn
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:40:39 +0000
Received: by mail-qt1-f193.google.com with SMTP id n21so2248671qtl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pV9AM5cdfzcDN1+CFOctF+wRn0Ok+yCU5OBlICVv4x0=;
 b=QNvzkmwnjLBddtdTBmn53ChewoKTpJZ2CgAhPvBopUIlR0ElksVW7fYVsR59ckM235
 a81NlxL5O7XNK9MibmYPPOcLNSbY+PcNCikawDFnaff3k0rkFDwAa6VSOnLQCHeoFmCY
 B8TyCsSFjJIJOnBMgz0/sikS+WL/EyMZ0ZG0RNkNSWain+XCT5oaDMcpjYC3L9LVwMAb
 0Zer2tYL0xA9uwiRNOrwyYzBoIhqmSQWADUiBUUy94J6x1LRki6l27LVg1F0wKLdNegd
 J4N4cUJ1913naqNqwouEh7Uj7I7h+sdBqDrmi48iZht+Z0YnZTIouti12cSCh2PP/Tys
 H7sw==
X-Gm-Message-State: AA+aEWZLnMNpDUxyoZSBcItsFwzGR8mBAvGvWsYMiDRnJ1WygCGApXq5
 Whkp4dqZz/bT8cTmOvWN6LWvdnmug6GceXgxOdMhG00Q
X-Google-Smtp-Source: AFSGD/WOj5i5GGY7eAwbVWBmE0eKNSeL96zdq1diXMZyDrISstklTTSn6OARdz+g8XfLNPXvXpYRPSmT6ma3Rfw53AY=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr26232577qtl.343.1545320426473; 
 Thu, 20 Dec 2018 07:40:26 -0800 (PST)
MIME-Version: 1.0
References: <20181214095538.23714-1-maxime.ripard@bootlin.com>
In-Reply-To: <20181214095538.23714-1-maxime.ripard@bootlin.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 16:40:09 +0100
Message-ID: <CAK8P3a3ckuSfvWYOBVuCO21LT_kq75eMTTOeRccHxMn5TqRr_w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: suniv: Fix improper bindings include patch
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_074037_428064_CC3AA4E5 
X-CRM114-Status: GOOD (  12.35  )
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
Cc: mesihkilinc@gmail.com, Chen-Yu Tsai <wens@csie.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 10:55 AM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> The clock and reset bindings are going through different trees, and while
> the patch doesn't contain any value defined in that header, it still
> includes those files and result in a build breakage when building the DT
> without the matching clock and reset patches applied.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>
> Hi Arnd, Kevin, Olof,
>
> Could you apply (or squash) that patch on top of the current sunxi dt
> branch?

Applied on top of next/dt, thanks for the fix!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

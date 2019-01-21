Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30B8C2F3A0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:41:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A251720861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="apjIJd4l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqyfWeGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A251720861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WwN4BAzXvtTemP69HUg6Nm9Wf9sJ1/1u0f75YBISH5w=; b=apjIJd4lrFLeMr
	b+T92/2ZrJQ4H7qUgwfDqND4cyg7utVBL1XjgJmoxPhSkFtM8rSx7wRcYNDnISwEP/O/IccB2tDkc
	q1QG976Ff5SSPtw2ZrxmKIQiloTCz6bsEwCiE/jHH0Xv384LUd3qz3FGQbztF90UdLh/HKScUIMMO
	8QHbZjPzmUF6uy+8RznysX/jvzfbDAI+oige/UCBiOdjKesRjQbET9SjK2O3L6GAxxYK5fRc1QlQ7
	n789pFvVl+jOSYGHMieYdFFoozRTeNglo0V4un2rTCpRwoI7WqptcXZd7M5U7wBKk/OORXDwq3gHe
	obxKZCxTj4ipagOCNJ4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glZpk-0006Pe-Hu; Mon, 21 Jan 2019 13:41:48 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glZph-0006P7-EU
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 13:41:46 +0000
Received: by mail-lf1-x143.google.com with SMTP id a8so15529977lfk.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 05:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SF4M7AhekxLOzHWpvb8yq1aEWAWnL64H6PmvyFaKAok=;
 b=OqyfWeGegB0OedjBiVjJ5WWuEvlf0dltJPq5DwoC65MylV0PL5sENyax/ga9qgST21
 pdzWdYH5yoHG6/sDOjGAcX15F/T4+Td6xlzep2f6PYg04qVXLWYMfTavMtB9czI3/3OI
 1AzypkOmQ+RNOex8/jsXxMsO/eOY5x5+7s1Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SF4M7AhekxLOzHWpvb8yq1aEWAWnL64H6PmvyFaKAok=;
 b=mPZu4Ej/sSQcRtxF34VE38py281tjUdtobdtI+jPJ/D9PcrJo5ajWoarRDEhDhFVmK
 FsXQb0HGQFzuvq9AzYsdxX4Q1d35obFsAq0xD4nwN9KttvaLFm2+RpuF90Nu8A8claJn
 vg+nzfPCEDsMMHj+MHkFAKhh8oyRfuGzhb35xSYhB1Yoj6/3yGiggX9+IhSsmkm61ppT
 KRZdoZKDil948Q+uEU58mZfaj1nVhvmGkDlEaxXPntGsz4eJD3yuJuFMYu6637YmC7n9
 ZxsYaLJuVx9cqRvlRkJ7PeiR8R5zgzyJZqLJK+E7Hpv5k+dxO+3wP+oCKD6IGKglkVue
 swFg==
X-Gm-Message-State: AJcUukdiWgq6FJUZhg6pqvoshtK0jYjkzAvvWxbd95b0y8Oh9540Yp2c
 pdnP6eXthXx58L5mDtf5VfX5yun7j2LEsNcnxWFLDA==
X-Google-Smtp-Source: ALg8bN45WhP5pXFSIfwUYg29unYStWXKMtUMqsRB+js5Ti+Opwq+G2v+mZ/dq+/vlDoml70MHBOszZKwev38kZHyoVE=
X-Received: by 2002:a19:4849:: with SMTP id v70mr17874393lfa.62.1548078103250; 
 Mon, 21 Jan 2019 05:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20190115024543.12928-1-wens@csie.org>
In-Reply-To: <20190115024543.12928-1-wens@csie.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 Jan 2019 14:41:31 +0100
Message-ID: <CACRpkdYkmsf00=Bws=Kf9_8zYo5k4_fyEHoGamvDA5PN-1PmyQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: Correct number of IRQ banks on H6 main
 pin controller
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_054145_489053_416BC594 
X-CRM114-Status: GOOD (  10.23  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 stable <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 3:45 AM Chen-Yu Tsai <wens@csie.org> wrote:

> The H6 main pin controller has four banks of interrupt-triggering pins.
> The driver as originally submitted only specified three, but had pin
> descriptions referencing a fourth bank. This results in a out-of-bounds
> access into .irq_array of struct sunxi_pinctrl. This however did not
> result in a crash until v4.20, with commit a66d972465d1 ("devres: Align
> data[] to ARCH_KMALLOC_MINALIGN"), which changed the alignment of memory
> region returned by devm_kcalloc(). The increase likely moved the
> out-of-bounds access into the next, unmapped page.

Nice work rootcausing this!

Patch applied for fixes with the tested-by and ACK.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

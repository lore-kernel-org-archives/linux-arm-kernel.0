Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0D5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:26:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09385217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iNRyNre2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmoyPKXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09385217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NOE+lWQNPNwbz3CakE5AbBCrG5JE7JahN2GT5mb+XvM=; b=iNRyNre2jvBtl0
	qD9VRV8wolDBK0VuqCYw3mNABZ7AUyTa4qor01nO8ZH5s120MMWqtvjWTWhvl4ThaNN0GFjrd8pEH
	gy5njNegLUrEci2tlKkDUWtW1isAMYSIT9egYZ27yjxiiPJxdyks1r0N9c04qRJFat9b4KUiFS/wq
	um24y2okJYyA/fiHvsXLlTndcWNyQYb0ndo6ZVbnDVi5rXrBy6YOGQwx12CYGTkjPUGN1g7JERAuO
	nt3qlHfdNvW5ESuXtPx+ZLzGyjQyuSaJw1ycrhH0EJ7ECFmfw2OMsCU2UamBbkk22JdDUxUWZq9uz
	FTDyr3rHi4dqy5TA/FTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqQf-0008UB-1X; Mon, 18 Feb 2019 21:26:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqQb-0008Tf-Go
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 21:26:18 +0000
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1D92A21773
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 21:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550525177;
 bh=SLX+OTNTBgHUhay4ZmeyNUERhudNdDHXQ3mXWfuQap8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YmoyPKXkteFe2Q+SlM8wzNkWmVctJTJJ4ityN/DMQMYqvfndwrtY3VuQ75WH/j71V
 yOFtnAfPoPHTKg+rUGQ/Qx63gSeiW/zqsG04kk3DJCykfDZ/cKLXr3v1IYVJdxSGM4
 isEXEi5XGgDt6p8iFyp77WvM+nGvLrgDvfjrtRmo=
Received: by mail-qk1-f179.google.com with SMTP id o125so10854485qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 13:26:17 -0800 (PST)
X-Gm-Message-State: AHQUAuYQkF+3CoOE0E+WP3YLKkab4wB5iCzC4H76GjVjo78dlHaGIxA/
 YTYG2PMzo2aES7RcGzsqHvUdowoNerVVQjnNFw==
X-Google-Smtp-Source: AHgI3Ib/++hhVpFfw2tohItDDFtQDsTQKRiPvkRCtfOmuxBuB4SQkwMEXSkDYvHKNjL9A6hjS0g45qU4CNjkZUPGP9k=
X-Received: by 2002:a37:a381:: with SMTP id m123mr6609082qke.147.1550525176330; 
 Mon, 18 Feb 2019 13:26:16 -0800 (PST)
MIME-Version: 1.0
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-12-linus.walleij@linaro.org>
In-Reply-To: <20190203214205.13594-12-linus.walleij@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 18 Feb 2019 15:26:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKd=93Xkp4OAu9GxMMqLrzYWTmr2rv=-NsDnqxMmSavYA@mail.gmail.com>
Message-ID: <CAL_JsqKd=93Xkp4OAu9GxMMqLrzYWTmr2rv=-NsDnqxMmSavYA@mail.gmail.com>
Subject: Re: [PATCH 11/17 v1] clocksource/drivers/ixp4xx: Add DT bindings
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_132617_577752_C6E42086 
X-CRM114-Status: GOOD (  14.29  )
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Tim Harvey <tharvey@gateworks.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Krzysztof Halasa <khalasa@piap.pl>, Olof Johansson <olof@lixom.net>,
 Thomas Gleixner <tglx@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 3, 2019 at 3:42 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This adds device tree bindings for the Intel IXP4xx
> timers.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Clocksource/timer maintainers: I am requesting an ACK for
> this once you're happy with the bindings, as I intend to
> merge all of this IXP4xx rework through ARM SoC.
> ---
>  .../bindings/timer/intel,ixp4xx-timer.txt      | 18 ++++++++++++++++++
>  MAINTAINERS                                    |  1 +
>  2 files changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.txt

Same wish and comments here...

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C0FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:21:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F5F21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h28ng5Yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F5F21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X6L+PzcnipxkT28pGg05ywweZHRa82F6jpmplXT2o+I=; b=h28ng5YzB3Mpg7
	bVzAEe5JWCf7PnmFI4cdnxy4vXFomHllEw9T0BUznSJTZYW59hStnEax3LrbeqY6Eq0YrGhvR6XLD
	KpNL8uuVNBBeVVfAQHPxAZClfG+b0tYpjwU3dCxn/gtUZdiY1cn3x16K+lp7xn9tjVg95osDRS9fh
	cN+RFff5VLPPXn8mtdNe6oTRuFerUWEWntSdaMXVYXTa4qpVRhg99qgIF5r1JNG9dGUGXc1YgGRdd
	cKj31N9C2hZR1WI3L/rdLAbHidm+WIMobPpLUPpxKV9zvBowa+BjkuUV2fg6iZPs43LmXn0/HJ0oY
	NwszIs7caw+8MuCxwlNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvhux-00056A-DQ; Mon, 18 Feb 2019 12:21:03 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvhuu-00055n-Jg
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 12:21:02 +0000
Received: by mail-qt1-f194.google.com with SMTP id v10so18883561qtp.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 04:21:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GtdHAxqUhnuyM/EBdJXTnZgqZt7coVP/9zTgLi4hYLc=;
 b=OZXr/Mq8zzRvC/FPxPQjnLHiW6+m8YrL4K4LYxTUfaJr4exuZ8MGJ4J7HiktpCxihA
 ft4PaVH8q8PfRPBc5lxGCKUvaruGTad+IF98UDteNF/ZaEacbjWs3IjTCQSbMwiBQcV1
 wH5KQMO0TmxNiOptStaMPi+UzrrI7N5hPiD3JJpp3eWwtUn0Y31PETGVPihLJ6xqnsBL
 mVogYV6MPnQ5k5nA4uFMSftXeHIczZQ45eO1t9iOzlfEFk3qOtR1gwqtdOGGWHWXE5QL
 9tLaAU8izeHFT1Ajpko4moJoavndhJkFgdefFjVN1uCmT/wz3LIiXRF97bNt7cAbJ147
 ldnQ==
X-Gm-Message-State: AHQUAub9rxydrvCWfy3p4Blq9dZ7zI7DeqIzCSpyX61Nv0ntNxiRZjOY
 yNzE39phmjFiZ5hgN14k6Hi1N0Sapf2d6Whdtfg=
X-Google-Smtp-Source: AHgI3IbPmfMKPiuYDvNuoy/KqNDakxv45mdQ6ShE9ZD55+wx/xPOcgvWXm6tMRjltLkvO7gXAdJX+v37uwlFstrCzxM=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr3806848qtb.343.1550492459208; 
 Mon, 18 Feb 2019 04:20:59 -0800 (PST)
MIME-Version: 1.0
References: <1549628687-29628-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1549628687-29628-1-git-send-email-sugaya.taichi@socionext.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 13:20:42 +0100
Message-ID: <CAK8P3a3_j2W+KXSynW_SkVZk_+PJ-DqyxjLkgJL-OichS0fwWw@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] Add basic support for Socionext Milbeaut M10V SoC
To: Sugaya Taichi <sugaya.taichi@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_042100_643765_30F94975 
X-CRM114-Status: GOOD (  19.94  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Takao Orito <orito.takao@socionext.com>, Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, Jassi Brar <jaswinder.singh@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 linux-clk <linux-clk@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 1:24 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Hi,
>
> Here is the series of patches the initial support for SC2000(M10V) of
> Milbeaut SoCs. "M10V" is the internal name of SC2000, so commonly used in
> source code.
>
> SC2000 is a SoC of the Milbeaut series. equipped with a DSP optimized for
> computer vision. It also features advanced functionalities such as 360-degree,
> real-time spherical stitching with multi cameras, image stabilization for
> without mechanical gimbals, and rolling shutter correction. More detail is
> below:
> https://www.socionext.com/en/products/assp/milbeaut/SC2000.html
>
> Specifications for developers are below:
>  - Quad-core 32bit Cortex-A7 on ARMv7-A architecture
>  - NEON support
>  - DSP
>  - GPU
>  - MAX 3GB DDR3
>  - Cortex-M0 for power control
>  - NAND Flash Interface
>  - SD UHS-I
>  - SD UHS-II
>  - SDIO
>  - USB2.0 HOST / Device
>  - USB3.0 HOST / Device
>  - PCI express Gen2
>  - Ethernet Engine
>  - I2C
>  - UART
>  - SPI
>  - PWM
>
> Support is quite minimal for now, since it only includes timer, clock,
> pictrl and serial controller drivers, so we can only boot to userspace
> through initramfs. Support for the other peripherals  will come eventually.

I've looked over the platform once more. Overall, it looks very good, and
I'd still like to merge this for linux-5.1, but we are running out of time
there. If you send the patches to soc@kernel.org quickly, we can try to
still merge them in, but if anything goes wrong, it will have to wait until
we start merging patches for 5.2, directly after 5.1 is out.

I did not look at the device driver patches (clk, clocksource, pinctrl, serial)
in much detail. If you have an Ack from the maintainers, feel free to
include them in the series, otherwise let's merge the rest now and then
you can send the updated patches for inclusion through the subsystem
trees in 5.2.

I have sent a few comments. The only one that is really important
here is the missing platform check in the suspend options. Please
try to address most of the other commentsm, either by changing the
code, or by explaining why your version is correct.



     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

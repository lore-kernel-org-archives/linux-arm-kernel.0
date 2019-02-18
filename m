Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECEEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:25:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBD521738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j01DfG+s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0NtEQ1pP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBD521738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L9RFF2seKCez5KD6rRWG1ZhvveX+q7JVnNENcRd6wWI=; b=j01DfG+sFMDDse
	WbGcDRhWQvh6vLeRWtNfqXwhAXZP/XtinV/AWmi7a1nHAf2M7wNFaFGwVVxWb9nVARVV/FzVWKgsC
	TCRNWulol01vrfJWWSyj+Xte+KUJX+xDjyBAvw8NnZc0GkfYjUsT19+0tl7zxzDXIT3zmtBninGZM
	+ZV5wNYOUQ1I2tfnODjLAqdLqcemLD6ufcUohqWBKATI3KCBfbIqAheFp5obNKaOiq1G6eiPaHDDR
	c8avCIsDwFronN+Hu4FHlTeWBHzqAwOVyKajqBkEbAs062l8zGSE/ElrNaMPlniSvmfPkk5CCrsbt
	oj457+2X6j5WNCsGHZmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqPt-0008C0-5Z; Mon, 18 Feb 2019 21:25:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqPp-0008Av-Ay
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 21:25:30 +0000
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D962821908
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 21:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550525128;
 bh=jkqeSzw9APWu+SNovDRHYRgoKi7XS2oGu6de/C9N8DY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0NtEQ1pPqGAM4m/cz699FjVUGLcyj3jhYr2QEbq6x32pkgWYtjgl3UY59CsXYFqJh
 rIFOlhwODPTxpWydWNS9jQyFGEx0MOg3M78+EWe5afCMZpPoKkXPQ9UBFyeQmFCqo0
 xW4T43uJjLGEKXtNF/QznBdx6v7No64S5JY7hkLc=
Received: by mail-qt1-f171.google.com with SMTP id y4so20822630qtc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 13:25:27 -0800 (PST)
X-Gm-Message-State: AHQUAubiuhbXdRMkeB+AO5ns3xj2Sx44p8aAqCCZaDRlIxuYgMYOlPUT
 iyg2sd5++GvcDSbdcTXKUVRVhCS5dBhJl9jMsw==
X-Google-Smtp-Source: AHgI3IZmWapeMkZ+fFOJfal+zulpN7Rv87ViIYw3zgDoLkCr02ZZNqHvqG1jgnTx1HOMT1jMm4Fe0O0jzgBYNUTF6ok=
X-Received: by 2002:aed:2a2f:: with SMTP id c44mr20162844qtd.144.1550525126979; 
 Mon, 18 Feb 2019 13:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-10-linus.walleij@linaro.org>
In-Reply-To: <20190203214205.13594-10-linus.walleij@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 18 Feb 2019 15:25:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+XZewc60DhVTC6Zaj2qSBseT7DV3+XUS-7AQRjUm-uJA@mail.gmail.com>
Message-ID: <CAL_Jsq+XZewc60DhVTC6Zaj2qSBseT7DV3+XUS-7AQRjUm-uJA@mail.gmail.com>
Subject: Re: [PATCH 09/17 v1] irqchip: ixp4xx: Add DT bindings
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_132529_409183_B6FECE55 
X-CRM114-Status: GOOD (  20.13  )
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
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
 Tim Harvey <tharvey@gateworks.com>, Krzysztof Halasa <khalasa@piap.pl>,
 Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>,
 Imre Kaloz <kaloz@openwrt.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 3, 2019 at 3:42 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This adds device tree bindings for the IXP4xx interrupt
> controller. It's a standard 2-cell controller.

Not required, but writing as a schema would be great. Looks like it
would be straight forward.

> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> irqchip maintainers: I am requesting an ACK for this once
> you're happy with the bindings, as I intend to merge all of
> this IXP4xx rework through ARM SoC.
> ---
>  .../intel,ixp4xx-interrupt.txt                | 33 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.txt
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.txt b/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.txt
> new file mode 100644
> index 000000000000..70ee93b9a6c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.txt
> @@ -0,0 +1,33 @@
> +* Intel IXP4xx XScale Networking Processors Interrupt Controller
> +
> +This interrupt controller is found in the Intel IXP4xx processors.
> +Some processors have 32 interrupts, some have up to 64 interrupts.
> +The exact number of interrupts is determined from the compatible
> +string.
> +
> +The distinct IXP4xx families with different interrupt controller
> +variations are IXP42x, IXP43x, IXP45x and IXP46x. Those four
> +families were the only ones to reach the developer and consumer
> +market.
> +
> +Required properties:
> +- compatible: must be one of
> +  "intel,ixp42x-interrupt"
> +  "intel,ixp43x-interrupt"
> +  "intel,ixp45x-interrupt"
> +  "intel,ixp46x-interrupt"

While we normally don't allow wildcards, I'm guessing this is all so
old^W mature that it will be fine.

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

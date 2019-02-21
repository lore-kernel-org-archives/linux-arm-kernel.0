Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BD9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:39:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B00620818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RC1XXcGk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yWBJsncV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B00620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jeXMZT3q8FFoCStZ28UgyXpt79aVyYVxLdCjlLJhEc4=; b=RC1XXcGkaxCveW
	xz6WN2lwPvkl0vswcAPC5YIsiugDREOMRKhnKTxOle4+Vz94lH+wK/bi7/kWNwS1EAjo1Wtx+BPpn
	IPXIsrnaYncrjKmOebl2Apiw+znd8P5JsDp5j4+czZ3+bVnwElBqN/gSwTttXPwk8p7MQR0farc/y
	J10+YkSM4R8+0hdoK2OjY1H4DTdqYhM+8fBYt8FqgHdGf+BzmWbPJBs5/DaVIEd5n1CpEL3/qK+5/
	fHo754bXW2auX7+QXkfve9ZR99Va3Or2tVofVtXOFlIpO/4vXrRcgDLNzAXmXEh3yzy6lqNYp9bMI
	XuIgS482trjMoKoLMiOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gww4O-00061B-KN; Thu, 21 Feb 2019 21:39:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gww4L-00060h-BI
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 21:39:50 +0000
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2C8F62083E
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 21:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550785188;
 bh=dAy7F8x9H9wk+ykvturIHWB3Iij2WmlgDdGVm3G27JI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=yWBJsncVKmJETkkpXyq5BUGRUgzY7yEAbs3mEYkKQzjnMjL0RRe7H6+PSJTbmjdom
 LmUW9o345QL5KPakNG+E6FoiGicKGWoabZ5GzDXsHDpvYHpXuHUxNtupwLPj9bIK3k
 eXDSxI86JITxLrHqhmtSV4PpAN8bPYBgvALZ+KJc=
Received: by mail-qk1-f171.google.com with SMTP id m9so80268qkl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 13:39:48 -0800 (PST)
X-Gm-Message-State: AHQUAua5GHBaLJxyqUsxf+J1bPvkt9xmKLWmZaBR5alqqeuKQPv1fEKe
 /8Foqr/27sWPAEj7E5tgS5CnvWT+DwKzGu4/QA==
X-Google-Smtp-Source: AHgI3IbOnD86NJpUnssD5laWgNolQ0eCBDnib8AkvyVg/TgJsP+Fu72mk1lX5OoxvCRZwKTacEmijBYjI40sXL77OA4=
X-Received: by 2002:a37:674c:: with SMTP id b73mr536074qkc.184.1550785187350; 
 Thu, 21 Feb 2019 13:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20190221154458.23763-1-linus.walleij@linaro.org>
 <20190221154458.23763-10-linus.walleij@linaro.org>
In-Reply-To: <20190221154458.23763-10-linus.walleij@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 21 Feb 2019 15:39:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLFqxQ2NtZvsqmowMBcSaRgha=pb39_+rqg95LpAj0u0g@mail.gmail.com>
Message-ID: <CAL_JsqLFqxQ2NtZvsqmowMBcSaRgha=pb39_+rqg95LpAj0u0g@mail.gmail.com>
Subject: Re: [PATCH 09/30 v2] irqchip: ixp4xx: Add DT bindings
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_133949_421676_566E128C 
X-CRM114-Status: GOOD (  18.90  )
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
 Marc Zyngier <marc.zyngier@arm.com>, Krzysztof Halasa <khalasa@piap.pl>,
 Thomas Gleixner <tglx@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 9:45 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This adds device tree bindings for the IXP4xx interrupt
> controller. It's a standard 2-cell controller.
>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Converted to use JSON yaml schema, why not.
> - Not keeping Rob's ACK because I think he wants to take
>   a second look.
> ---
>  .../intel,ixp4xx-interrupt.yaml               | 57 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml b/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
> new file mode 100644
> index 000000000000..f32c08f270d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2018 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/interrupt/intel-ixp4xx-interrupt.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel IXP4xx XScale Networking Processors Interrupt Controller
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +  This interrupt controller is found in the Intel IXP4xx processors.
> +  Some processors have 32 interrupts, some have up to 64 interrupts.
> +  The exact number of interrupts is determined from the compatible
> +  string.
> +
> +  The distinct IXP4xx families with different interrupt controller
> +  variations are IXP42x, IXP43x, IXP45x and IXP46x. Those four
> +  families were the only ones to reach the developer and consumer
> +  market.
> +
> +properties:
> +  compatible:
> +    oneOf:

You can drop oneOf since there is only 1.

> +      - items:
> +        - enum:
> +          - intel,ixp42x-interrupt
> +          - intel,ixp43x-interrupt
> +          - intel,ixp45x-interrupt
> +          - intel,ixp46x-interrupt
> +
> +  reg:
> +    description: The register bank for the interrupt controller.

No need to define what reg is here. Just 'maxItems: 1' is sufficient.

> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +    description: The number of cells to define the interrupts.
> +      with two cells specified in interrupt-controller/interrupts.txt

I'd drop description here, but I prefer things terse. I guess this
does define the format of the cells.

With the other changes,

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

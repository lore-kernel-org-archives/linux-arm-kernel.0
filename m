Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CF5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:00:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF572077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t+/TXVDd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5+sYziQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF572077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nNWn5tOIYL6dhNc7xsFscdkSc7/m2wTOBJxgQFfoZic=; b=t+/TXVDdZOJf8H
	ERe0oicSlzg5bCCmtBqOJU9GArlJuytQ2XR/A5D5sm9K17DciqQJwKWQXIYsddFt179XvFj5qrDXA
	Xnv0cNNnKpnrbNHVnfrbxHCo1XQVM50ANldnk507xlUszF0zy8b5JsVDWNDnozbwqF6B50Vz62+ZP
	fPXQ4izxTW8CsBRLMqtb/pKFg6MAiEH4vA0XPn/EOnU2FLXJbAnXprywFB5jX5LrtG1WklXLK5u3q
	88AeuGWIA78SGSl6e4Ge5KkZGoYyS9dElFKjvEFz9PE0vgD7yHWGUvzysxdT0om8u0lfhHyaR+ujm
	oCylqR8ixdMVzsga6g9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwwOR-0006WJ-HV; Thu, 21 Feb 2019 22:00:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwwON-0006Vc-Dj
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 22:00:33 +0000
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DF8F02077B
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 22:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550786431;
 bh=cepDWdAYUqenQeOByrlKvDWV7PeAavbASIjIQA77Gq8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=R5+sYziQOTpxlm+NfUB57w4AL8ZtTNCe1wXqTVL8PzLAKFwhQDgzQiPVSkot+i9YY
 cFnKXx5upMPowMEDm+gFRdonEAq539C8SOmfAaTdzxWMUgmAP5p7DxUSk7uksJCtjz
 uLZnnP2sUGgQ7k3RVdJn+TKtJDNLHQctxdPGQh4U=
Received: by mail-qk1-f170.google.com with SMTP id m9so112741qkl.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 14:00:30 -0800 (PST)
X-Gm-Message-State: AHQUAuajZ2r7ycPM78aj5Vv1+1KvDx0EI1VBQI5pHReekeiHUurwQ8uK
 /oDrzLj8VA/dTxH6I9xet9vvM/HEi10+9BWI9Q==
X-Google-Smtp-Source: AHgI3IbG1LE8gKbKoE93WZDZ1co6Fog3XVEkD0Fs5CPC1IAM37tJgX4j0zfhcP3qsoOdAUhkmXB9NbkiFfATaWGZBEU=
X-Received: by 2002:a05:620a:123b:: with SMTP id
 v27mr569687qkj.29.1550786430138; 
 Thu, 21 Feb 2019 14:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20190221154458.23763-1-linus.walleij@linaro.org>
 <20190221154458.23763-29-linus.walleij@linaro.org>
In-Reply-To: <20190221154458.23763-29-linus.walleij@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 21 Feb 2019 16:00:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKJF0xdktw7BFRj8MWqty+Rkg6i9gDkWu_eHCq0TXyYMA@mail.gmail.com>
Message-ID: <CAL_JsqKJF0xdktw7BFRj8MWqty+Rkg6i9gDkWu_eHCq0TXyYMA@mail.gmail.com>
Subject: Re: [PATCH 28/30 v2] soc: ixp4xx: qmgr: Add DT bindings for IXP4xx
 qmgr
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_140031_498724_429F7171 
X-CRM114-Status: GOOD (  18.81  )
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
Cc: devicetree@vger.kernel.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 9:46 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This adds device tree bindings for the Intel IXP4xx AHB
> Queue Manager.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../misc/intel,ixp4xx-queue-manager.yaml      | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/intel,ixp4xx-queue-manager.yaml
>
> diff --git a/Documentation/devicetree/bindings/misc/intel,ixp4xx-queue-manager.yaml b/Documentation/devicetree/bindings/misc/intel,ixp4xx-queue-manager.yaml
> new file mode 100644
> index 000000000000..c324860bede5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/intel,ixp4xx-queue-manager.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/misc/intel-ixp4xx-ahb-queue-manager.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel IXP4xx AHB Queue Manager
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +  The IXP4xx AHB Queue Manager maintains queues as circular buffers in
> +  an 8KB embedded SRAM along with hardware pointers. It is used by both
> +  the XScale processor and the NPEs (Network Processing Units) in the
> +  IXP4xx for accelerating queues, especially for networking. Clients pick
> +  queues from the queue manager with foo-queue = <&qmgr N> where the
> +  &qmgr is a phandle to the queue manager and N is the queue resource
> +  number. The queue resources available and their specific purpose
> +  on a certain IXP4xx system will vary.
> +
> +properties:
> +  compatible:
> +    oneOf:

oneOf can be dropped.

> +      - items:
> +          - const: intel,ixp4xx-ahb-queue-manager
> +
> +  reg:
> +    items:
> +      - description: Queue Manager MMIO range

Just do 'maxItems: 1'.

Then again, maybe consistency is better. If there's only 1 register
range, there's not much point in describing it and I don't want a
bunch of free-form copy-n-paste of descriptions. It's only if there's
more than one that we need to define what each one is. In any case, I
should get a meta-schema in place to enforce something. And this could
easily be scripted to change the format how we end up wanting it to
look like.

> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 2

Can drop these 2.

> +    items:
> +      - description: Interrupt for queues 0-31
> +      - description: Interrupt for queues 32-63
> +
> +  '#queue-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

#queue-cells not required?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    qmgr: queue-manager@60000000 {
> +         compatible = "intel,ixp4xx-ahb-queue-manager";
> +         reg = <0x60000000 0x4000>;
> +         interrupts = <3 IRQ_TYPE_LEVEL_HIGH>, <4 IRQ_TYPE_LEVEL_HIGH>;
> +         #queue-cells = <1>;
> +    };
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

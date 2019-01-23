Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA418C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:33:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654922184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ia2cp2Hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654922184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NioYdQRqWsC4193N1uqckDRJrOQfHs11faHIdpa3Myk=; b=Ia2cp2Hpn25c2e
	IK9gcYtEI0CYsilM0fSrHzTI60uk32QjO/jtgoLvw8r3WHAaX5dYp/JPX8Yz2pUh4S7JWYX3/lHdK
	41aNcJdT3+sibJ68oDAy0MoYSyxfcusOxAqZso0VkGHQ8IQ+gOpqZuA+iDZPZYLZz87sf817YOaEn
	g/4B83knzFhKC5gTc4xlyrwrqAm1uZ2U3sGI/mtvZgucE3z82XLEqtmuLneXQYjwAt3xLxpme+vdY
	fCMoTZR2IYUkAPI2ivCTWVJ6y+8BcN8tIl5CCDH+5NF9xqLWVYL72KuJhjxck9lye4m1hGAtMdZRf
	g1tf1DpfnBH3l1jzDtFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKX3-00057L-Jr; Wed, 23 Jan 2019 15:33:37 +0000
Received: from mail-ua1-f67.google.com ([209.85.222.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKWy-00056u-VS
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 15:33:35 +0000
Received: by mail-ua1-f67.google.com with SMTP id t8so859169uap.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 07:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZSHkQMfLLdepeDCVQenJz5d2pdB1BZBSB6tWTabXfX0=;
 b=WAibNaTseqcwwOsGAQWhiWnfrm1T6Zhjis1h2+TMvQv+TrjvuiHipqcOpvXmmpeRlO
 f1ePFRdbWzljXcoMl4W89bdbBBBHApB/fPyH0tOw8NZQYhp5ePD/XbGNB+V+RsF5ZcvM
 TSWxkPfygWdp0BajgnOnDturL34MKUmydLcp6ML1APTtuDg86lYhOEqUO20xDwnK1nsC
 nm8vNwRCG+WliwsBtMx8skjvqIU6nUMK7bU4E/xIm3GS+YdrrzRFyZD3oU0e6toM8rlC
 C6/5jWTu66Z0EvDX2CMjlhWMP5FQA+gkt+XSHAj90UwebftkHJJxtAL2/bltmMYkS/pZ
 NQTw==
X-Gm-Message-State: AJcUukeb6D2nDiHmrXPKnpHsDJyJtOVGHEpnLsIN503ciUWyUVCdUgRP
 DrXbF+IzYdaRkI0AmRZTcI/aKIIS02g3fLBI7CA=
X-Google-Smtp-Source: ALg8bN411XN+/POecIOHkbERwk16PlKxGOoUzZRR+A06ByaQtAch2faN4J7KsCjNSKQqXO/AlB0D4mENUIQ4ibIYn7I=
X-Received: by 2002:ab0:1393:: with SMTP id m19mr976671uae.75.1548257602011;
 Wed, 23 Jan 2019 07:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org>
In-Reply-To: <20181211202406.27721-1-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Jan 2019 16:33:10 +0100
Message-ID: <CAMuHMdUZHi87Dv=m4USocfQ60s6_uHmny5DvCVm+hZ98+ROvdA@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Add support for DT binding schema checks
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_073333_017282_7C203AAC 
X-CRM114-Status: GOOD (  13.37  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Kumar Gala <kumar.gala@linaro.org>,
 arm-soc <arm@kernel.org>, Sean Hudson <darknighte@darknighte.com>,
 Jonathan Corbet <corbet@lwn.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Grant Likely <grant.likely@arm.com>, Michal Marek <michal.lkml@markovi.net>,
 Frank Rowand <frowand.list@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Rob,

On Tue, Dec 11, 2018 at 9:24 PM Rob Herring <robh@kernel.org> wrote:
> This adds the build infrastructure for checking DT binding schema
> documents and validating dts files using the binding schema.
>
> Check DT binding schema documents:
> make dt_binding_check
>
> Build dts files and check using DT binding schema:
> make dtbs_check
>
> Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> use for validation. This makes it easier to find and fix errors
> generated by a specific schema.
>
> Currently, the validation targets are separate from a normal build to
> avoid a hard dependency on the external DT schema project and because
> there are lots of warnings generated.

Thanks, I'm giving this a try, and get errors like:

      DTC     arch/arm/boot/dts/emev2-kzm9d.dt.yaml
    FATAL ERROR: No markers present in property 'cpu0' value

and

      DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml
    FATAL ERROR: No markers present in property 'audio_clk_a' value

Do you have a clue?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

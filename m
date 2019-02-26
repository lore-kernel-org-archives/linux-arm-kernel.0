Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F6CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:52:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986AD2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GYQJAaLO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLrU6ei2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986AD2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DuGrlHRH51yCKA9Co9VdAB137LaqZXrtgijWHsYml0M=; b=GYQJAaLOEF9+Gn
	8ch4tmTvG6L52cghG/VaFooSZSE4qcOhBxMiGAw3F0+GFJhs9uTXTQ1eiY7WwVs+lVzxXXybl2Js7
	IQAUoVnSD2uvdt4tH02F6k692WIVwoet22Le2cfAAd4v2hLV5rPQElrZ7OnspWr6LHBfLWpsvMqDm
	HtEKsSEnkrTR0cJnL7Uv9OsJv8wRpjtY3QtuCCLSn1P6SLlJqrL9WaSRbZrSwIXoX6nX4ISfW4WC0
	bUG8Wdh5hb9UxLUzHnfdUkNk2Ai0GwRHYXYXGhJqpNAp6sigRym7yfkhLXGBDII24lhv0MxTPdvbm
	XEQwqUuT2H0Hydd8+Few==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gycDj-000109-4T; Tue, 26 Feb 2019 12:52:27 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gycDf-0000zk-6K
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:52:25 +0000
Received: by mail-oi1-x243.google.com with SMTP id g16so10226367oib.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 04:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8k1Z0VFjCjjQHvxoX7Za/EQykhNeDnmQXyAwoS85xeY=;
 b=DLrU6ei2+97mq1RDlMsRwyPD9mUiDg3hLdBdxSLvnGG3Og8x39aU5H2KurUzw8I7C2
 z5XOA5+/ee+WcwhkYu+l9gQBPRT7DhClgv/6e1wspXEsxSsrlpb+hYPLVl/ZdtrYX6Og
 vGgWzm1i/oGej/9X1n+Qh5mp4vd3Qyu3wDUVguoZXwqEzr3Ea1aLE7Ennfqxr4Z2N4gF
 i7OhICqw9UfjrYL+K4noMa+th5521c6z4QjgteFppDwkUbDY1lEg2NCnvZ2nKNHp3LLi
 l3SD5Mc+zFwHO8t+89g2saqv869iaUkCW6w5r3sOalywV9my+cF20ThEs9cgbC+mB7r0
 BJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8k1Z0VFjCjjQHvxoX7Za/EQykhNeDnmQXyAwoS85xeY=;
 b=XDMtyrE3ZgPowpute67nYFARNbiF3/QrQv38gHAl/NaRmYP5dTjIjEocUtFuyVHYoR
 JAZ6Ka5lq8RVKfMjGStELFkKajR/ZQaNd/VeeBhbBIISFwKByzTZVmVoYpX0XQ3Z7NWE
 Td6ZjG38La7Nx28LuyDg2xhKyMWN8qkq/ZqYVGfO525PKvIkkKpOyx2x3V5eVlRXl6S8
 xQ+7neUl0HOjnMonWAYJH657NyAR1+wnEZtp6zSbC1SnLafQCG1MAmV0N2EkKbilZSA3
 NlPotP1p8Xi34wrUOMcR9oBBP3hMkBQdwXavJjN+R2dwBpWybIQDVw2wwl8P0ebelw0V
 +N1w==
X-Gm-Message-State: AHQUAubeJajZJ6MbPzdxVwfFxTsZQGscoHDBnLlJdpQkTMp/9YiowvQi
 Imr/IfjjcYhikMBdl4fCZyykGS2MGESrI0V9VlU=
X-Google-Smtp-Source: AHgI3IZgeZ/KSBoBzsElf3ZOGbtERaW2fR2MUZu7Q6EODXkekVlUSsfEGjKeorYe+3GlMbzbnlvkm8isrtZk5Kh/B0Y=
X-Received: by 2002:aca:5083:: with SMTP id e125mr2316196oib.9.1551185541543; 
 Tue, 26 Feb 2019 04:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20190226070742.30551-1-daniel.baluta@nxp.com>
In-Reply-To: <20190226070742.30551-1-daniel.baluta@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Feb 2019 09:52:11 -0300
Message-ID: <CAOMZO5CpefU56xLaOUq0GRwWP9kcMPyZ2PWM38C9FuU-3k1MJA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Enable wm8524 on i.MX8MQ
To: Daniel Baluta <daniel.baluta@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_045223_261627_0DCC1664 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "baruch@tkos.co.il" <baruch@tkos.co.il>, Abel Vesa <abel.vesa@nxp.com>,
 "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
 "ccaione@baylibre.com" <ccaione@baylibre.com>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, "angus@akkea.ca" <angus@akkea.ca>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Aisheng Dong <aisheng.dong@nxp.com>, "agx@sigxcpu.org" <agx@sigxcpu.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Daniel,

On Tue, Feb 26, 2019 at 4:08 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> On i.MX8MQ we can start the party using the wm8524 codec
> which gets it's data through the SAI2 interface.
>
> In order to make it work this patch series enables the SDMA nodes,
> sets the correct pinctrl configuration and uses the simple card
> machine driver to put everything together.
>
> Changes since v2:
>         - s/QM/MQ after Chris comments
>
> Changes since v1:
>         - added cover letter
>         - remove "fsl,imx8mq-sdma" compatible for sdma.

Why? It is good practice to add the new compatible entry.

In case we find out a need for a fix that only affects imx8mq in the
future we can do that by using the specific compatible and no dts
change will be needed.

>
> Daniel Baluta (5):
>   arm64: dts: imx8mq: Add SDMA nodes
>   arm64: dts: imx8mq: Add SAI2 node
>   arm64: dts: imx8mq: Add SAI pinctrl configuration
>   arm64: dts: imx8mq: Enable SAI2 for wm8524 codec
>   arm64: dts: imx8mq: Enable wm8524 codec

I would suggest making the last three patches as a single one.

Also, please make the Subject as: arm64: dts: imx8mq-evk when a patch
is specific to the imx8mq-evk dts.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

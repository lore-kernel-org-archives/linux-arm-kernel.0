Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C63C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:38:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E1920859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AJLYKO4S";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmPsI3D8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E1920859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4SWDDfHUlHc8TyiWmC6Natd7tcQwlaUoEr/Kc1Xls9U=; b=AJLYKO4S0816wD
	+TdSIxxIBmvJYFcz+49z1Gz9LK8Nyo0+2Yc4XfZ/gm/lB78P9O1sLp+C/Oo5xnd9GHovcd7aDoX0T
	t+mGl/tdO1W9qhbY72ZVxsuepjJmRNiPgtu8pll9iN2pmcr29y51KJ7cFgbQDmXcfyFSFZH70j0Tq
	N2nMtzG03GbN5V/cxsv4spG74TXJKh6ttPs+I8vf844gsIqxEb2Fb4aawwQ+4BEQi1BxNTK/GHSaZ
	jva5yU0uRTrp1vk+ruQt7RUBIHboP5ie0aEgXeo7hNzhAui4CYmYZVyKjG4am97GNeT4TMSxbz8Jk
	BWhR1OIGWRmnJ3twek4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkGIo-0000PP-QP; Thu, 17 Jan 2019 22:38:22 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkGIl-0000P4-P2
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 22:38:21 +0000
Received: by mail-wr1-x443.google.com with SMTP id l9so12781558wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 14:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lN2rae8wyVAor90vR3Fuv6iYQRV6+kCDtSkz6R9rQ4Q=;
 b=CmPsI3D8ecOulLP6isxpm0wKkhNOw4vQlvnARk3ePmXCH7AITNrDYBQKtl+k1S3fQS
 zHAnugWsAlXXivQjaRbUPiCfoQCDXNjcp0I+t/eqHKq2f5+/8/6+HniaLoztkEEOU2Qc
 IGkW7+JP5v3xRVK2AD0geHPmx5uFCZ5dUyr3+0mlRvGT983fQEcXlOy68ZhxMa97wgOd
 NifTZfFzorFmXsvqttrG7IzCiklSibu8WuWD3oy2CHsVObnFVV0n91TaYAkQYIWf3dW/
 oZV5flsrjEA7J+WDYEWiku/Fr5xBrwBE6OtXl4vWqowC4i+QN628QeuvgZ7yZ/ha9SAv
 gcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lN2rae8wyVAor90vR3Fuv6iYQRV6+kCDtSkz6R9rQ4Q=;
 b=VpJy869LEwSkMd6ZPXtpMVzvuga3uXhlwiB93xZzIHB2FSkedKBX3p9HVo4PK8HAla
 1lEdb81nEOjnuwTMrCZU77gkCOUXqnXm48M71zvFimQC7kcO9o1VwgJm0j9V8SSVzpkn
 mjEf8UXvsx5owSjGsaLbudyUflzo7YaZjZfBapl7k5VIXUwJ2YPE7rAxF7hQlFPgf7Fm
 /t93mh+vFFbXP2zTrq2ZInfETwUl08jHcrpkSRPqmf2mtilL1Uwalnp3z4YMnmL16VR0
 PdTKM3RcplP9KvSsljIxR54vj4QVfNDFvGq+u4OvoiEFB1hYUSrxTWIURehAE99Lx7r4
 Yb0A==
X-Gm-Message-State: AJcUukdFRZOgUtT8OCw8/g9dVuVbPnaLLQLf2SjX1BeBur+x0jGeArrH
 U1vsuajX9ft21ec6veJyRnq+xP/Qmd/QgOyEZpw=
X-Google-Smtp-Source: ALg8bN6cIhT26uiySCgu7FPFPGRBP+ONv4qG3nWR69zW5vjNrTz3nXYaJh/Ui3m2NvFtwrYtVWO7V8r68/i5A6dqtCQ=
X-Received: by 2002:a05:6000:51:: with SMTP id
 k17mr13059920wrx.259.1547764697654; 
 Thu, 17 Jan 2019 14:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
 <20181220010700.8598-3-andrew.smirnov@gmail.com>
 <1547743553.4009.16.camel@pengutronix.de>
In-Reply-To: <1547743553.4009.16.camel@pengutronix.de>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 17 Jan 2019 14:38:06 -0800
Message-ID: <CAHQ1cqG+3K+SKptZJ-FQ6xAa+2LMs_W24TEgqyV+9kR_iAz+cg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: reset: imx7: Document usage on
 i.MX8MQ SoCs
To: Philipp Zabel <p.zabel@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_143819_864697_ACDCE154 
X-CRM114-Status: GOOD (  23.07  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 8:45 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Andrey,
>
> sorry for the delay. Thank you for the update, apart from the comments
> below, the list now looks to be complete.
>
> On Wed, 2018-12-19 at 17:06 -0800, Andrey Smirnov wrote:
> > The driver now supports i.MX8MQ, so update bindings accordingly.
> >
> > Cc: p.zabel@pengutronix.de
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: cphealy@gmail.com
> > Cc: l.stach@pengutronix.de
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  .../bindings/reset/fsl,imx7-src.txt           |  7 +-
> >  include/dt-bindings/reset/imx8mq-reset.h      | 64 +++++++++++++++++++
> >  2 files changed, 69 insertions(+), 2 deletions(-)
> >  create mode 100644 include/dt-bindings/reset/imx8mq-reset.h
> >
> > diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> > index 1ab1d109318e..2ecf33815d18 100644
> > --- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> > +++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> > @@ -5,7 +5,9 @@ Please also refer to reset.txt in this directory for common reset
> >  controller binding usage.
> >
> >  Required properties:
> > -- compatible: Should be "fsl,imx7d-src", "syscon"
> > +- compatible:
> > +     - For i.MX7 SoCs should be "fsl,imx7d-src", "syscon"
> > +     - For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
> >  - reg: should be register base and length as documented in the
> >    datasheet
> >  - interrupts: Should contain SRC interrupt
> > @@ -44,4 +46,5 @@ Example:
> >
> >
> >  For list of all valid reset indicies see
> > -<dt-bindings/reset/imx7-reset.h>
> > +<dt-bindings/reset/imx7-reset.h> for i.MX7 and
> > +<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ
> > diff --git a/include/dt-bindings/reset/imx8mq-reset.h b/include/dt-bindings/reset/imx8mq-reset.h
> > new file mode 100644
> > index 000000000000..57c592498aa0
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/imx8mq-reset.h
> > @@ -0,0 +1,64 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2018 Zodiac Inflight Innovations
> > + *
> > + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> > + */
> > +
> > +#ifndef DT_BINDING_RESET_IMX8MQ_H
> > +#define DT_BINDING_RESET_IMX8MQ_H
> > +
> > +#define IMX8MQ_RESET_A53_CORE_POR_RESET0     0
> > +#define IMX8MQ_RESET_A53_CORE_POR_RESET1     1
> > +#define IMX8MQ_RESET_A53_CORE_POR_RESET2     2
> > +#define IMX8MQ_RESET_A53_CORE_POR_RESET3     3
> > +#define IMX8MQ_RESET_A53_CORE_RESET0         4
> > +#define IMX8MQ_RESET_A53_CORE_RESET1         5
> > +#define IMX8MQ_RESET_A53_CORE_RESET2         6
> > +#define IMX8MQ_RESET_A53_CORE_RESET3         7
> > +#define IMX8MQ_RESET_A53_DBG_RESET0          8
> > +#define IMX8MQ_RESET_A53_DBG_RESET1          9
> > +#define IMX8MQ_RESET_A53_DBG_RESET2          10
> > +#define IMX8MQ_RESET_A53_DBG_RESET3          11
> > +#define IMX8MQ_RESET_A53_ETM_RESET0          12
> > +#define IMX8MQ_RESET_A53_ETM_RESET1          13
> > +#define IMX8MQ_RESET_A53_ETM_RESET2          14
> > +#define IMX8MQ_RESET_A53_ETM_RESET3          15
> > +#define IMX8MQ_RESET_A53_SOC_DBG_RESET               16
> > +#define IMX8MQ_RESET_A53_L2RESET             17
> > +#define IMX8MQ_RESET_SW_NON_SCLR_M4C_RST     18
>                            ^^^^^^^^
>
> This might be an implementation detail. The reset line is
> (SW_?)M4C_RST. I suppose the self-clearing SW_M4C_RST bit could be used
> to implement .reset() functionality for the same line if needed.
>

I was using literal bit names for reset lines. In this case this is a
bit 0 of SRC_M4RCR.

> What about the self-clearing SW_M4P_RST bit? Has that been left out on
> purpose?

Since they are self-clearing they'd require a separate .reset
function. I have no use-case for them at this moment and no way to
test it, so I left them out.

>
> > +#define IMX8MQ_RESET_OTG1_PHY_RESET          19
> > +#define IMX8MQ_RESET_OTG2_PHY_RESET          20
> > +#define IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N   21
> > +#define IMX8MQ_RESET_MIPI_DSI_RESET_N                22
> > +#define IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N    23
> > +#define IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N    24
> > +#define IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N   25
> > +#define IMX8MQ_RESET_PCIEPHY                 26
> > +#define IMX8MQ_RESET_PCIEPHY_PERST           27
> > +#define IMX8MQ_RESET_PCIE_CTRL_APPS_EN               28
> > +#define IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF  29
>
> To be honest, I don't like these two, I'm not convinced anymore that
> they actually qualify as reset signals. To me it looks like this is
> something that the PCIe glue code should handle via syscon like i.MX6.
> Leonard, Lucas, what do you think?

OK, one thing to keep in mind about this is that those bits are
already exposed for i.MX7D and I think (correct me if I am wrong)
there's no going back there. PCIe driver already has the code to use
those on i.MX7D and, due to high degree of similarity, i.MX8MQ
actually re-uses the same codepath (at least for
IMX8MQ_RESET_PCIE_CTRL_APPS_EN).

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

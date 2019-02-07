Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B318EC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:22:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787A821721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VBxiB3v7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwtxgGl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787A821721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2+o8K4Y7mveLs7vwTOJ6/zSW/U3kXPaGHX1QvLCagfw=; b=VBxiB3v77iapCX
	SZFrbkkiPZmq5TqstacUQT2/BbD9c5XMEU93CSb3zwWybDVeuNQpWISzN86Onj4lW79JARTWEk3iq
	CA9ET6hrX6qlRu/2BP4Lboe6OBsYbJqRLC2E8UyvP1yuVwzG1BSs1UkyP4HS6kNWLChkyDgcnf98k
	RzGDKTVw/TnMPTYRd8w+P0b0SMWZbAnWmtYsjadBrTIZtydt5CnAJZLU2ag08R4qoVfQLKKSBsuYs
	jkCmTNz6cpL5eWCSD4+lvWEriCJft3GKD6dBCnpKBw7V4SDEVsPrKmvllPP1rtXdr8sMj4upScEG0
	bBQ2WSPcJz2E9ek7i9DA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grr84-0003Nl-By; Thu, 07 Feb 2019 21:22:40 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grr80-0003DQ-SM
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 21:22:38 +0000
Received: by mail-wm1-x343.google.com with SMTP id h22so5327241wmb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 13:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZsHTNSJE/lKlDQS3n1W69xmTT6S2j6VecvSVZDrzC3I=;
 b=FwtxgGl0UjVOeLNcPo67MLwfL80S8JGKV8HgdwW8XHnL/xkNEL+VAf26R9tum5qEQF
 XcgaDrLWNi9yHRxrwWJ0oEObWcDhcO8nY9tu5sgtthFuMvi1gx/z6C3HsQfJh3EI8qdd
 M9S8eXTHPdMJgWJAYk4pgEA1TRW1/v38p5elLcrVUpqfzW0RAFH9dTqx0S1WN4E5bQdH
 FNR27scsTuIFE61bmca8UotJJiVsQXVSX1GO6TRtQCols83/ZCl0I+l6FrLn6objuDrY
 VQ8qt+VcNFGDB3dBpZA40PgI7QuqLEVBwHCy7GgbFN3hHIny/Uy11J5WAwVNnzLtGCte
 jklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZsHTNSJE/lKlDQS3n1W69xmTT6S2j6VecvSVZDrzC3I=;
 b=BgDnivRbpfoJ1wh9+Z4/x1ubG4wDejhQgv+mpieuYUVHr+M9jDBJ9k3Td+dADU2ktc
 wZkJudaTLrAEClsP3LxllkFACh1zEKx5vHuipo8gPwxxneC5zN334hS3RRxTRqCq+9jj
 4P6YePh8TwnzURHC5TV7FwcWV7b4gpF6X4+DcZUbpH1JHUYW6URHtm2tJ5gDnatglS/c
 XeOx7lmzpqKLRx3RTbgV1Ro5dFITXUsiGchDNCwHJXz0jJ5hvB/ShViikRjr7BkfQIOy
 YMrIrVeKjWMV4n8a50uJZ+I6B9j7i+2jkgsZz/pEatjzQikiTYSr2WbY+1B5fNG1F87r
 gEaw==
X-Gm-Message-State: AHQUAubq5ehRNdPz5eJCLLlTryrrPAN1MIh6h82NTrruyz7cV/PPvXxn
 1yTiuY6oatBinxqjXFSh+sUV4hHXppYIeSpxAG4=
X-Google-Smtp-Source: AHgI3Ib3H9iLE7uj5xKcChBKx8AaIe6sqt//BqWFTM9rYSOMVQpTT00qo6os+xAai6MpP7IfNdlQBSSJwUtGmyDiMWI=
X-Received: by 2002:a1c:760c:: with SMTP id r12mr8291706wmc.127.1549574554687; 
 Thu, 07 Feb 2019 13:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20190131204333.31846-1-andrew.smirnov@gmail.com>
 <20190131204333.31846-5-andrew.smirnov@gmail.com>
 <1549549676.2544.79.camel@pengutronix.de>
In-Reply-To: <1549549676.2544.79.camel@pengutronix.de>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 7 Feb 2019 13:22:23 -0800
Message-ID: <CAHQ1cqGOtGb1mt7BCm_DaKoJn=6=atauipgt6Dg2-doSEoj_tg@mail.gmail.com>
Subject: Re: [RFC 4/5] arm64: dts: Add nodes for PCIe IP blocks
To: Lucas Stach <l.stach@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_132236_915546_01A2B7BF 
X-CRM114-Status: GOOD (  19.45  )
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
 linux-kernel <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Chris Healy <cphealy@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 7, 2019 at 6:27 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Donnerstag, den 31.01.2019, 12:43 -0800 schrieb Andrey Smirnov:
> > Add nodes for two PCIe controllers found on i.MX8MQ.
> >
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Cc: Chris Healy <cphealy@gmail.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 68 +++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index 89babc531380..d20e5c7e21a3 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -6,6 +6,7 @@
> >
> >  #include <dt-bindings/clock/imx8mq-clock.h>
> >  #include <dt-bindings/power/imx8mq-power.h>
> > +#include <dt-bindings/reset/imx8mq-reset.h>
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include "imx8mq-pinfunc.h"
> > @@ -539,6 +540,73 @@
> >                       };
> >
> >       };
> >
> > +             pcie0: pcie@33800000 {
> > +                     compatible = "fsl,imx8mq-pcie";
> > +                     reg = <0x33800000 0x400000>,
> > +                           <0x1ff00000 0x80000>;
> > +                     reg-names = "dbi", "config";
> > +                     #address-cells = <3>;
> > +                     #size-cells = <2>;
> > +                     device_type = "pci";
> > +                     bus-range = <0x00 0xff>;
> > +                     ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000 /* downstream I/O 64KB */
> > +                               0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
> > +                     num-lanes = <1>;
> > +                     interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>; /* eDMA */
>
> I don't think this IRQ is documented in any binding yet.
>

A leftover from vendor tree. Will drop in v2.

> > +                     interrupt-names = "msi";
> > +                     #interrupt-cells = <1>;
> > +                     interrupt-map-mask = <0 0 0 0x7>;
> > +                     interrupt-map = <0 0 0 1 &gic GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <0 0 0 2 &gic GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <0 0 0 3 &gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <0 0 0 4 &gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
> > +                              <&clk IMX8MQ_CLK_PCIE1_AUX>,
>
> This is not the PCIe bus clock. The bus clock is whatever drives the
> ref clock of the external bus. So on the i.MX8M-EVK this would be the
> fixed clock generated by U1302.
>
> The right thing to properly describe the HW is to extend the PCIe
> driver to look for the aux clock on i.MX8M, just like we do with the
> axi_inbound_clk on i.MX6SX.
>

OK, will update it in v2 and send a corresponding patch to PCI tree
once everything is agreed upon.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

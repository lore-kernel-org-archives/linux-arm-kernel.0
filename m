Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D27BC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:49:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DE720849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eBWKjqjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DE720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8aHyRYjXwv6zBO/r9lkkZbaL+Y2K0TCQAf1kxsBOZb8=; b=eBWKjqjFx1xOYq
	e7Bwo4X9fe59Eacwod8OCRVt19u0RybauB/fkYbbvyKHrVNai2447ktlO/kGppwvbIim3nSay5iIy
	kfU7Aah0UAFSbtD8eHUPOlTrdgEE0jA7wUw/IWsSbfuX6rAZxa5YYF1cWvUyuyoMdT3/dU14xlmrb
	96u03efTFh/zgkcHdOl61hz8asEgMEEOUL+R/+JHlaKVe9/mxWMEXzyX+uAGW6fokld6836LnzMes
	ZvomFr3OKsPRaaXXsmXi+xL76xxfgwW63XiPTxNvXEDDXuC45joSQAst365CwwG5NwM5O4FcOY+Em
	1sJL+JV/MJtRz9tlk3Lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjLm-0004sT-UI; Tue, 11 Dec 2018 14:49:30 +0000
Received: from esa2.microchip.iphmx.com ([68.232.149.84])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjLa-0004j0-HV; Tue, 11 Dec 2018 14:49:20 +0000
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; d="scan'208";a="24079869"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 11 Dec 2018 07:49:04 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Tue, 11 Dec 2018
 07:49:03 -0700
Date: Tue, 11 Dec 2018 15:48:58 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Message-ID: <20181211144858.dnbj5iozgk74wzdm@M43218.corp.atmel.com>
Mail-Followup-To: Boris Brezillon <boris.brezillon@bootlin.com>,
 Tudor.Ambarus@microchip.com, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com, robh+dt@kernel.org,
 mark.rutland@arm.com, Cyrille.Pitchen@microchip.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 broonie@kernel.org, linux-spi@vger.kernel.org
References: <20181210171511.21002-1-tudor.ambarus@microchip.com>
 <20181211154033.076506aa@bbrezillon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211154033.076506aa@bbrezillon>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_064918_612935_DF62B136 
X-CRM114-Status: GOOD (  18.51  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, Tudor.Ambarus@microchip.com, broonie@kernel.org,
 Cyrille.Pitchen@microchip.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 03:40:33PM +0100, Boris Brezillon wrote:
> On Mon, 10 Dec 2018 17:15:29 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
> > From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> > 
> > This patch configures the QSPI0 controller pin muxing and declares
> > a jedec,spi-nor memory.
> > 
> > sama5d2 Xplained RevB and RevC use the Macronix MX25L25673G flash
> > memory which advertises a maximum frequency of 80MHz for Quad IO
> > Fast Read. Set the spi-max-frequency to 80MHz knowing that actually
> > the QSPI drver will set the SPI bus clock to 166MHz / 3 = 55.3MHz.
> > 
> > Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> > [tudor.ambarus@microchip.com:
> > - drop partitions,
> > - add spi-rx/tx-bus-width
> > - change spi-max-frequency to match the 80MHz limit advertised by
> >   MX25L25673G for Quad IO Fast Read,
> > - reword commit message and subject.]
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > ---
> >  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 31 +++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > index 518e2b095ccf..171bc82cfbbf 100644
> > --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > @@ -108,6 +108,21 @@
> >  		};
> >  
> >  		apb {
> > +			qspi0: spi@f0020000 {
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&pinctrl_qspi0_default>;
> > +				/* status = "okay"; */ /* conflict with sdmmc1 */
> > +
> > +				flash@0 {
> > +					compatible = "jedec,spi-nor";
> > +					reg = <0>;
> > +					spi-max-frequency = <80000000>;
> > +					spi-tx-bus-width = <4>;
> > +					spi-rx-bus-width = <4>;
> > +					m25p,fast-read;
> > +				};
> 
> I'm a bit lost. What's the point of defining this if the QSPI
> controller is not enabled?

It's a way to avoid customer struggling with the device tree. If he
doesn't care about sdmmc1, he can easily enable the qpsi controller and
get access to the memory.

Regards

Ludovic


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

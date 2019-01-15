Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A70DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:58:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482702085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mY4Qldub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482702085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vKu8Tk8R+t0vdnqyofDxYhb3NVaMkYKHgIEQFq/xT+8=; b=mY4QldubOc3dHA
	z4xb39C6oeWRlBMhtD7usNW8cDaZQjLa2Oy+V3enPnNDS2ov5kzTTDDUiVBcgRXoRJt6M2gQJxcTe
	hqjnmvAnRWvnLKWJN+XWaIH7SgJ8+ROhqR3b2kG+tbKkzoJcFZqI6CYFNg4mQRC5+UZydO/u4o7t4
	wi0NP9xqS96Innd3FMpIGp5aasHEvR1dXIxqyT5i5gNu0QGjwAQ5CjVw60TMmuBU8C6nx8PKas8Q8
	0KsbxA7r8psQmt0jABC2/CNwIH/KqtWKbNIj6pYjqKlTlHN4jFQPX08DczbJPd/HvUQnZwunST2q4
	IoS9Rs082lnpu6YyQxAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjJcE-0005Sy-2d; Tue, 15 Jan 2019 07:58:30 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjJbx-0005FU-To; Tue, 15 Jan 2019 07:58:15 +0000
X-UUID: e15dc5c080934e5f89d2df84c4853ced-20190114
X-UUID: e15dc5c080934e5f89d2df84c4853ced-20190114
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 533522527; Mon, 14 Jan 2019 23:57:59 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 14 Jan 2019 23:57:57 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 15:57:54 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 15 Jan 2019 15:57:54 +0800
Message-ID: <1547539075.18705.3.camel@mtkswgap22>
Subject: Re: [PATCH v1 3/3] mtd: spi-nor: mtk-quadspi: rename config to a
 common one
From: Ryder Lee <ryder.lee@mediatek.com>
To: <Tudor.Ambarus@microchip.com>
Date: Tue, 15 Jan 2019 15:57:55 +0800
In-Reply-To: <fc95a69a-6a2e-fc98-d047-b0c93843fc56@microchip.com>
References: <67e650ca4fcaaddbbc98bf4e1cbe04647c990dc3.1547442452.git.ryder.lee@mediatek.com>
 <45dc2817e7f4baf5113de247b1a2cb30bf252d93.1547442452.git.ryder.lee@mediatek.com>
 <fc95a69a-6a2e-fc98-d047-b0c93843fc56@microchip.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_235813_971096_9D7CB333 
X-CRM114-Status: GOOD (  19.73  )
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
Cc: devicetree@vger.kernel.org, boris.brezillon@bootlin.com,
 weijie.gao@mediatek.com, linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
 robh+dt@kernel.org, linux-mtd@lists.infradead.org,
 linux-mediatek@lists.infradead.org, computersforpeace@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-15 at 07:34 +0000, Tudor.Ambarus@microchip.com wrote:
> Hi, Ryder,
> 
> On 01/14/2019 07:12 AM, Ryder Lee wrote:
> > The quadspi is a generic communication interface which could be shared
> > with other MediaTek SoCs. Hence rename it to a common one.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> > Changes since v1: rebase to v5.0-rc1. 
> 
> The patch doesn't apply on v5.0-rc1 or rc2.
> > ---
> >  drivers/mtd/spi-nor/Kconfig  | 16 ++++++++--------
> >  drivers/mtd/spi-nor/Makefile |  2 +-
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
> > index b433e5f..99d9d53 100644
> > --- a/drivers/mtd/spi-nor/Kconfig
> > +++ b/drivers/mtd/spi-nor/Kconfig
> > @@ -7,14 +7,6 @@ menuconfig MTD_SPI_NOR
> >  
> >  if MTD_SPI_NOR
> >  
> > -config MTD_MT81xx_NOR
> > -	tristate "Mediatek MT81xx SPI NOR flash controller"
> > -	depends on HAS_IOMEM
> > -	help
> > -	  This enables access to SPI NOR flash, using MT81xx SPI NOR flash
> > -	  controller. This controller does not support generic SPI BUS, it only
> > -	  supports SPI NOR Flash.
> > -
> >  config MTD_SPI_NOR_USE_4K_SECTORS
> >  	bool "Use small 4096 B erase sectors"
> >  	default y
> > @@ -68,6 +60,14 @@ config SPI_NXP_SPIFI
> >  	  Flash. Enable this option if you have a device with a SPIFI
> >  	  controller and want to access the Flash as a mtd device.
> >  
> > +config SPI_MTK_QUADSPI
> 
> Since you are moving the config into the file, would you mind to put your config
> in an alphabetical order?
> 
> Thanks,
> ta

Okay, I will send a new one to fix them.

Thanks,
Ryder

> > +	tristate "MediaTek Quad SPI controller"
> > +	depends on HAS_IOMEM
> > +	help
> > +	  This enables support for the Quad SPI controller in master mode.
> > +	  This controller does not support generic SPI. It only supports
> > +	  SPI NOR.
> > +
> >  config SPI_INTEL_SPI
> >  	tristate
> >  
> > diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> > index 2adedbe..189a15c 100644
> > --- a/drivers/mtd/spi-nor/Makefile
> > +++ b/drivers/mtd/spi-nor/Makefile
> > @@ -3,7 +3,7 @@ obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
> >  obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
> >  obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= cadence-quadspi.o
> >  obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
> > -obj-$(CONFIG_MTD_MT81xx_NOR)    += mtk-quadspi.o
> > +obj-$(CONFIG_SPI_MTK_QUADSPI)    += mtk-quadspi.o
> >  obj-$(CONFIG_SPI_NXP_SPIFI)	+= nxp-spifi.o
> >  obj-$(CONFIG_SPI_INTEL_SPI)	+= intel-spi.o
> >  obj-$(CONFIG_SPI_INTEL_SPI_PCI)	+= intel-spi-pci.o
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

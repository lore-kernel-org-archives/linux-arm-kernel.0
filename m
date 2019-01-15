Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177F3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:19:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF8120859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XZvvRpRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF8120859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LdEiueNaS6jlks49JawbOm4WLzySQpyxniARJSnxao0=; b=XZvvRpRR1mJSPz
	el9yEeNwBJ1QTcshjYBlfsnoE7byfQcE0o1+UrSSkno0pld6s1nHwtejB5RGeS6crwvHvQOyZW/fh
	mLWvnoD6sZucZDtZWkq+JuvFOankrErSASraEd3mSTamTxTPthX+f/es/tIkn+o/3UnEwE6x4TP+Q
	cF+CaVIEdOj5nJLJZMUMyR9k8RUAYnA2QIg1E7Bnnj4r+Nc9/CV4MfKuR7CTDwYhv6W1GPH3Gtmzd
	qBLCq1e6izEjV1qA4hL1DN5JigasGfoWrOmtx4r8eaPsZSrs/VsjWMzRCB8jJ7RB7H/05jRwezRqf
	aO9l+47mYbYvMbAy0FXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjH7v-0007l3-CI; Tue, 15 Jan 2019 05:19:03 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjH7r-0007kN-1J; Tue, 15 Jan 2019 05:19:00 +0000
X-UUID: e1c5cdc1f8b34217b5a74143c45281f1-20190114
X-UUID: e1c5cdc1f8b34217b5a74143c45281f1-20190114
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1719259689; Mon, 14 Jan 2019 21:18:48 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 14 Jan 2019 21:18:46 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 13:18:44 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 15 Jan 2019 13:18:43 +0800
Message-ID: <1547529524.13961.2.camel@mtkswgap22>
Subject: Re: [SPAM][PATCH v2 0/4] Add MediaTek MUSB Controller Driver
From: Ryder Lee <ryder.lee@mediatek.com>
To: <min.guo@mediatek.com>
Date: Tue, 15 Jan 2019 13:18:44 +0800
In-Reply-To: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
References: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_211859_083580_D29D9CA0 
X-CRM114-Status: GOOD (  15.60  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, chunfeng.yun@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org,
 Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-15 at 09:43 +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> These patches introduce the MediaTek MUSB controller driver.
> 
> The driver can be configured as Dual-Role Device (DRD),
> Peripheral Only and Host Only modes. This has beed tested on
> MT2701 with a variety of devices in host mode and with the 
> f_mass gadget driver in peripheral mode, plugging otg cables
> in/out a lot of times in all possible imaginable plug orders.
> 
> changes in v2:
> changes of dt-bindings suggested by Rob and Bin:
> 1. Modify DRC to DRD
> 2. Drop the "<soc-model>-musb" in compatible
> 3. Remove phy-names
> 4. Add space after comma in clock-names
> dtsi:
> 1. Remove phy-names
> changes of driver suggested by Bin:
> 1. Add a new patch for musb_set_toggle
> 2. Add summarize of MediaTek musb controller differences in the commit log
> 3. Abondon patch "usb: musb: Move musbhsdma macro definition to musb_dma.h"
> 4. Add "|| COMPILE_TEST" in Kconfig
> 5. Add musb_clearb() and musb_clearw() hooks
> 6. Add get_toggle() and set_toggle() hooks
> 7. Replace musb_readl() with musb_readw() to read 16bit toggle register
> 8. Move MediaTek's private toggle registers from musb_regs.h to mediatek.c
> 9. Create musbhs_dma_controller_create_noirq()
> 
> Min Guo (4):
>   dt-bindings: usb: musb: Add support for MediaTek musb controller
>   arm: dts: mt2701: Add usb2 device nodes
>   usb: musb: Extract set toggle as a separate interface
>   usb: musb: Add support for MediaTek musb controller
> 
>  .../devicetree/bindings/usb/mediatek,musb.txt      |  43 ++
>  arch/arm/boot/dts/mt2701-evb.dts                   |  21 +
>  arch/arm/boot/dts/mt2701.dtsi                      |  33 ++
>  drivers/usb/musb/Kconfig                           |   8 +-
>  drivers/usb/musb/Makefile                          |   1 +
>  drivers/usb/musb/mediatek.c                        | 617 +++++++++++++++++++++
>  drivers/usb/musb/musb_core.c                       |  69 +++
>  drivers/usb/musb/musb_core.h                       |   9 +
>  drivers/usb/musb/musb_dma.h                        |   9 +
>  drivers/usb/musb/musb_host.c                       |  35 +-
>  drivers/usb/musb/musb_io.h                         |   6 +
>  drivers/usb/musb/musbhsdma.c                       |  55 +-
>  12 files changed, 868 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
>  create mode 100644 drivers/usb/musb/mediatek.c
> 

I tried the series on my mt7623

Tested-by: Ryder Lee <ryder.lee@mediatek.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

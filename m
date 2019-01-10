Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425DEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:49:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12213206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qAOr7qpw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT6rikCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12213206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rLfFHtEd8jTnIVFbjiZv7U3U4EUEsowzYVjOytjNFSE=; b=qAOr7qpw20t2Cf
	GdAFQGvWKSNGMiJg18ThPuT1Ru+a/DJMSPdW7gGFxkGzqplxz9AOpLdmt6Ut5bH57gcyYgrYFD4Jg
	oseleYmG1XGvdo98We/F3/HVAkNtz3RkOuPicFy5gbw0YvRZIWNKsUmXKooUQSoq3Jw+WNFP27hDD
	Y+wcl4vhxq4VhiS1J+OydJYLDjQaPokMwkRCexAlYmPx+7qUHULznShZjmfO4X4Zfk9CBKRamUgLw
	ErCch7ZUZ9HcE/RIx/sDW5hVKThGsvdw5YvYcK820rV+kdtK5NAL2yXgopSf2Cwviim0xCwdyu2K2
	DOsflOT2YYuskOaCsCsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdWA-0000nD-TJ; Thu, 10 Jan 2019 16:49:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdW6-0000ma-S0
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:49:16 +0000
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 03ACC206B7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547138954;
 bh=xsnjqhuZJ9KzzhhGhsUf2Xx3JX61cB4FzMxRVnXI4Q0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=BT6rikCiqNCJadXZUXNmRX9d9JHmB8U4rtNF35mSibn8cKNOMsQMHYN0lQiUGfWBQ
 FpSK7g8ID/fIDKfTrlMgAVzMuZ+Z/cPhLGUBTd7PZS+Yhu5/WQBUocFYIWxWI1ayMT
 lYtg3Ou8VzqG+PuAAadKI80t7HY3BDcPXqBuiMTs=
Received: by mail-qt1-f169.google.com with SMTP id v11so13904116qtc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 08:49:13 -0800 (PST)
X-Gm-Message-State: AJcUukcVsc1ypCf8lcobBto76E+nu0W2U2laHlmwBpAkq+9xs52YF4sW
 aGo1kvmehN3siM3lXwtPUX3B27TgV5zxq6UWHw==
X-Google-Smtp-Source: ALg8bN4xldI/Miwo9HXUJPBpA/jHxyoBCYOMMVvm/RezheoPqqQ3nHkH/EOX8PO/n16APDq3CYwv0m1/66kREwBpyb8=
X-Received: by 2002:a37:b646:: with SMTP id g67mr9959076qkf.326.1547138953214; 
 Thu, 10 Jan 2019 08:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 10 Jan 2019 10:49:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJt3aKGBPCu49OxJx0_HDu5r1W9NhRfREowaBMQ047dSA@mail.gmail.com>
Message-ID: <CAL_JsqJt3aKGBPCu49OxJx0_HDu5r1W9NhRfREowaBMQ047dSA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add Oxalis board support
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_084914_923908_05255A70 
X-CRM114-Status: GOOD (  16.59  )
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
Cc: devicetree@vger.kernel.org, a.tropschug@ebs-systart.com,
 m.bittner@ebs-systart.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, Yang-Leo Li <leoyang.li@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 2:08 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hello,
>
> This patchset adds Oxalis board support. This board is one of the
> 96Boards Enterprise Edition platform from EBS-SYSTART GmbH. Below are some
> of the key features of this board:
>
> * SoC: NXP Layerscape LS1012A
> * RAM: 1GB DDR3L
> * PMU: NXP VR5100
> * Storage: 64MByte SPI Flash for bootloader and RCW, MicroSD Card, SATA
> * Connectivity: 2x Ethernet
> * USB: 2x USB3.0
>
> More information about this board can be found in 96Boards product
> page: https://www.96boards.org/product/oxalis/
>
> Ethernet and SPI flash are not supported yet!
>
> Thanks,
> Mani
>
> Manivannan Sadhasivam (3):
>   dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
>   dt-bindings: arm: fsl: Add devicetree binding for Oxalis
>   arm64: dts: freescale: Add devicetree for Oxalis
>
>  Documentation/devicetree/bindings/arm/fsl.txt |  4 +

This is converted to json-schema now (in Shawn's tree), so you'll need
to update to that.

Rob

>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../boot/dts/freescale/fsl-ls1012a-oxalis.dts | 96 +++++++++++++++++++
>  4 files changed, 102 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
>
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

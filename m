Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C848AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:19:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA422075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KW4QNk5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA422075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q8XjRWE7/wQpMDTRhtFmdda1MuAnn7ZiSQMoVoSqxNY=; b=KW4QNk5Ss1E5MQ
	y8iE5YqDApZSescoHDWMfDVPyrbCme/A2PBlLlm9RzrajZ3RTLBulqieaIvm8rviedhJSCgdPtcvy
	XhonfwA26lk3x2w0R3AWrSTwFdnaqGsdsAAg4HiXIa3ryf2EqN1LLNPksB7+zb060izyW9N56f274
	KfoEpHT1YHr6PNkuUNFiiMUt07dMBYvRad2KLIQS2MDwyO06tTRFetIgx0j+yZuWIRyCfg35Xlr43
	JeFrJ0kc8ZWBSHjhF4/ApCck+NoZai+xpVM8Go9r6Q6RL7x3h4ALXVW/mIR56t9WMcVLD3Y8sur1B
	+hcGfvIKb2AWE3AXprgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghEhU-00073w-Un; Wed, 09 Jan 2019 14:19:20 +0000
Received: from skedge04.snt-world.com ([91.208.41.69])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEhQ-00072r-MI; Wed, 09 Jan 2019 14:19:19 +0000
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge04.snt-world.com (Postfix) with ESMTPS id 7B11567A8CB;
 Wed,  9 Jan 2019 15:19:09 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 9 Jan 2019
 15:19:09 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 9 Jan 2019 15:19:09 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Thread-Topic: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUpzP4PV9+XjynmUWrRoOqEAtjTqWm7WUA
Date: Wed, 9 Jan 2019 14:19:08 +0000
Message-ID: <7188c406-3dd2-88a6-b6ed-d5e8bf678df8@kontron.de>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <D484D617F02B3D468BA088497AB4F7A5@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 7B11567A8CB.A005C
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
 computersforpeace@gmail.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 marek.vasut@gmail.com, mark.rutland@arm.com, robh@kernel.org,
 shawnguo@kernel.org, yogeshnarayan.gaur@nxp.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_061917_049680_224D380E 
X-CRM114-Status: GOOD (  15.33  )
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
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 08.01.19 10:24, Yogesh Narayan Gaur wrote:
> - Add driver for NXP FlexSPI host controller
> 
>   FlexSPI is a flexsible SPI host controller [1], Chapter 30 page 1475,
>   which supports two SPI channels and up to 4 external devices.
>   Each channel supports Single/Dual/Quad/Octal mode data transfer (1/2/4/8 bidirectional data lines)
>   i.e. FlexSPI acts as an interface to external devices, maximum 4, each with up to 8
>   bidirectional data lines.
> 
> - Tested this driver with mtd_debug(Erase/Write/Read) utility and JFFS2
>   filesystem mounting and booting on NXP LX2160ARDB[2] and LX2160AQDS targets.
>   LX2160ARDB is having two NOR slave device connected on single bus A
>   i.e. A0 and A1 (CS0 and CS1).
>   LX2160AQDS is having two NOR slave device connected on separate buses
>   one flash on A0 and second on B1 i.e. (CS0 and CS3).
>   Verified this driver on following SPI NOR flashes:
>     Micron, mt35xu512aba, [Read - 1 bit mode]
>     Cypress, s25fl512s, [Read - 1/2/4 bit mode]
> 
> [1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
> [2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?submitter=182097
> 
> Yogesh Narayan Gaur (5):
>    spi: spi-mem: Add driver for NXP FlexSPI controller
>    dt-bindings: spi: add binding file for NXP FlexSPI controller
>    arm64: dts: lx2160a: add FlexSPI node property
>    arm64: defconfig: enable NXP FlexSPI driver
>    MAINTAINERS: add maintainers for the NXP FlexSPI driver
> 
> Changes for v6:
> - Rebase on top of v5.0-rc1.

Your patches don't apply to v5.0-rc1. It seems like you have instead 
rebased onto the for-5.1 or for-next branch of the SPI tree. I guess 
this is okay, but you should have pointed that out correctly here.

> - Incorporated review comments for
>    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> - Updated s-b tag in all patches.
> Changes for v5:
> - Rebase on top of v4.20-rc2
> - Incorporated review comments for
>    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> Changes for v4:
> - Incorporated review comments for
>    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> - Incorporated binding file review comments.
> Changes for v3:
> - Incorporated review comments for
>    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> Changes for v2:
> - Incorporated Boris review comments and drop below patches as per the comments.
>   - Patch 'spi: add slave device size in spi_device struct'
>   - Patch 'spi: add flags for octal I/O data transfer'
> - Incorporated DTS and Binding file review comments of Shawn Guo and Rob Herring.
> 
>   .../devicetree/bindings/spi/spi-nxp-fspi.txt  |   39 +
>   MAINTAINERS                                   |    7 +
>   .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |   22 +
>   .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   13 +
>   arch/arm64/configs/defconfig                  |    1 +
>   drivers/spi/Kconfig                           |   10 +
>   drivers/spi/Makefile                          |    1 +
>   drivers/spi/spi-nxp-fspi.c                    | 1095 +++++++++++++++++
>   8 files changed, 1188 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
>   create mode 100644 drivers/spi/spi-nxp-fspi.c
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

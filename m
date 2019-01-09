Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6872CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:27:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EE6206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZVY7J/Fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EE6206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jUsmr/aYjtXGleHA3gtoVdJX79zhsHPbmHTg8imNnbM=; b=ZVY7J/FmAXLYiz
	9KR/eweR8Whef1Pkg8CRm4BJAHu4Fa+Pq/uDwO1ZTTq5J49vrJMmW2yO9ym3tt+shwjjb17fEPOxh
	JLMy1vcsACrNGSAwLbjcX5axvCEw5BZfippJCPkdCMuzvDzOYtw3fNQkeYjP6tkHNWRLHZLeAxJ1L
	azPvdB1EyESef1VoGLvjj3pskpK4YGIhdQeH6HGQwXLNUtVMygV74I9x5R6U95qt+m5vYKsLq11Bi
	wAl2AYhNJMJfxpP422Nk0rPSxyRj3A9sEEKuNdmZEl4yDQlB4MOsQf3ZyHYX1ePEArL9XW2v/3uik
	22pTwuQKHGZ6WJuXDIxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghFkx-0002b2-4e; Wed, 09 Jan 2019 15:26:59 +0000
Received: from skedge04.snt-world.com ([91.208.41.69])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghFkq-0002UL-Sc; Wed, 09 Jan 2019 15:26:55 +0000
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge04.snt-world.com (Postfix) with ESMTPS id E450767A8D2;
 Wed,  9 Jan 2019 16:26:49 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 9 Jan 2019
 16:26:49 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 9 Jan 2019 16:26:49 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Thread-Topic: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUpzP4PV9+XjynmUWrRoOqEAtjTqWm7WUAgAAKcQCAAAh4gA==
Date: Wed, 9 Jan 2019 15:26:49 +0000
Message-ID: <33797571-8456-0b18-087b-71330901f3a8@kontron.de>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <7188c406-3dd2-88a6-b6ed-d5e8bf678df8@kontron.de>
 <20190109155630.3ec34c60@jawa>
In-Reply-To: <20190109155630.3ec34c60@jawa>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <F78142B445677D4FB3828DDBF8E2597B@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: E450767A8D2.A0A1D
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
 computersforpeace@gmail.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 lukma@denx.de, marek.vasut@gmail.com, mark.rutland@arm.com,
 robh@kernel.org, shawnguo@kernel.org, yogeshnarayan.gaur@nxp.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_072653_277556_087D68DF 
X-CRM114-Status: GOOD (  18.29  )
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
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lukasz,

On 09.01.19 15:56, Lukasz Majewski wrote:
> Hi Schrempf,
> 
>> On 08.01.19 10:24, Yogesh Narayan Gaur wrote:
>>> - Add driver for NXP FlexSPI host controller
>>>
>>>    FlexSPI is a flexsible SPI host controller [1], Chapter 30 page
>>> 1475, which supports two SPI channels and up to 4 external devices.
>>>    Each channel supports Single/Dual/Quad/Octal mode data transfer
>>> (1/2/4/8 bidirectional data lines) i.e. FlexSPI acts as an
>>> interface to external devices, maximum 4, each with up to 8
>>> bidirectional data lines.
>>>
>>> - Tested this driver with mtd_debug(Erase/Write/Read) utility and
>>> JFFS2 filesystem mounting and booting on NXP LX2160ARDB[2] and
>>> LX2160AQDS targets. LX2160ARDB is having two NOR slave device
>>> connected on single bus A i.e. A0 and A1 (CS0 and CS1).
>>>    LX2160AQDS is having two NOR slave device connected on separate
>>> buses one flash on A0 and second on B1 i.e. (CS0 and CS3).
>>>    Verified this driver on following SPI NOR flashes:
>>>      Micron, mt35xu512aba, [Read - 1 bit mode]
>>>      Cypress, s25fl512s, [Read - 1/2/4 bit mode]
>>>
>>> [1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
>>> [2]
>>> https://patchwork.kernel.org/project/linux-arm-kernel/list/?submitter=182097
>>>
>>> Yogesh Narayan Gaur (5):
>>>     spi: spi-mem: Add driver for NXP FlexSPI controller
>>>     dt-bindings: spi: add binding file for NXP FlexSPI controller
>>>     arm64: dts: lx2160a: add FlexSPI node property
>>>     arm64: defconfig: enable NXP FlexSPI driver
>>>     MAINTAINERS: add maintainers for the NXP FlexSPI driver
>>>
>>> Changes for v6:
>>> - Rebase on top of v5.0-rc1.
>>
>> Your patches don't apply to v5.0-rc1. It seems like you have instead
>> rebased onto the for-5.1 or for-next branch of the SPI tree. I guess
>> this is okay, but you should have pointed that out correctly here.
> 
> If I may ask for a few (1-2) days, so I can test this code on vf610 NXP
> SoC.
> 
> As fair as I remember there were some issues when I tested it a few
> months back.

You're probably mixing that up. This series is about the FlexSPI 
controller in the Layerscape SOCs.

The QuadSPI driver is already in linux-next to be merged in 5.1 [1]. The 
issues with vf610 existed in the old SPI-NOR driver and probably still 
exist in the new SPI driver. You are welcome to test the new driver and 
come up with some fixes.

Sooner or later, there will probably also be other changes coming up, 
such as implementation of the dirmap API.

Thanks,
Frieder

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/spi?h=next-20190109&id=84d043185dbe0d1b4f6db575bd91c834d37e2f78

> 
>>
>>> - Incorporated review comments for
>>>     patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
>>> - Updated s-b tag in all patches.
>>> Changes for v5:
>>> - Rebase on top of v4.20-rc2
>>> - Incorporated review comments for
>>>     patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
>>> Changes for v4:
>>> - Incorporated review comments for
>>>     patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
>>> - Incorporated binding file review comments.
>>> Changes for v3:
>>> - Incorporated review comments for
>>>     patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
>>> Changes for v2:
>>> - Incorporated Boris review comments and drop below patches as per
>>> the comments.
>>>    - Patch 'spi: add slave device size in spi_device struct'
>>>    - Patch 'spi: add flags for octal I/O data transfer'
>>> - Incorporated DTS and Binding file review comments of Shawn Guo
>>> and Rob Herring.
>>>
>>>    .../devicetree/bindings/spi/spi-nxp-fspi.txt  |   39 +
>>>    MAINTAINERS                                   |    7 +
>>>    .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |   22 +
>>>    .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   13 +
>>>    arch/arm64/configs/defconfig                  |    1 +
>>>    drivers/spi/Kconfig                           |   10 +
>>>    drivers/spi/Makefile                          |    1 +
>>>    drivers/spi/spi-nxp-fspi.c                    | 1095
>>> +++++++++++++++++ 8 files changed, 1188 insertions(+)
>>>    create mode 100644
>>> Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt create mode
>>> 100644 drivers/spi/spi-nxp-fspi.c
>> ______________________________________________________
>> Linux MTD discussion mailing list
>> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
> 
> 
> 
> Best regards,
> 
> Lukasz Majewski
> 
> --
> 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

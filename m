Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81CCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:05:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3A5206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 10:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yqw9/y0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3A5206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aRRNuhgMQ68xGoSe7ujZFt4rB5EOpKa62Rs1YeIOQr4=; b=Yqw9/y0ro0LdvL
	n25kIEg5UIXcAeTwYrSiFLurdQnme0CzKDrGuaJk5InpOmGQ2SIYYhdNb20CR1F8C122kbzuK7QXk
	l+E7gJX4EFsjsTT/7bwKVDQEkpmnfPOJkmTz/Np2dkrTKrxcUXAXA9V0s1SIBGht1IjT+vDoZHgT+
	6QwD3I6w04FDHCiKMm6h0oxDRvW9j2tmaCSgi9vnJX0pCGfpmjEDbI88p+HU3sg87deQlfPmHyP52
	uLBGhmGkuXRUj8/u7fF0Y7ZaMJsweVmzT3lqsujH8fl15DFicES0nKj4WLguR/iA6qC2Q5RWdFW5t
	FymhNhQ5gBdINRj9J8BQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gY6ot-0000eN-R5; Sat, 15 Dec 2018 10:05:15 +0000
Received: from skedge04.snt-world.com ([91.208.41.69])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gY6op-0007pT-7d; Sat, 15 Dec 2018 10:05:13 +0000
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge04.snt-world.com (Postfix) with ESMTPS id D3F0D67A7DC;
 Sat, 15 Dec 2018 11:04:55 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Sat, 15 Dec
 2018 11:04:55 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Sat, 15 Dec 2018 11:04:55 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: AW: [PATCH 0/5] Prepare devicetrees for the new FSL QSPI driver
Thread-Topic: [PATCH 0/5] Prepare devicetrees for the new FSL QSPI driver
Thread-Index: AQHUkKVtG6It8sv/EE6xXPNZqAZcLKV4GW2AgARFkACAAPregIACPlr7
Date: Sat, 15 Dec 2018 10:04:55 +0000
Message-ID: <937b0f34e3eb485aaae45cd649cdeb4f@kontron.de>
References: <1544459182-23655-1-git-send-email-frieder.schrempf@kontron.de>
 <ce1442f3-357b-d647-958e-cc4a89282b79@kontron.de>
 <1ad93cdf-7ba1-ff49-f330-6bbd0f6c6972@kontron.de>,
 <20181214004251.GA15775@dragon>
In-Reply-To: <20181214004251.GA15775@dragon>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: D3F0D67A7DC.A275E
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
 devicetree@vger.kernel.org, fabio.estevam@nxp.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-imx@nxp.com, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 s.hauer@pengutronix.de, shawnguo@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181215_020511_596872_F51E5BC5 
X-CRM114-Status: GOOD (  22.05  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

>On Thu, Dec 13, 2018 at 09:45:04AM +0000, Schrempf Frieder wrote:
>> + Shawn, Sascha
>>
>> On 10.12.18 17:31, Schrempf Frieder wrote:
>> > Hi FSL/ARM maintainers,
>> >
>> > On 10.12.18 17:26, Schrempf Frieder wrote:
>> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>> >>
>> >> We have prepared a new driver for the FSL QSPI controller that works under
>> >> the SPI framework. The current devicetrees are broken because they use an
>> >> inconsistent scheme for assigning the reg properties.
>> >>
>> >> As, in contrast to the current driver, the new driver will use the reg
>> >> properties to select the correct chip, we need to fix them.
>> >>
>> >> We also add spi-[tx/rx]-bus-width to make sure the full buswidth will be used
>> >> and while at it clean up and remove some unused properties.
>> >
>> > could you please consider these devicetree patches for v4.21?
>>
>> Any chance to get this merged? Otherwise we would need to postpone the
>> new driver even further.
>
>As it came up a little bit late (the same day I sent pull request for
>4.21), I was considering it as 4.22 material.  But as you mentioned that
>the series is non-intrusive, I can try to send it to arm-soc folk for
>4.21 merge window, and then that will be their call.  But before I do
>it, I need you to double confirm that the series will not break anything
>that is already working.

I can confirm, that the series does only remove or add properties to the
devicetree, that are currently not used by the driver. Therefore it won't break
anything.

Thanks,
Frieder

>
>Shawn
>
>>
>> All the changes to the devicetrees in this series are non-intrusive and
>> uncritical, anyway.
>>
>> Thanks,
>> Frieder
>>
>> >
>> > We have the new FSL QSPI driver under the SPI framework ([1]) ready, but
>> > we need some small fixes to the devicetrees that are currently broken.
>> >
>> > As the new driver depends on these changes (mainly the change to the reg
>> > properties) and it is not possible to add compatibility for the old
>> > bindings, it would be really nice to have them in v4.21, so we can queue
>> > the driver for v4.22 or whatever the next release will be called.
>> >
>> > Please also see [2] for some more explanation.
>> >
>> > Thanks,
>> > Frieder
>> >
>> > [1] https://patchwork.ozlabs.org/cover/1007641/
>> > [2] https://patchwork.ozlabs.org/patch/922817/#1925445
>> >
>> >>
>> >> Frieder Schrempf (5):
>> >>     arm64: dts: Remove unused properties from FSL QSPI driver nodes
>> >>     ARM: dts: Remove unused properties from FSL QSPI driver nodes
>> >>     ARM: dts: imx6sx-sdb: Fix the reg properties for the FSL QSPI nodes
>> >>     arm64: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller
>> >>     ARM: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller
>> >>
>> >>    arch/arm/boot/dts/imx6sx-sdb-reva.dts              | 8 ++++++--
>> >>    arch/arm/boot/dts/imx6sx-sdb.dts                   | 8 ++++++--
>> >>    arch/arm/boot/dts/imx6ul-14x14-evk.dtsi            | 2 ++
>> >>    arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts        | 5 ++---
>> >>    arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 3 ++-
>> >>    arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 4 ++--
>> >>    arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 6 ++++--
>> >>    arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 4 ++++
>> >>    8 files changed, 28 insertions(+), 12 deletions(-)
>> >>
>> > ______________________________________________________
>> > Linux MTD discussion mailing list
>> > http://lists.infradead.org/mailman/listinfo/linux-mtd/
>> >
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

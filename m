Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B714C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:24:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6932D204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mjDnbI99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6932D204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pzy0/GdGPkZwIHg7IC8F28xHEfMVH/yNdvpHoFbCX7Y=; b=mjDnbI99yZhZTq
	dV3EMkpOSdH6J9MMYKRB7WKnE4H+2q2Eq2Pna34dhzkjqr6MQlMo7S6zsUM5skVN5bWeeapp/K3b5
	6ltStfwR9LKqiMb6G3hZgVBD+7RS23E7AJPLQT4pzSsIZqmthhPI5g9KF4AYtVj1WeoTD3pRdwK5b
	3H0CiPmo1kjzE9zdsjzzpMxGF34fVs74uIsJ7PWhoEJkZOn38E8nTpuC+OMFBtyjtvKi7jEDVDUY+
	KYeWDXVoPiSITEep380PnK1N0tfBrhg+RcGGkxZpfKSVPJVZBPcR9j92RXZaAD239WXyEyvB7jgeo
	vPxFTvOKiZdhixtkbP/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQZU-0005S7-PL; Tue, 15 Jan 2019 15:24:08 +0000
Received: from skedge04.snt-world.com ([91.208.41.69])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQZR-0005RG-28; Tue, 15 Jan 2019 15:24:07 +0000
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge04.snt-world.com (Postfix) with ESMTPS id 14FA667A8C7;
 Tue, 15 Jan 2019 16:24:02 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 15 Jan
 2019 16:24:01 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Tue, 15 Jan 2019 16:24:01 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v8 5/7] ARM: dts: ls1021a: Remove fsl, qspi-has-second-chip
 as it is not used
Thread-Topic: [PATCH v8 5/7] ARM: dts: ls1021a: Remove
 fsl,qspi-has-second-chip as it is not used
Thread-Index: AQHUpmuMXeMdtslsvU+hS8nO3SBmbKWsg0qAgAHipwCAAgeLgIAAAZcA
Date: Tue, 15 Jan 2019 15:24:01 +0000
Message-ID: <7ffa6d92-3fdd-f838-ab6d-185ea5f1c103@kontron.de>
References: <20190107092823.11188-1-frieder.schrempf@kontron.de>
 <20190107092823.11188-6-frieder.schrempf@kontron.de>
 <20190113033117.GG11426@dragon>
 <ee3eb5d5-4b04-002e-5e49-d4b766138ec5@kontron.de>
 <20190115151818.GD13895@dragon>
In-Reply-To: <20190115151818.GD13895@dragon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <A70D2C538BB6254E8E263CC9273AD2A0@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 14FA667A8C7.A44DC
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
 computersforpeace@gmail.com, david.wolfe@nxp.com,
 devicetree@vger.kernel.org, dwmw2@infradead.org,
 fabio.estevam@nxp.com, han.xu@nxp.com, leoyang.li@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 marek.vasut@gmail.com, mark.rutland@arm.com,
 miquel.raynal@bootlin.com, prabhakar.kushwaha@nxp.com,
 richard@nod.at, robh+dt@kernel.org, shawnguo@kernel.org,
 yogeshnarayan.gaur@nxp.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_072405_424008_A76296BD 
X-CRM114-Status: GOOD (  12.47  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "richard@nod.at" <richard@nod.at>,
 "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
 "han.xu@nxp.com" <han.xu@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 15.01.19 16:18, Shawn Guo wrote:
> On Mon, Jan 14, 2019 at 08:18:49AM +0000, Schrempf Frieder wrote:
>> Hi Shawn,
>>
>> On 13.01.19 04:31, Shawn Guo wrote:
>>> On Mon, Jan 07, 2019 at 09:29:54AM +0000, Schrempf Frieder wrote:
>>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>>
>>>> After switching to the new FSL QSPI driver the property
>>>> 'fsl,qspi-has-second-chip' is not needed anymore.
>>>>
>>>> The driver now uses the 'reg' property to determine the bus and
>>>> the chipselect.
>>>>
>>>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>
>>> Applied, thanks.
>>
>> I just noticed, that this and the arm64 patch depend on the driver
>> changes for 5.1 that go through the SPI tree. So I guess we can't be
>> sure that this will be merged in the right order and we need to delay
>> this cleanup to 5.2, or am I wrong?
> 
> You are right.  I just dropped the both patches.  Ping me or resend when
> they are ready to go.

Thanks, will do so.

Frieder
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

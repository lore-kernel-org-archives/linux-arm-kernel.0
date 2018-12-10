Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB371C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:34:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFA720821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d2Xv8n7B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wD5Rhf7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFA720821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w1mdcSWTxhP9KpqHn48xPz5dprTXQ0GpI1Xzpyf/DuQ=; b=d2Xv8n7BPZJd2w
	kyXY+EG9HGcEZ8VsVRr4SYEJxZRuhBzAcsdLaiC8moSsGNLA4e66/0CPWx3sbb/KKuQh/NeBlQxT+
	dlj8vY3T5RkqVQBUf4TlEAg+BQV2wINf3CizV0kv5R1/esTjgE5gSPGpqeNx2Sei58lsSIoAnVt0s
	AsZ06TmCNQaeefIqf5KdippGiJaf01Hxz7V++iiKeAKDuzXhmyW/MPr6G5KEFeQ7v8Dhegl/GDqCz
	U+1Palu6OcSSO8cs258Sl6eFUX++OQhu8dQcaOCzhzTyIjlJLzQu9QPGI+LBYHAT1Dij5pvYkashO
	4AvG1dJm++rJccohfJnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOWA-0005nP-UL; Mon, 10 Dec 2018 16:34:50 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOVy-0005Qv-Gu; Mon, 10 Dec 2018 16:34:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:
 From:Sender:Reply-To:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8Naal0pAvVlOlkjd/gUT4jlNyZzWCTayS7SWzS1Uslc=; b=wD5Rhf7GIwO+3vfEd4/A1ca4y8
 t+KQg9BK3++Cc+P0MoJ8l50mo/eRXTdzneANBD03vR0cOqMDwuCJDocRNLnCphfaclJZSPLAyfcFN
 SE9BrXLh/PP+BrmPqd5T98AgVdDwhYACFgR2O/s8GiHuDK26lbbe4HTJ0zDZQCuFGUhhVDsJX7jRn
 Yz5/FPu0pArB/2Di4e0oIxZi4MpACtZsTY+r3j7mJ+tE1jjbRRvCkzqjuEpswiqKlvUjfg5kOsuiB
 VUoispKoZtzFqkr2oLn1/pDFOcuJkkbjO7kasjk21LACrNTcJ4sgenS4E7R8H2AqwSpiLPJ1L12M3
 sYf52LAQ==;
Received: from skedge03.snt-world.com ([91.208.41.68])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOSk-000815-52; Mon, 10 Dec 2018 16:31:21 +0000
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge03.snt-world.com (Postfix) with ESMTPS id 0227B67A65D;
 Mon, 10 Dec 2018 17:31:04 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 10 Dec
 2018 17:31:03 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Mon, 10 Dec 2018 17:31:03 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/5] Prepare devicetrees for the new FSL QSPI driver
Thread-Topic: [PATCH 0/5] Prepare devicetrees for the new FSL QSPI driver
Thread-Index: AQHUkKVtG6It8sv/EE6xXPNZqAZcLKV4GW2A
Date: Mon, 10 Dec 2018 16:31:03 +0000
Message-ID: <ce1442f3-357b-d647-958e-cc4a89282b79@kontron.de>
References: <1544459182-23655-1-git-send-email-frieder.schrempf@kontron.de>
In-Reply-To: <1544459182-23655-1-git-send-email-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <BCFF43A4956638429CD7C267D0D3E012@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 0227B67A65D.A4F60
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
 devicetree@vger.kernel.org, fabio.estevam@nxp.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-imx@nxp.com, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_163118_290243_309B8212 
X-CRM114-Status: GOOD (  22.14  )
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
Cc: "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi FSL/ARM maintainers,

On 10.12.18 17:26, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> We have prepared a new driver for the FSL QSPI controller that works under
> the SPI framework. The current devicetrees are broken because they use an
> inconsistent scheme for assigning the reg properties.
> 
> As, in contrast to the current driver, the new driver will use the reg
> properties to select the correct chip, we need to fix them.
> 
> We also add spi-[tx/rx]-bus-width to make sure the full buswidth will be used
> and while at it clean up and remove some unused properties.

could you please consider these devicetree patches for v4.21?

We have the new FSL QSPI driver under the SPI framework ([1]) ready, but 
we need some small fixes to the devicetrees that are currently broken.

As the new driver depends on these changes (mainly the change to the reg 
properties) and it is not possible to add compatibility for the old 
bindings, it would be really nice to have them in v4.21, so we can queue 
the driver for v4.22 or whatever the next release will be called.

Please also see [2] for some more explanation.

Thanks,
Frieder

[1] https://patchwork.ozlabs.org/cover/1007641/
[2] https://patchwork.ozlabs.org/patch/922817/#1925445

> 
> Frieder Schrempf (5):
>    arm64: dts: Remove unused properties from FSL QSPI driver nodes
>    ARM: dts: Remove unused properties from FSL QSPI driver nodes
>    ARM: dts: imx6sx-sdb: Fix the reg properties for the FSL QSPI nodes
>    arm64: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller
>    ARM: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller
> 
>   arch/arm/boot/dts/imx6sx-sdb-reva.dts              | 8 ++++++--
>   arch/arm/boot/dts/imx6sx-sdb.dts                   | 8 ++++++--
>   arch/arm/boot/dts/imx6ul-14x14-evk.dtsi            | 2 ++
>   arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts        | 5 ++---
>   arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 3 ++-
>   arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 4 ++--
>   arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 6 ++++--
>   arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 4 ++++
>   8 files changed, 28 insertions(+), 12 deletions(-)
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

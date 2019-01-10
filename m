Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F63C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:13:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CBE220651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ByaIf718";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R/+BmORh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBE220651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qr5jp/SG2EGZYQi1l1TSmnY/0kAHgBjBxyXkiuhda74=; b=ByaIf718A3YLY7
	6kuA0Z/lDT+o9EHU4cxvEQy8prAcnz6JOSc0rYDSOv70KRabrJuPqnfnK825nGcw9WquQu6EWEt18
	teTr4D6nGi5omZoWpHYx2Ca3uhHgF7heir6RGo/+Bq/YCc9AkB42CS2QNzeKqIf8cXvaDnK+xsd5Z
	HPXzcNYzJnowkUn5pgeTP5iCm12sT86sKrVI4r8tVaAv+4zFHxa44zsKQ39l8kd30FHybL96+aDUW
	i9RSNnxji3xNYX3GHSQSG7aQ+keaWj18NLno+sPXdYb0D1ELV6kQ0+Zr1RqzRngrRmMjSLbFDdAUB
	SM1sfNLDrBH/f606Ap3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghSeN-00021i-6W; Thu, 10 Jan 2019 05:13:03 +0000
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghSeA-0001uQ-Jg; Thu, 10 Jan 2019 05:12:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJYWTp2UF1IlrJokz/5918ZkaA4eG/Iv6Q16lVC5o9Y=;
 b=R/+BmORhRp16KmM5EirhlKU/h16clwlf/rjuzA7UFTEsjz7Syw2WQ3eUKTQTFg+WTiNu/aQMm2y4ooy9Qpb/s9cIIdZE3n/XuEX2Oc+AgDCTQzJCg5YW2U8jb8fl628hLELpQhLP88CxE8xfdP7BbJuislNF28XBLxEvP1DnBgM=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5278.eurprd04.prod.outlook.com (20.177.51.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 05:12:45 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1495.011; Thu, 10 Jan 2019
 05:12:45 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: Schrempf Frieder <frieder.schrempf@kontron.de>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Thread-Topic: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUpzP4PV9+XjynmUWrRoOqEAtjTqWm7WUAgAEJsCA=
Date: Thu, 10 Jan 2019 05:12:45 +0000
Message-ID: <VI1PR04MB5726A7CD5886403774D870B999840@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <7188c406-3dd2-88a6-b6ed-d5e8bf678df8@kontron.de>
In-Reply-To: <7188c406-3dd2-88a6-b6ed-d5e8bf678df8@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.143.254.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5278;
 6:58c6C41vz3Mr781BXe1yX5GODpmOC/InU3q0+e4yQi9tNEU0kOPtuHWx9rHf/2FP/dkOd4l+QNzXjFGGSjggTUl0nvZza8k4NQYp2a2vKNB/9MEb7q450mEYT35G84+ZJ9zjmQL3/ansk5WslCgsLJgHm7C+57yZJB1DveOwJ4be7H2luqQA2E3yvbX0Opy+xNN5ClFyGpzDmCeVhpTCGGtvGBTTieuzQdoLxuTCqeUsdkVKVdOz48XDjJxaeY4FHbf8ydVZbMNtCpfNtBB1/8Hr1MQZp6rL+u+a7afPrqSYQcVsS8VnNjqeNGNrkOyeufc8mx/IDGHe5wYjIV3+I1BabQZ8uK5eZfhlvgK50VVuAFSSRnmsOGcn94eY80fOybU9O/rq41m1Yr+M1kTSsWcyLyEAe9JMQw6GvytSSWj9kFtHjz/zs0Gsw8M9S+E1tT9NPXkJSIDMECDuVsDq6Q==;
 5:4i81Vne2LX07Tru8HgVaxzId89GkRKoGumDNI6mfw/bJ6cKwt5v2Tq9odI9Ysl1Z1HK7dDjylK8I57SF6V6ZuLyFHd6uB5H5fE2BSvLwTRQ1/vPaUEK7C+PJpj+PjaAgem6HPfi4b9bNDXoLKqj3rDJF0kfUiIKOQKOrTMMpHKWEiWValWVLFmKdl9eQsDRJzuygRsT0SEfDChAhAstjNw==;
 7:jcIBV0FNJwJOf0fTmuJ/yEYhl8gPzTT1GllDG7ZWbOg5PlSST29f2drd0dKzU/qhesP0hi4l5Rhgm2sQuewSD9moDMh7BNg2aOsXeIoO8T7uvAhMRx0gd80arh/hFAsJ1UPrfSpjj9mFtAXSfJue9w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 50f51b9d-2608-4adc-8de0-08d676ba4178
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5278; 
x-ms-traffictypediagnostic: VI1PR04MB5278:
x-microsoft-antispam-prvs: <VI1PR04MB527890D03E8873F3D07CBB3799840@VI1PR04MB5278.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5278; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5278; 
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(13464003)(8936002)(256004)(99286004)(575784001)(86362001)(478600001)(53936002)(14454004)(6306002)(9686003)(486006)(966005)(76176011)(2906002)(55236004)(6506007)(7696005)(53546011)(6246003)(102836004)(186003)(26005)(106356001)(105586002)(7736002)(305945005)(2201001)(39060400002)(45080400002)(66066001)(4326008)(74316002)(476003)(446003)(11346002)(25786009)(5660300001)(7416002)(68736007)(78486014)(2501003)(33656002)(316002)(97736004)(81156014)(54906003)(55016002)(110136005)(81166006)(6436002)(6116002)(229853002)(3846002)(8676002)(71190400001)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5278;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PefqD0tMh1Pb0SUNiVPu6bbwrYYEdydl0zQOk508aiH9C4PM2YDNPayjAkZ+ePddENb94cjaXAkjEmgXQimyHJKmQJAmxW0DHErHSH1peIFwGLHuiwSja95MHZAOzubbC/jkI+BbVrqquqn+LQam2STmYJUtnET0HuJpTMxMawS3MkR8aTpJUw9mbvpaGZY/YeJLLTY3L7SXm3psv7E+PtgHV2om4ST7EXpQjHvNbz1qk3stXJsPrQiGI4jWD7xGqasDiyA9hZy0cG8m3id7Ed9beBY60+in5PLR7nq81w3tdu5/vat8wyBvhaNl1Ko7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f51b9d-2608-4adc-8de0-08d676ba4178
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 05:12:45.2657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5278
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_211250_752004_9DD85917 
X-CRM114-Status: GOOD (  21.96  )
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

Hi Frieder,

> -----Original Message-----
> From: Schrempf Frieder [mailto:frieder.schrempf@kontron.de]
> Sent: Wednesday, January 9, 2019 7:49 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd@lists.infradead.org; boris.brezillon@bootlin.com; marek.vasut@gmail.com;
> broonie@kernel.org; linux-spi@vger.kernel.org; devicetree@vger.kernel.org
> Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-
> arm-kernel@lists.infradead.org; computersforpeace@gmail.com; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
> 
> On 08.01.19 10:24, Yogesh Narayan Gaur wrote:
> > - Add driver for NXP FlexSPI host controller
> >
> >   FlexSPI is a flexsible SPI host controller [1], Chapter 30 page 1475,
> >   which supports two SPI channels and up to 4 external devices.
> >   Each channel supports Single/Dual/Quad/Octal mode data transfer (1/2/4/8
> bidirectional data lines)
> >   i.e. FlexSPI acts as an interface to external devices, maximum 4, each with up
> to 8
> >   bidirectional data lines.
> >
> > - Tested this driver with mtd_debug(Erase/Write/Read) utility and JFFS2
> >   filesystem mounting and booting on NXP LX2160ARDB[2] and LX2160AQDS
> targets.
> >   LX2160ARDB is having two NOR slave device connected on single bus A
> >   i.e. A0 and A1 (CS0 and CS1).
> >   LX2160AQDS is having two NOR slave device connected on separate buses
> >   one flash on A0 and second on B1 i.e. (CS0 and CS3).
> >   Verified this driver on following SPI NOR flashes:
> >     Micron, mt35xu512aba, [Read - 1 bit mode]
> >     Cypress, s25fl512s, [Read - 1/2/4 bit mode]
> >
> > [1]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww
> > .nxp.com%2Fdocs%2Fen%2Freference-
> manual%2FIMXRT1050RM.pdf&amp;data=02%
> >
> 7C01%7Cyogeshnarayan.gaur%40nxp.com%7C791570ed6d914f922a6c08d6763
> d6c96
> > %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C6368264035242944
> 30&amp;s
> >
> data=WTPdd1W4Tn4g6OOVeVVQylZ1Y72KUohWQ5QMxClwcgc%3D&amp;reser
> ved=0
> > [2]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> > chwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Flist%2F%3Fsubmitter%3
> >
> D182097&amp;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C791570
> ed6d91
> >
> 4f922a6c08d6763d6c96%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%
> 7C6368
> >
> 26403524294430&amp;sdata=QoAN4HtiTTD6UmToVwD6CfPyWN0C9nSQTBO3
> bYSXJtY%3
> > D&amp;reserved=0
> >
> > Yogesh Narayan Gaur (5):
> >    spi: spi-mem: Add driver for NXP FlexSPI controller
> >    dt-bindings: spi: add binding file for NXP FlexSPI controller
> >    arm64: dts: lx2160a: add FlexSPI node property
> >    arm64: defconfig: enable NXP FlexSPI driver
> >    MAINTAINERS: add maintainers for the NXP FlexSPI driver
> >
> > Changes for v6:
> > - Rebase on top of v5.0-rc1.
> 
> Your patches don't apply to v5.0-rc1. It seems like you have instead rebased
> onto the for-5.1 or for-next branch of the SPI tree. I guess this is okay, but you
> should have pointed that out correctly here.
> 
Yes, thanks for pointing out.
This patch series is based on 'for-next' branch of SPI tree repo [1].
Actually, I got confused with the Makefile content and that's why mentioned in comment as "Rebase on top of v5.0-rc1", sorry for confusion.
	VERSION = 5
	PATCHLEVEL = 0
	SUBLEVEL = 0
	EXTRAVERSION = -rc1

--
Regards
Yogesh Gaur
[1] https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/

> > - Incorporated review comments for
> >    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > - Updated s-b tag in all patches.
> > Changes for v5:
> > - Rebase on top of v4.20-rc2
> > - Incorporated review comments for
> >    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > Changes for v4:
> > - Incorporated review comments for
> >    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > - Incorporated binding file review comments.
> > Changes for v3:
> > - Incorporated review comments for
> >    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > Changes for v2:
> > - Incorporated Boris review comments and drop below patches as per the
> comments.
> >   - Patch 'spi: add slave device size in spi_device struct'
> >   - Patch 'spi: add flags for octal I/O data transfer'
> > - Incorporated DTS and Binding file review comments of Shawn Guo and Rob
> Herring.
> >
> >   .../devicetree/bindings/spi/spi-nxp-fspi.txt  |   39 +
> >   MAINTAINERS                                   |    7 +
> >   .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |   22 +
> >   .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   13 +
> >   arch/arm64/configs/defconfig                  |    1 +
> >   drivers/spi/Kconfig                           |   10 +
> >   drivers/spi/Makefile                          |    1 +
> >   drivers/spi/spi-nxp-fspi.c                    | 1095 +++++++++++++++++
> >   8 files changed, 1188 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> >   create mode 100644 drivers/spi/spi-nxp-fspi.c
> >
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

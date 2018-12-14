Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7116C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:28:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A587B2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uGR0KyV+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SW91BnTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A587B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dSUPTazZuK4CDW1m6nOLOLnO90NGkku+VhW27O8yZQ8=; b=uGR0KyV+jeu0l3
	ZQ2filBJG9jTqIwtnMy4+hTsKznYHNnxWDdLYZm3FLAou7FIKXKM+Y6hdpzFgl4g0gHusuXn3x4eQ
	9rphHZFa1vAB2DslZZwD9MYyk0umOgsu3yAoBiu0dQsBYZ+nU3K4Q5S/Lo/Rkdp3wHbMqEaZ7lkWF
	K+Ec5msza3MxMZ/m9Wz8uaNeSnLsAIGA1POVzTAAX4Qq6y3I9x9IldJpPv+YI6oL7GNS9W4BPj1bL
	LlZhvT6QdoeJrnh/HQbAPK2tBncTahYnNWGuWYjeVfrLUVsT1k19fFQqMZXYJPr03aQYb7iZ846be
	lhEjJ1yauMeVPudT3rAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXdDW-0001vt-GM; Fri, 14 Dec 2018 02:28:42 +0000
Received: from mail-ve1eur03on0610.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::610]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXdDS-0001vI-PB
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 02:28:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY7nB0/u6njwE5leZ/6kT7aP/E5OD9jPBP/BWCC+hiQ=;
 b=SW91BnTvIGb7nPVlHXu7G/KBFWapQ+wzrH1Z0waoY4kvyaHU1bwUrXTJi3GuNuD4y8poMROpv7cmnOygF/xmwOfIxD7hCv/GdI8+1x/hGPsAgQha7Xe8ZMWtnIDS0PdZHsmpZPYZlA9NjXXYtEVa3xg/WFGcEaEnulyJ9pIoGqc=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5809.eurprd04.prod.outlook.com (20.178.203.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Fri, 14 Dec 2018 02:28:23 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 02:28:23 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V11 2/7] clk: imx: add scu clock common part
Thread-Topic: [PATCH V11 2/7] clk: imx: add scu clock common part
Thread-Index: AQHUkoBHoRLNmKbTG0W2ArFlHoWixqV8S10AgAA08PCAAPPtgIAAAqXggAAKbQCAAAAo8A==
Date: Fri, 14 Dec 2018 02:28:23 +0000
Message-ID: <AM0PR04MB42111F2B6702F6B9D699A67480A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
 <1544662938-5020-3-git-send-email-aisheng.dong@nxp.com>
 <154468728640.19322.12955855783518519739@swboyd.mtv.corp.google.com>
 <AM0PR04MB42118C3E7F49A0437453BA5880A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154475103791.19322.8783777114832958727@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211D584BCE4B6D06D57637280A10@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <154475384479.19322.759264653632754113@swboyd.mtv.corp.google.com>
In-Reply-To: <154475384479.19322.759264653632754113@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB5809;
 6:QuKGJ4vBVRuIA6rzdfLNAZA8t2CYl16rKdPQboo5VaNSOsE2HJ6+luj1XlqayXPWkdYcCbkfzZ8TfTK9yKgFbSkIpR1KNhDdgYjx4xbjjml0rYK0B6OTFIN+C68hDozcFPWIOvm4lQ7GZINUcs9NWjgRrMpo2eDrKG+P0NErdCg3ygSbYWH4TmHJOH3AqL7ygiQVhrMs+g/bAFJeU948daeegBqdsK/wKYmZb5JIb3yN7C3J99RSpDiVew0PySHwiDlOQ/ttIe3xTtOJnrISmIQXxEy+T2v54VWURhWm5jopZloEnZ4ZfDZqXidAgXhrYEgDXQC7693iiagBmKfCC4SXQ+7jTzlsUrfkBY0TdkkWp+PuGa0tT/hYFkhr2rH+y9vdroKWe02rmNOGDTkAoYUw+bgfuO4Xc+b5MRILcH1x3zz46/4GzMcjiPNNL8Arnp8CLTjhtNoMgxI1fLdUJQ==;
 5:vdr18JeuFawc/uNCfbpj+CRRh8KABadhReRGIJ8y3myPU9Vz0YcSzPYMoEclooy8XiXNcbIRZZWA8Dn/Vr5KQGEC5T5tpgNu2md0BmXcxPwx9GxymvcFFKl+Jp18z+j+d+/Y6lDod9LZv2d6n3BRpcziwYj8H7pSagLhDestRqM=;
 7:Ax3+qsWC4zZhybHO6RBeLDkhqDsg1y5q3ad8BvjVTNVgmzEuBj9U/GhgRo2QjDKCIHfgcr3s2EOO6X/k2jGmHgarZyA3j6YF/ilRz5vfKbihSTyOAiRPmL8ilAiLqOnU3wv7PrjaSkn/8s2Bakcl2g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4020fb54-10f8-4b99-33c0-08d6616bd26b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB5809; 
x-ms-traffictypediagnostic: AM0PR04MB5809:
x-microsoft-antispam-prvs: <AM0PR04MB58096377A957181021D4CF4880A10@AM0PR04MB5809.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB5809; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB5809; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(136003)(39850400004)(346002)(376002)(189003)(13464003)(199004)(54906003)(110136005)(93886005)(316002)(26005)(6436002)(86362001)(6506007)(4001150100001)(71190400001)(2906002)(99286004)(97736004)(2501003)(71200400001)(6116002)(3846002)(14454004)(256004)(14444005)(66066001)(229853002)(74316002)(25786009)(7736002)(8936002)(76176011)(305945005)(9686003)(44832011)(5660300001)(6306002)(478600001)(55016002)(106356001)(53936002)(81166006)(186003)(4326008)(8676002)(81156014)(966005)(33656002)(68736007)(486006)(102836004)(105586002)(446003)(7696005)(11346002)(476003)(6246003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB5809;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IyQUnfY4StqKPYaN/bfVhozEqlUaYdwjNCBQvFwqSlDotmh6RT5N1gcJr4YX8YpXBfPwIVAQjh7ZXopBvdwNV+rtVh/69WdIqEOOKcnluBDM2L/3QY5ENUnxJ84UApllh++wf9x5UDq8C3UfAybk4Kz55A+Wj88otdM3utbFPzEBxrmQHpEr/aw0HMN6uzXN7xbM5zP5Pk/Kjf3hSqZO8XmGiVcmOvVtnG/zIKJxJ7eMQn4LZtaWdUGags0m8cY/TLzbQ9FqBPJs+T3HnVD5WitGSYh2XmbTacbx0UcA86zeHID4Ih3WszJiN8cyCE13
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4020fb54-10f8-4b99-33c0-08d6616bd26b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 02:28:23.8369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5809
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_182838_822773_08EA46CF 
X-CRM114-Status: GOOD (  19.02  )
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
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
[...]
> Quoting Aisheng Dong (2018-12-13 17:44:55)
> > > >
> > > > How would you suggest for this situation?
> > > >
> > >
> > > I suggest the defines just go into the clk driver. Is that a
> > > workable solution or does something not work?
> >
> > Are you suggesting me to doing it now?
> > As the patch is already in Shawn's tree, but I think I can do it and
> > clean up the file in Shawn's tree later.
> >
> > However, only moving the clk related defines into clk driver is not enough.
> > The driver compiling still depends on the resource ID file which is
> > shared by power domain driver and clk driver (and possible many others).
> > So we still have dependency issues.
> >
> 
> Do the resources need to be defined in one place either? Or can they be spread
> to all the drivers that use them?

I guess no. They're mostly shared among a variety of driver, power domain, clk and
other possible clients.
e.g. power domain use all of them to specify domain in device tree.
+		adma_lpuart0: serial@5a060000 {
+			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+			reg = <0x5a060000 0x1000>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&gic>;
+			clocks = <&adma_lpcg IMX8QXP_ADMA_LPCG_UART0_BAUD_CLK>;
+			clock-names = "ipg";
+			power-domains = <&pd IMX_SC_R_UART_0>;
+			status = "disabled";
+		};

https://patchwork.kernel.org/patch/10677311/

Regards
Dong Aisheng
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

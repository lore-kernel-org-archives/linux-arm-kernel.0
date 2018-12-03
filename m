Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219D1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:48:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F1020851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ogMWsTnH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i5z9VoEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F1020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FAW/8eScHmli9tkKHxLeDp9kubio+6ATrpnlYIGakOI=; b=ogMWsTnHZNt8yH
	V0dBQWYbG6xPZFkh1xzAeVMBq4GNO6IcvbkWJ/nxo3t5WocrvMpOFHlyxiQtrgps0Z51/1QcRZP9X
	92bJxplpt73b/Qs1SDA546I/GEaUfL9TbEiSKgb67LgcZGb7nCoF8/C/TpaT6jjG58cxTSPVTp4SD
	u3zJgCj0JMCO9i0kh+xO4J+vtdM05n5nNxMod8UIkdogDZAPSSW7qMd4u1S0gNzbWuM9qqCqwapz/
	n23gihv3C0oekqEVhVHdYBHCznKxVDd9RpLjkEbNFwb6gLnGw4gKvk++UneS9dIT9AD1+Rn5iEBy/
	xuHJdkfp76BOwAXy9+7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTjtp-0003oI-9c; Mon, 03 Dec 2018 08:48:17 +0000
Received: from mail-ve1eur01on060f.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::60f]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTjtc-0003eJ-9Q; Mon, 03 Dec 2018 08:48:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef+obMHy8lfjIairvvkzFPraABOKiDLuFibnxEmgQMY=;
 b=i5z9VoEmvoxrqzOVAtLGHijIQqxo+WsLYywSpB1y2unMfmFpW7Eos+15Khuv/oB8WGj5Y5qhNstwCnDQ7DMiK53h1aHo9gizKITgsZPOLrUJkfYtAJ7iJyDMWNugAUiSbmoZkg/ndrqxjlp50f8VEkFHUtyW2ogiuVGAI87bqa4=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5536.eurprd04.prod.outlook.com (20.178.122.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 08:47:48 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 08:47:48 +0000
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>, "broonie@kernel.org"
 <broonie@kernel.org>
Subject: RE: [PATCH v4 1/7] spi: add support for octo mode I/O data transfer
Thread-Topic: [PATCH v4 1/7] spi: add support for octo mode I/O data transfer
Thread-Index: AQHUgiJAcEpOMRHFo0C5hsFrjEN72KVsuW4AgAALwwA=
Date: Mon, 3 Dec 2018 08:47:48 +0000
Message-ID: <VI1PR04MB5726A8B992BF7DE2A646D20C99AE0@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1542863544-21257-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203090444.0c37efa7@bbrezillon>
In-Reply-To: <20181203090444.0c37efa7@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5536;
 6:1HZvw3gFltk3ksX4//qJ+msXsTq+2xcrCOW1vrKpxBmQp+XRCxQ3TO+7uoRiXzbfFMqMNC3IESfWPsBV8NOo58op92VQcHenLL+DEXfIufqo/vZQhADBolsAPh7AoH+mSVun6GfECf0D6JO8scrUyxw0eB5G9y71HVxNoK2wInNYSwivdeoicDsg9maJp7b7FvsHkzq5FUqu3cWtiVRvVveJkNekoMSalzyPKi0EpfOFdBIl/Uq2gerDxDMgjSlpZo7fXgZkjWbuUYRM+UfARrvH7k3cWYJAO9K+RCSjbditrctQTh7bNPc6civxSYnJGIM7JA1vj18Q1rD4Fi+ZPZL5kFGKVW/0nTaRRK+Ef9/FLS0e9rVJy4UGOVsxRAvrFWmLrHSnsXEAtbm2kkME0Yfyf4XdlGu5NBzTa1/FVHNelOArKjwD0XrdlGtkK0g4hY5F0dDT/aJXmjisHUj9Yg==;
 5:sU0OXZeUwj7Ghp/tAxWkkshp+esq8ZJn6+JOjCvgzPkdNUpYuotd0twAi3jpmab5BVY/5GhSLkmxeGNBJOrTzckcntz+plx0pVXx7f9FnbvYVAspX+/ctb45miNTPH6EZs5veEGMJQKOAz5GQb37txXkeoeCbW+KwXl7Gfs0lN8=;
 7:L4L8DMf12Q1/Z6QHPlYHo01+/eZNwhlWpCV3Ujkvt4Ov8dxHwaYGBcJ5xQ4DxGs88ro0QHnqTfMHUfa9ZFe3j6FcGmPff27J4hclI64RlcdOn5djC0Q6eiG00FTNxSaJiZjegthKJFuV9YdvCqc2KQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 38527abc-ebf8-44e1-5723-08d658fc00b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5536; 
x-ms-traffictypediagnostic: VI1PR04MB5536:
x-microsoft-antispam-prvs: <VI1PR04MB5536CE0D4C1660FD15E42F2299AE0@VI1PR04MB5536.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5536; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5536; 
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(13464003)(74316002)(6306002)(110136005)(186003)(5660300001)(54906003)(7736002)(66066001)(305945005)(105586002)(86362001)(55016002)(106356001)(2501003)(26005)(316002)(53936002)(8676002)(68736007)(99286004)(71200400001)(71190400001)(966005)(2906002)(39060400002)(478600001)(33656002)(97736004)(78486014)(7696005)(6436002)(8936002)(7416002)(81166006)(6116002)(3846002)(476003)(6506007)(14454004)(53546011)(256004)(446003)(11346002)(55236004)(486006)(4326008)(6246003)(25786009)(102836004)(76176011)(9686003)(229853002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5536;
 H:VI1PR04MB5726.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QSklY+OSeAbfa8Z/xTKwJC4JvFhrz9vN2W0ABMJrkCLsErc0/8pdGvA4A5NisdX69NFdL+TOaN3YB54zvJcGtFclsaypVlcRZGh7fS3VU6hjIQqguU5QHjDWZ1SC5mi2rwqOvxhynQtBUJVqJwInSm/qs1x7Oam80tOuOoMO5q7mWTHviGN2wm5m8PTCrzaI6TDGNvRhqsxmSjq4+nAc3J6q0SfKcgykCYTx1+3y+WSKyFmcqMk11zlCks0zAKBVKhrAY9tb/TmEl45Y+B00WvZpawn0tZt+JYe9JMvr8njSS5sLb+AXRIiktQ8Vw/f893D3Rmc6DPPPYBlOznrzn94FJsbEr0s43J65vjjX08s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38527abc-ebf8-44e1-5723-08d658fc00b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 08:47:48.5697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5536
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_004804_331624_19247439 
X-CRM114-Status: GOOD (  16.18  )
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
 "robh@kernel.org" <robh@kernel.org>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, December 3, 2018 1:35 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>;
> broonie@kernel.org
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; vigneshr@ti.com;
> linux-spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v4 1/7] spi: add support for octo mode I/O data transfer
> 
> Hi Yogesh,
> 
> On Thu, 22 Nov 2018 05:14:31 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
> > Add flags for Octo mode I/O data transfer Required for the SPI
> > controller which can do the data transfer (TX/RX) on 8 data lines e.g.
> > NXP FlexSPI controller.
> >  SPI_TX_OCTO: transmit with 8 wires
> >  SPI_RX_OCTO: receive with 8 wires
> >
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---
> > Changes for v4:
> > - Rebase on top of v4.20-rc2
> > Changes for v3:
> > - Modified string 'octal' with 'octo'.
> 
> When I listed the differences between your version and mine, I mentioned the
> OCTO vs OCTAL name, but I didn't say my decision was the correct one :-). Looks
> like OCTAL is the term employed almost everywhere, and it's also consistent
> with DUAL. Would you mind sending a new version reverting the name to OCTAL.
> 
Next version of patch series send [1]

--
Regards,
Yogesh Gaur
[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=79338

[...]

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

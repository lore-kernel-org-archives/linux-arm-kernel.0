Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE57C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:51:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9798B2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OLBKFNWk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2Yiy+3Xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9798B2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZsAwpyCsFOyFLjy9D45/l6t8NvtlDJMhg+bawVgqrP0=; b=OLBKFNWkrJ0tl7
	+H3FjqeQIk2p6kQiCJ/v1pUWFAZbT89NtcPRgiZVc8RsogiWVAnryM700A97hPCPkUl9mYZM+IW/I
	L0Kr59pbnaH3wD4Iwawhaq2N+9zuzQMYVdWxWXXklhBxRnS3Eiwn8NpqZGv+s3ssOacR8S5xte37K
	yTsaXaIwrUhIpLBO+fPYyBJ89c2f6CXZNaZ5aqfdSy1LLjJlo0N25ztUQydpgQpd1PECu2PKStsLV
	OwEhh352mHTd5gTgWhFsSkuOhPENGHKYOjdL345ggKyaUCkOQCtT4GhuBu163Cf8dMcN7XgceUZfv
	06vfkRXSYblAbY5TUdMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grRML-0001qo-7a; Wed, 06 Feb 2019 17:51:41 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grRMI-0001qQ-Hd
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 17:51:40 +0000
X-IronPort-AV: E=Sophos;i="5.58,340,1544511600"; d="scan'208";a="23505268"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 06 Feb 2019 10:51:37 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 6 Feb 2019 10:51:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORtZ2QwpM3ydmfvxoeItJ8YKuND1vprjzXNov0mgeQQ=;
 b=2Yiy+3XdPPNPEB/9Wwz1PoLR9iV7/fnc/GG8kH+M4X3NBo+VSi4Flvt4ksFRXmNobG64OJldTDZyPbMGPnEll4cvIGp221K5vhuN3ypp5d/ZqDMHhUZf4vgdiF4PE8oWt1p5OtLkaIcAAgXTxoJpbeNM2hEqn3sMuG13Ib9QnmA=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1709.namprd11.prod.outlook.com (10.169.234.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 17:51:33 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 17:51:33 +0000
From: <Nicolas.Ferre@microchip.com>
To: <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
 <sre@kernel.org>, <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH 0/8] ARM: at91/dt: update to existing drivers for the
 sam9x60 SoC
Thread-Topic: [PATCH 0/8] ARM: at91/dt: update to existing drivers for the
 sam9x60 SoC
Thread-Index: AQHUvkSYTxNCyb6XpkuKX39DVzeCBA==
Date: Wed, 6 Feb 2019 17:51:33 +0000
Message-ID: <0a24778f-9fc3-6edc-5d74-d152a95d5a98@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
In-Reply-To: <cover.1547629763.git.nicolas.ferre@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWXP265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::21) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1709;
 6:bJtjXy4+KEbG9mY888MWaB4Sq2SS3nlCRqHSrS6XNrCZnKwVZ0iEBKGT+ZbVYBZwNG19/2rDKpiNRx5UJm+rIYBK6L0vX27Q7D1tHCmu1XbSMYVoOllZcomxySjkq0TDjYlhiTvLt4mLlEOhd9IpbJk3SslMYwGAtQUEXwxmHMBsRvowf8Cy4rC/Qo2La+BPEZQqaFfrApE+PSQk1JBLF5+w4uCY5HCAQdo4BG4NtnDpgNl4qM1sq+M5PxM6SnGmhvAZZVbaacxjgzvgoRGFAczJe2vfR5ohSSysqBfYfmCELoUPIizrXm/I7J5ng8GPdivEsBDBLrz900MlTXcd99cvfFmgFvCRxZBr6RKB7e7jrv0fn30CMMYyBG4QllwWBQ20fDFJgu3RsZY9Dk4Q8zLDUDzDmXM3RySTjOzmIqdfOjJdrH4RvVVblOJjwMg094j8z5DARFjTM8Ov0pw4OQ==;
 5:18+lJhfPjKx4NclLBHyB3OiMTYDuxf6iCKK5COCxd/UqPPeUheuZzzueS7cp8OCGXKhRN4t/XI4dmSvexU+eVYHek4Yv2KI+zZ1DTX9c00P4JpZ9SruQLmSxoOsfywaOk3QY6lcfEYnNSfe49MyLiJkxcNGP+xb6fNYu2EZLS7SD5vyK+Kw0OOnXAEN5sLff4V3qNTs3nu/obx1jonzq6Q==;
 7:4B9/IpsKY/h936L2SxwRwgNZtOiZ177BpNyC5GBXnjKUVspZNIyzAi7KWfB0s78+uBVYWo6V9n21aQoR2300YYUEIWULGhuYf4k0o5WWTFiFZtr3zpIyhfrZgmSnTdGiQVAS9qGtbnBBS/pEootUIg==
x-ms-office365-filtering-correlation-id: c0a3bfd6-ff53-4638-42ba-08d68c5bbb40
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1709; 
x-ms-traffictypediagnostic: MWHPR11MB1709:
x-microsoft-antispam-prvs: <MWHPR11MB170977498F9E66924795B26AE06F0@MWHPR11MB1709.namprd11.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(366004)(376002)(396003)(39860400002)(199004)(189003)(25786009)(15650500001)(36756003)(7416002)(71200400001)(71190400001)(476003)(446003)(81166006)(81156014)(8676002)(68736007)(8936002)(11346002)(86362001)(99286004)(52116002)(105586002)(26005)(256004)(53546011)(2616005)(386003)(186003)(486006)(97736004)(2906002)(76176011)(305945005)(6436002)(6512007)(6116002)(3846002)(102836004)(6506007)(66066001)(4326008)(106356001)(72206003)(316002)(14454004)(6246003)(31686004)(229853002)(6486002)(7736002)(53936002)(54906003)(110136005)(478600001)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1709;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DMLWHF3UcozAHHmQxbaWzHnxLiq8VaLiVJvMXXA2yMY9/OyvvoDDrSgTn4zHYtpeQuviZhlbRP/5nhjul5nBWeV3/7/rNkzeN123AYaXjAHdgpnw5h+WGnIAwAH3ywtO4YeXoVtp3kV6LfJOuMufOOeuJGgnmZNhTFlEWZulLuyDNwUCVIZ9qHn2VwZAWeafBlLMm+tUXrRlRZPg9bsYalKOFg0CxWg+aXxsBNrKUgcsZu2SqRZANlCa9BPCxMPheDCP3+OnOa2rVR67KyXKfKmUq+8I7Ls/ZOTOkacUVQ4AJfJk6ab7lCVtwDORNS/Z25vlA+/K4sXD+xcTLvq7oNIeEGz1IhUNJ7tQENdvSxuTWE1jvCxzYfH1VTwx5ajL4JM8mE191wx6H0y/1CMo36ujlNE7npKR5YqvHwYeTQU=
Content-ID: <C96802A825E3BB469161DBD1AE2DE3B9@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a3bfd6-ff53-4638-42ba-08d68c5bbb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 17:51:30.0882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1709
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_095138_658289_AAF9854F 
X-CRM114-Status: GOOD (  16.44  )
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
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stern@rowland.harvard.edu, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

All,

On 16/01/2019 at 10:57, Nicolas Ferre wrote:
> Hi,
> 
> This series collects some little modifications to DT bindings and associated
> drivers changes for supporting the upcoming SAM9X60 SoC.
> 
> I took the advantage of this series for fixing some of the leftovers in DT
> bindings for reset controller and Ethernet macb.
> 
> These changes touch several sub-systems but I would like that these (mostly
> trivial) patches stay together for facilitating reviews, prevent breaking
> dependencies and facilitating the tracking of acceptance status. However, tell
> me if you think otherwise.

It seems it's not the preferred way to go and that I must split and send 
to sub-system Maintainers so that bindings and driver code go together 
through Maintainer's git trees (USB, power/reset, netdev).

> My intentions are that the series would enter Mainline through arm-soc tree:
> sounds okay to everyone? If okay, I'm ready to collect Ack tags...

I'm re-sending this split series. Some of the "Reviewed-by:" are missing 
so we'll have the chance to add them on individual series.

Thanks for your reviews so far.

Best regards,
   Nicolas


> For the first batch, I send the whole series to everyone. I'll try my best to
> reduce subsequent message deliveries if one part of the serries needs rework.
> 
> Best regards,
>    Nicolas
> 
> 
> Nicolas Ferre (8):
>    dt-bindings: arm: atmel: add missing samx7 to reset controller
>    dt-bindings: arm: atmel: add new sam9x60 reset controller binding
>    dt-bindings: arm: atmel: add new sam9x60 SFR binding
>    net/macb: bindings doc/trivial: fix documentation for sama5d3 10/100
>      interface
>    net/macb: bindings doc: add sam9x60 binding
>    power: reset: at91-reset: add support for sam9x60 SoC
>    USB: host: ohci-at91: add sam9x60-sfr definition for ohci
>    net: macb: add sam9x60-macb compatibility string
> 
>   .../devicetree/bindings/arm/atmel-sysregs.txt       |  4 +++-
>   Documentation/devicetree/bindings/net/macb.txt      |  4 ++--
>   drivers/net/ethernet/cadence/macb_main.c            |  1 +
>   drivers/power/reset/at91-reset.c                    | 13 +++++++++++++
>   drivers/usb/host/ohci-at91.c                        |  7 +++++--
>   5 files changed, 24 insertions(+), 5 deletions(-)
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

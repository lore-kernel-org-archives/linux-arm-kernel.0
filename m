Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010D8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:13:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10E5214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pv7tmj+z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QE9UpgGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10E5214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i6T5sc1bo2RIfcMGojxpOi3NsBt97wIjFTg1WtX7WwI=; b=pv7tmj+z+OYY0/
	3b/u3El9nIdmtbgj6CNfVraYQUsVhw++ryQ0vqrwsR9zAfWp4BSzw2E0e7FSkMH06k2cYQp0y7cjH
	CFWJB3hLE+UoluCu+4bnTCuvzwPAOMhvmpZa4ywtNZQ4RJ5hx8Bgke49i1/FS7uvxcWrMHyoVyXDJ
	Ws9yfjXlIssVcC8Ld8SQtYpIOgkci+4w2ThWj6zj2nT8riVIrDnbtkpVFOzfu4K+X0itv2NvUfj2w
	ixOe5ZA5sV5NU//YZ52vzNFc6KOYpZIr52/3pezMVSqbI3s8FrROqm+1p864oTYNx6Ei2LkQzw152
	Rnm8LrstEXKt2Fz2qTDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU5pH-0008CX-Hd; Tue, 04 Dec 2018 08:13:03 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU5pD-0008AN-Og
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 08:13:01 +0000
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; d="scan'208";a="23506625"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 04 Dec 2018 01:12:42 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 4 Dec 2018 01:12:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1hIZ5NYxxEl1AsLPNJqk4m9Tzh28WCDDZf77b855L8=;
 b=QE9UpgGu6EkAFuM7xDUJ6dr2UKHO10SOIs7cWg3euq9vKi1OU9UB+5L8hIgZFKrbibsp02awSllYHfl1qE3SKgsaE3LAfew9aFVE2dZSz+R4p/446616uVTng5pHBu5Udry+gKdFqtWGQ2220bOaFYXqcQeciKQZYzZUBFJDdx8=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1422.namprd11.prod.outlook.com (10.169.234.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 4 Dec 2018 08:12:39 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::f55a:dbdf:f578:ac79]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::f55a:dbdf:f578:ac79%4]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 08:12:39 +0000
From: <Nicolas.Ferre@microchip.com>
To: <robh@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 15/34] dt-bindings: arm: Convert Atmel board/soc
 bindings to json-schema
Thread-Topic: [PATCH v2 15/34] dt-bindings: arm: Convert Atmel board/soc
 bindings to json-schema
Thread-Index: AQHUi0/1D2Sqi4yAbkKsMWshl7aNb6VuO5YA
Date: Tue, 4 Dec 2018 08:12:39 +0000
Message-ID: <61c52081-7d6d-4de3-81a6-1cd074ac9adc@microchip.com>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-16-robh@kernel.org>
In-Reply-To: <20181203213223.16986-16-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::17) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR11MB1422;
 6:uKypX5uNqnVVpZnJJkPtyrlk1OSYqa83HzUiLK/B4GRrOmJOkqquJl/eTWFif9kheAkvKy+EzcL5dYLLq9GjlxL0EaleDxDIUAEJT/RVt2zh6FiUNhRhRHKe/janvOJWRmNnUZPoWHWfmcKdnsyw3EXCHlDHC0RGpzRS/ml6AJFqItyYLukHp/j9Cz9F2fL13Pi1tfQddgmMK5CFqrkVyE05Y+wpVLtDXCbh1QaA3iWvQKKZRKzdzNYHBQRaUUzpEkBLaEuE8tm5C57wvCqILWHqXPrvVXU+CTGEH9Nn76ZHGM6+HAEQ2x56zCNhe+ykgVjvJonFYWD3bMfJAEnXRbGBGOa2baqf8bMlODOrhOATQeZMtLzUM7vv33dZehq9orJ7mO9hGtkQa6zgGBxOP3ohaEcAWYKSryeG39Gp3hY9uEGgbVs7v4Ebuvj5HH0qR9naNvM4qKFB/Um6ekDvSg==;
 5:VjEXtMAgxddvUHPH5pzNBEQ3Md3l43WYgApgiWypjjBDf1NRhBop73X8rWp7tKRU/R+vH5B5o4XVBr/inrngiRP8YtswV/uf4VrXkpqwWibWeZ0sD2L+N4+cdNgsud58hZj60X3ZWfC2Zyn22uY6yiRTgny9fefNdDjrbCdfK7o=;
 7:uVqh/V0y6Hb6K3FueGSpDlxO4BhJWw/Y8cyZ4Ve2l3xKI2E2OdlCSzsyPErR2qYSQKeGkqRhFNvtd0PvyZK8DuaJWOuJNEWHIOdwYrzbd2HXvYON0fASOgqLSYiQD+DvPR4kozkTpGTCfr4xP2IM1g==
x-ms-office365-filtering-correlation-id: 40dc8bb7-e99c-46c0-1ed4-08d659c04205
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1422; 
x-ms-traffictypediagnostic: MWHPR11MB1422:
x-microsoft-antispam-prvs: <MWHPR11MB142223373D32D982769EDFF7E0AF0@MWHPR11MB1422.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(4982022)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:MWHPR11MB1422; BCL:0; PCL:0; RULEID:; SRVR:MWHPR11MB1422; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(53936002)(5660300001)(7416002)(6512007)(229853002)(6306002)(6436002)(316002)(68736007)(53376002)(14444005)(86362001)(2201001)(71200400001)(71190400001)(31686004)(6246003)(4326008)(31696002)(486006)(7736002)(76176011)(72206003)(966005)(53546011)(386003)(52116002)(6506007)(26005)(102836004)(11346002)(186003)(6116002)(3846002)(446003)(2616005)(476003)(14454004)(2501003)(105586002)(305945005)(66066001)(106356001)(478600001)(99286004)(81156014)(97736004)(110136005)(39060400002)(6486002)(256004)(8676002)(8936002)(25786009)(54906003)(2906002)(36756003)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1422;
 H:MWHPR11MB1662.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1NBTVkC5GbZuB1AfTBbT/vj4c70JjyZSCynW2fphnM7EuWdNS2UHe+S0qhKhhO87feUdNlhTbfQw8Nq5elTcVUshqbyMGYaA8ONdEKkNKOMVCdJp9CjXwXuzUeW4yoMMqyivJZFMjjDtBS+1lns0Z1WSVotHovrIKnrFVmmHfQbC1hvuvUTCt0FfxGXZYHyZBut4IsSrEhBXCwFgcRw09x2skftcjGoDA6RLOsmLI3U8uBD1txQzl31/DHYvbgW+BC63ZefsD9Mk5YFLa5VdWUdF7NRthnrwDKrYaQzqbpjX4fXF0RsRRMeXMbEnQ7I2uFfo6GxChnvFccY7zX0RLL46Y8oWHTRqWBAOsfnuJh0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <06A52C3C66949A4CB61A5B451EA0F0DE@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dc8bb7-e99c-46c0-1ed4-08d659c04205
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 08:12:39.7249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1422
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_001259_867637_AF3C19E3 
X-CRM114-Status: GOOD (  17.29  )
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
Cc: mark.rutland@arm.com, alexandre.belloni@bootlin.com, kumar.gala@linaro.org,
 arm@kernel.org, darknighte@darknighte.com, frowand.list@gmail.com,
 grant.likely@arm.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 03/12/2018 at 22:32, Rob Herring wrote:
> Convert Atmel SoC bindings to DT schema format using json-schema.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>

I'm listed here...

> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>

Proper email address here...


> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/arm/atmel-at91.txt    |  72 ----------
>   .../devicetree/bindings/arm/atmel-at91.yaml   | 133 ++++++++++++++++++
>   2 files changed, 133 insertions(+), 72 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> deleted file mode 100644
> index 4bf1b4da7659..000000000000
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
> +++ /dev/null
> @@ -1,72 +0,0 @@
> -Atmel AT91 device tree bindings.
> -================================

[..]

> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> new file mode 100644
> index 000000000000..19431f58b906
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/atmel-at91.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel AT91 device tree bindings.
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@free-electrons.com>
> +  - Ludovic Desroches <ludovic.desroches@atmel.com>

... and sorry but it's not correct just above ^^^
- wrong Ludovic's email address
- wrong Alexander's email address
- and I'm not part of the game anymore...

So actually our MAINTAINER's entry is up-to-date: please use it.


> +description: |
> +  Boards with a SoC of the Atmel AT91 or SMART family shall have the following
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: atmel,at91rm9200
> +      - items:
> +          - enum:
> +              - olimex,sam9-l9260
> +          - enum:
> +              - atmel,at91sam9260
> +              - atmel,at91sam9261
> +              - atmel,at91sam9263
> +              - atmel,at91sam9g20
> +              - atmel,at91sam9g45
> +              - atmel,at91sam9n12
> +              - atmel,at91sam9rl
> +              - atmel,at91sam9xe
> +          - const: atmel,at91sam9
> +
> +      - items:
> +          - enum:
> +              - atmel,at91sam9g15
> +              - atmel,at91sam9g25
> +              - atmel,at91sam9g35
> +              - atmel,at91sam9x25
> +              - atmel,at91sam9x35
> +          - const: atmel,at91sam9x5
> +          - const: atmel,at91sam9
> +
> +      - items:
> +          - const: atmel,sama5d27
> +          - const: atmel,sama5d2
> +          - const: atmel,sama5
> +
> +      - description: Nattis v2 board with Natte v2 power board
> +        items:
> +          - const: axentia,nattis-2
> +          - const: axentia,natte-2
> +          - const: axentia,linea
> +          - const: atmel,sama5d31
> +          - const: atmel,sama5d3
> +          - const: atmel,sama5
> +
> +      - description: TSE-850 v3 board
> +        items:
> +          - const: axentia,tse850v3
> +          - const: axentia,linea
> +          - const: atmel,sama5d31
> +          - const: atmel,sama5d3
> +          - const: atmel,sama5
> +
> +      - items:
> +          - const: axentia,linea
> +          - const: atmel,sama5d31
> +          - const: atmel,sama5d3
> +          - const: atmel,sama5
> +
> +      - items:
> +          - enum:
> +              - atmel,sama5d31
> +              - atmel,sama5d33
> +              - atmel,sama5d34
> +              - atmel,sama5d35
> +              - atmel,sama5d36
> +          - const: atmel,sama5d3
> +          - const: atmel,sama5
> +
> +      - items:
> +          - enum:
> +              - atmel,sama5d41
> +              - atmel,sama5d42
> +              - atmel,sama5d43
> +              - atmel,sama5d44
> +          - const: atmel,sama5d4
> +          - const: atmel,sama5
> +
> +      - items:
> +          - enum:
> +              - atmel,sams70j19
> +              - atmel,sams70j20
> +              - atmel,sams70j21
> +              - atmel,sams70n19
> +              - atmel,sams70n20
> +              - atmel,sams70n21
> +              - atmel,sams70q19
> +              - atmel,sams70q20
> +              - atmel,sams70q21
> +          - const: atmel,sams70
> +          - const: atmel,samv7
> +
> +      - items:
> +          - enum:
> +              - atmel,samv70j19
> +              - atmel,samv70j20
> +              - atmel,samv70n19
> +              - atmel,samv70n20
> +              - atmel,samv70q19
> +              - atmel,samv70q20
> +          - const: atmel,samv70
> +          - const: atmel,samv7
> +
> +      - items:
> +          - enum:
> +              - atmel,samv71j19
> +              - atmel,samv71j20
> +              - atmel,samv71j21
> +              - atmel,samv71n19
> +              - atmel,samv71n20
> +              - atmel,samv71n21
> +              - atmel,samv71q19
> +              - atmel,samv71q20
> +              - atmel,samv71q21
> +          - const: atmel,samv71
> +          - const: atmel,samv7
> +
> +...
> 


-- 
Nicolas Ferre
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

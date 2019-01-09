Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9E3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:48:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACAD020665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T6TVqqXu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="g7yvkVZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAD020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=issBZWZgYfx1cTqDhKy2fqjmF8vh6U9tfdUhoiANmuU=; b=T6TVqqXuiB8BNx
	bIQRxHDwj8b4hQ5FiTeqijfGZ0Hdc8kR1t01R3YnPGCNIuyawUWb26i5rkU/NCi9BWcEio5nRSFP3
	hQgh7aPN0hQGSX3GIbk5SItlpw7Albiy05gVho7/LPf3eijH6wTM5hAzZ0/Yu1D8OhQ8urrmXgu1f
	DqoXkvYSbNgLezCpTQqXlssb+Srsu98RZ24S4C13lGfA1WVgVCV56OsBxfhaE7NDpx50gWPh2DsP7
	71o4B7Oc68Vr8QCBPc1IihYRYiLReOiOF0KjlWNdMjIqRp7ahoT3j68t6CZT7xjgBlXjtss5poRfk
	azR68TVSnI+3idZGhZNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghCLE-0004Zg-VT; Wed, 09 Jan 2019 11:48:12 +0000
Received: from mail-eopbgr00131.outbound.protection.outlook.com
 ([40.107.0.131] helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghCLA-0004YO-GZ
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 11:48:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvTmQIDKeG0iztItlngj23+cFQU/t1FLqltoDPz1a+M=;
 b=g7yvkVZQImyl4tvZvEtZHqmk9SRseu3qVuDGszDAa4LrFOX8fjr05f2NS5J8gwRdtNbCaLLIMqvgOMJ2k8tZ1mns9IdmbUeY+23rK8WQ9o/UH4AHr5zyMnx9ZRFA/2OfodPlt/CIG1QUv0fOHR91pw/2sDMrfD3er2sU2ULFgNI=
Received: from DB6PR0501MB2583.eurprd05.prod.outlook.com (10.168.74.23) by
 DB6PR0501MB2501.eurprd05.prod.outlook.com (10.168.73.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 9 Jan 2019 11:47:58 +0000
Received: from DB6PR0501MB2583.eurprd05.prod.outlook.com
 ([fe80::c8ef:ad62:4125:3aba]) by DB6PR0501MB2583.eurprd05.prod.outlook.com
 ([fe80::c8ef:ad62:4125:3aba%6]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 11:47:58 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "stefan@agner.ch" <stefan@agner.ch>, "dev@pschenker.ch"
 <dev@pschenker.ch>, "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH v5 7/8] ARM: dts: Add stmpe-adc DT node to Toradex iMX6
 modules
Thread-Topic: [PATCH v5 7/8] ARM: dts: Add stmpe-adc DT node to Toradex iMX6
 modules
Thread-Index: AQHUmTOk7bttGkc2KE+gD5CniwRdcqWm7+sA
Date: Wed, 9 Jan 2019 11:47:58 +0000
Message-ID: <80de6dff82363982d1e6ab6d99e9304986466d7d.camel@toradex.com>
References: <20181221134638.20600-1-dev@pschenker.ch>
 <20181221134638.20600-8-dev@pschenker.ch>
In-Reply-To: <20181221134638.20600-8-dev@pschenker.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [212.41.222.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR0501MB2501;
 6:eGlP98hBscMuD5TC9J1NSHMrgugZyWxJTuxzVQyLcZ4r0QjFxAbiRgrRNrgTWTtDQmPii06A7v/Yho0CPT+xb6tNgDupdjeFApYtfDIhyeQDGGvPcnhYkx6gIfYYIuZX+/D9mQlryqS4g9HY6vANZSHIaHFqKgTrILooCmd3lx0W2TmiIILAKtG2b/wkvde1FxI+5jQ4sWwUaSgPXNvbRUOMxNxi9HRt+G7JcblA4iaChZ8dABulJDXjTW8BgZKGqsje+HkldWKSOtgDaIjW59/SrESKY1RpAGEWP9iLlNv3OtxSIbWEADvwVNC2OHp4ISfsrxZiZJRFNK2frwIMEvjzAWnXbze8PUZL8c0WuPGAt4IQga5DJ/udZOKVNCJK2e4FOubH1wKd785DfOiE+o3UyfaajVkOuWj86xktRBxtLaygVYIAVSo1AnnucvV8agvTq8RFO+LFGOMW+h3DwQ==;
 5:pJoKR6aTmwled9o46G0xS8vhuoWm4K+/RBrror8yjB/wUbcUTyhgetnEF1YONTsF8YFfOWit1go0pGd3MEEoH9xAcOzK6FnT83eAnfnLJa/eLfPItP0FwJPTqauUM0N/xRI2egcvN7br+K6vN4/aIRlzHDILoN+t5Jep3AdyVJaQAh6uPrChWbPA/jbilA2dRhtJP0K0y+/zo0/lr3bg8g==;
 7:lpGFXpL0Xqcux3Q7DoRNm+tc9IJnc8qUMxhiaEcn2YbbLN7ThvGJAvdzL0jGuIE0F3IdOVjiGnxJ+Lelf+LeldQFk8ckSYxrxkxqlaUCnV5SpqwLoD2wPIWWbYbbZjExYB2ZUdlXwHcjkxjGBhHnxg==
x-ms-office365-filtering-correlation-id: 83b195c9-72fa-43f1-5b51-08d676284cf0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR0501MB2501; 
x-ms-traffictypediagnostic: DB6PR0501MB2501:
x-microsoft-antispam-prvs: <DB6PR0501MB2501019A71E842012DE6EFB5FB8B0@DB6PR0501MB2501.eurprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:DB6PR0501MB2501; BCL:0; PCL:0; RULEID:; SRVR:DB6PR0501MB2501; 
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(376002)(39840400004)(366004)(346002)(189003)(199004)(6512007)(6506007)(14444005)(256004)(186003)(229853002)(26005)(105586002)(102836004)(486006)(7736002)(6246003)(2201001)(4326008)(305945005)(39060400002)(36756003)(53936002)(14454004)(25786009)(66066001)(478600001)(3846002)(76176011)(6116002)(44832011)(68736007)(106356001)(2906002)(5660300001)(2501003)(7416002)(6486002)(446003)(97736004)(11346002)(4001150100001)(2616005)(8936002)(476003)(86362001)(575784001)(316002)(54906003)(110136005)(81166006)(71200400001)(8676002)(81156014)(71190400001)(118296001)(99286004)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR0501MB2501;
 H:DB6PR0501MB2583.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +PxvIxbv+bhlIqP2YL4nlvsNMi9Kp+Ku/xEFuvwKExJbn0j4qAa/M2IMqO5acm1qut7j0AtyEG1goaqPlGGEHlplt1qMDIO0GQFLjb8TMnwuCy6tf1J0ArejTVCb2Ka/pHBzAcHdhzuHilP95VAwSZtGRwe/GFVJcGqOGvQ2vjhc2r57fzJKIauKEu9R8g+In8M/hV7egYL3y6InjOjkd+KZNs6rw6cIGyriMxR2Q7BEdybZZR4rCvypI+65K9OEc2ZPqkasD4QRTzPndkP0x/EIVeEBUfzcDJOMzCgPacJBhwMtxLVWYkGh5RaVvwtp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <2E166BF52D44B44EAA4D7FA738A39986@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b195c9-72fa-43f1-5b51-08d676284cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 11:47:58.0333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2501
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_034808_552890_280A54BA 
X-CRM114-Status: GOOD (  16.27  )
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
 "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "digetx@gmail.com" <digetx@gmail.com>,
 "lee.jones@linaro.org" <lee.jones@linaro.org>,
 "coquelin.stm32@gmail.com" <coquelin.stm32@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2018-12-21 at 14:46 +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Add the stmpe-adc DT node as found on Toradex iMX6 modules
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

> ---
> 
> Changes in v5: None
> Changes in v4:
>  - Moved T30 devicetree settings to separate commit
> 
> Changes in v3:
>  - None
> 
> Changes in v2:
>  - Put common ADC settings in mfd
> 
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 22 ++++++++++++++--------
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi | 23 +++++++++++++++--------
>  2 files changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 3dc99dd8dde1..8db476d8978d 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -331,11 +331,18 @@
>  		id = <0>;
>  		blocks = <0x5>;
>  		irq-trigger = <0x1>;
> +		/* 3.25 MHz ADC clock speed */
> +		st,adc-freq = <1>;
> +		/* 12-bit ADC */
> +		st,mod-12b = <1>;
> +		/* internal ADC reference */
> +		st,ref-sel = <0>;
> +		/* ADC converstion time: 80 clocks */
> +		st,sample-time = <4>;
> +		/* forbid to use ADC channels 3-0 (touch) */
>  
>  		stmpe_touchscreen {
>  			compatible = "st,stmpe-ts";
> -			/* 3.25 MHz ADC clock speed */
> -			st,adc-freq = <1>;
>  			/* 8 sample average control */
>  			st,ave-ctrl = <3>;
>  			/* 7 length fractional part in z */
> @@ -345,17 +352,16 @@
>  			 * current limit value
>  			 */
>  			st,i-drive = <1>;
> -			/* 12-bit ADC */
> -			st,mod-12b = <1>;
> -			/* internal ADC reference */
> -			st,ref-sel = <0>;
> -			/* ADC converstion time: 80 clocks */
> -			st,sample-time = <4>;
>  			/* 1 ms panel driver settling time */
>  			st,settling = <3>;
>  			/* 5 ms touch detect interrupt delay */
>  			st,touch-det-delay = <5>;
>  		};
> +
> +		stmpe_adc {
> +			compatible = "st,stmpe-adc";
> +			st,norequest-mask = <0x0F>;
> +		};
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index 87e15e7cb32b..2e303d79c7f8 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -262,11 +262,18 @@
>  		id = <0>;
>  		blocks = <0x5>;
>  		irq-trigger = <0x1>;
> +		/* 3.25 MHz ADC clock speed */
> +		st,adc-freq = <1>;
> +		/* 12-bit ADC */
> +		st,mod-12b = <1>;
> +		/* internal ADC reference */
> +		st,ref-sel = <0>;
> +		/* ADC converstion time: 80 clocks */
> +		st,sample-time = <4>;
> +		/* forbid to use ADC channels 3-0 (touch) */
>  
>  		stmpe_touchscreen {
>  			compatible = "st,stmpe-ts";
> -			/* 3.25 MHz ADC clock speed */
> -			st,adc-freq = <1>;
>  			/* 8 sample average control */
>  			st,ave-ctrl = <3>;
>  			/* 7 length fractional part in z */
> @@ -276,17 +283,17 @@
>  			 * current limit value
>  			 */
>  			st,i-drive = <1>;
> -			/* 12-bit ADC */
> -			st,mod-12b = <1>;
> -			/* internal ADC reference */
> -			st,ref-sel = <0>;
> -			/* ADC converstion time: 80 clocks */
> -			st,sample-time = <4>;
>  			/* 1 ms panel driver settling time */
>  			st,settling = <3>;
>  			/* 5 ms touch detect interrupt delay */
>  			st,touch-det-delay = <5>;
>  		};
> +
> +		stmpe_adc {
> +			compatible = "st,stmpe-adc";
> +			/* 3.25 MHz ADC clock speed */
> +			st,norequest-mask = <0x0F>;
> +		};
>  	};
>  };
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

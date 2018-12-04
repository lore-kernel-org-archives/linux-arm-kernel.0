Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A32C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:59:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E0F52082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TdNEU9GS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="UOjoAssc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0F52082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aLGckOXcBElEEnIN4i0NfTC2xmJOaM1xgwGSBaS/GIo=; b=TdNEU9GSXP9Oyv
	d2Y+TmMwQkuRZjAJwHkbPoUouV9+WAgYaTDSRPI+Q0V+IacmBPBEJo550WiQM0vKw15aXpOX3pu1L
	LVvBDtNXFU/MKjLZo1dxVSLWW2hULFE8h9SPgFRmZckmr+rBaXyQ5py3kLnh5cGvFu/TrU1WS5voL
	v7uwDGRaQMLCRmIJeoN6CiZ+5i+LhkUI60uBZ93jli0PkdpIvZo+bHpyfyaIm18mDl8MDdVodGix/
	rcp/ogEXfQd4eRFREW4Zgz3UCy9PFAoOpkKF6QRBWONdtp/DIflCcie/g+f21g+sHkZG0+afG6Ns4
	J6dHcSv7SKhZpQji5S5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7Tm-00032i-GA; Tue, 04 Dec 2018 09:58:58 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7TI-0002VI-Jk
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:58:56 +0000
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; d="scan'208";a="21089929"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 04 Dec 2018 02:58:13 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 4 Dec 2018 02:58:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYQoP+NOIrC5TfEOIu6KkjGlkScZMkMMoVxb26diza0=;
 b=UOjoAsscu18tWH9IFB1A5Sdbkqf5P4qJyNhdGJznDbidHu/LferCI7pg6xAUBLKSMATey/dXqjQu5D752VDt1KRiVC2lUaZyHlEXUsW7ejVWnOdXf+dlnlP1OWgVy7i1Oy8ddl2BHRWBzmqyoO2kDiMjO2YO6AWNkYV4eNIz8hQ=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2306.namprd11.prod.outlook.com (10.174.113.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 4 Dec 2018 09:58:10 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 09:58:10 +0000
From: <Andrei.Stefanescu@microchip.com>
To: <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: gpio: add SAMA5D2 PIOBU support
Thread-Topic: [PATCH v2 1/2] dt-bindings: gpio: add SAMA5D2 PIOBU support
Thread-Index: AQHUgKg8JYSs1TI8IUy9lTCXxs8No6VubluA
Date: Tue, 4 Dec 2018 09:58:10 +0000
Message-ID: <b581a73c-2f72-5915-5fc8-3cf9f5518a9c@microchip.com>
References: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
 <1542701330-23466-2-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1542701330-23466-2-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0501CA0004.eurprd05.prod.outlook.com
 (2603:10a6:800:92::14) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR1101MB2306;
 6://xwXQcocoxBDZ7xtGYN8hwtgdm/NV9L6f4HeuIKA7z+1GH1X8hP1NSnZb0iPOae5DHDUcM810UGO/WtBMDjd2C1q+TsWVvkXwkNO8P/4AVxkacqCD4lLkcrZJoxFPAUjgViOEvLRE4zzmgj7kW/tBjxW6EQ/X/5JMOJOvS5t7wBQRypTjhaW5oW4vA04KqzXgaNndiuTre6NeKCkJgTvf8KxPQpCTeBKuMmAqrTApSstqo37t29Ngbavnpu6DYF5PbTGQNhA4pj5NhcqME55wfrA4YeCgzc3ptK/sbF+34y/9vJn9BxAsMSeetar34DC4476lY9coAUQZ1mSjFmyzXFptVfbnsQl7d1h0kSEcfKpOUepskoFO1lMJZ+B+ntoBk3DZEGtTSxKFKr27cVUWUizvM9xvyW0ROfavoJxM9K7GJB9zofBBedGjBlmo+XHJhFf46ZPWn8avtX3xkTgQ==;
 5:ziseNfMeFsYVqif/RzQWDbKtWSrQP/19hnm3BggO31qN3r2w+/5mIaHNZYX58c9966v4r9VS2r9DZSPrTCXzVoNGheTEU2fURBuz67rC8B15GlrJWwAB0wzZHlIJ+IPckrnW6HgkIb176HT/tRcCcsIEPAwd04B0073Bf7gnFPc=;
 7:KbxzEOSnCOxmkHXLC1CPkhZQkc/+9EUqOchGLt2lRSqCl/62H4Q3sgeX8YMPOcj3z+F6LVTaOR5zdWG3TJhLYwkeWFqzJdd6MyMKWb9B4+cNK4hvFay5egoARbHkvZsK7W9Masz0Q0uTiMCYYC7LRw==
x-ms-office365-filtering-correlation-id: 223ff9d9-0a01-4146-2b8f-08d659ceff4a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR1101MB2306; 
x-ms-traffictypediagnostic: BN6PR1101MB2306:
x-microsoft-antispam-prvs: <BN6PR1101MB23064481A9A6643E3686487EEDAF0@BN6PR1101MB2306.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR1101MB2306; BCL:0; PCL:0; RULEID:; SRVR:BN6PR1101MB2306; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(37524003)(199004)(189003)(97736004)(52116002)(14454004)(6116002)(54906003)(3846002)(256004)(478600001)(68736007)(53546011)(6506007)(386003)(99286004)(26005)(76176011)(2906002)(186003)(316002)(53936002)(102836004)(6512007)(5660300001)(66066001)(6436002)(71190400001)(31686004)(106356001)(105586002)(6246003)(7736002)(4326008)(229853002)(6486002)(25786009)(305945005)(476003)(2616005)(72206003)(86362001)(36756003)(71200400001)(8936002)(8676002)(31696002)(446003)(486006)(11346002)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1101MB2306;
 H:BN6PR1101MB2243.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QEn7UWn2gNQ5FW7ch7cZlZ2NS2wuyT9fRHGx8WxzXFKEp/2w/3O/1dZjdbIC7VI6AeLBHmNUstjPGYpzQu5D5A0cyGgI87HLVybsMjoSje6MMV2SvYKdtQbu9DQ5deDZflEvvVi/uI3DrE7imDGupUVYsJvh36DinMVmlkpWFiuz3TdKQIrSh+aTrATu7TEkIFtwEUAHFIRVCVykmh2GE3avbLyBaRjUXAig5UClkzfkrH7kNpGe9YFcxmTn1RvRJK02ZwtD4LIncEVbfAVv5VYbrGqiuV1ocqj5UdG/oY+wGG0EVaeeWz28m1n1vP4gZ7jjBamxa52QKYiRpcXgZzESZFnTokjtbh0S6R9i+PA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <EF3978FE7B95694CA14EBFFA432BB883@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 223ff9d9-0a01-4146-2b8f-08d659ceff4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 09:58:10.3792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2306
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_015829_202388_5253AA5A 
X-CRM114-Status: GOOD (  19.28  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Ludovic.Desroches@microchip.com, linux-arm-kernel@lists.infradead.org,
 Cristian.Birsan@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Rob,

Could you please tell me if there are any improvements
to be made to the patch?

Best regards,
Andrei

On 20.11.2018 10:08, Andrei Stefanescu - M50506 wrote:
> This patch describes the compatible and the device tree
> bindings necessary for the SAMA5D2 PIOBU GPIO.
>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
> ---
>   .../bindings/gpio/gpio-sama5d2-piobu.txt           | 31 ++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt b/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
> new file mode 100644
> index 0000000..2e260e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
> @@ -0,0 +1,31 @@
> +GPIO controller for SAMA5D2 PIOBU pins.
> +
> +These pins have the property of not losing their voltage
> +during Backup/Self-refresh mode.
> +
> +These bindings should be set to a node in the dtsi file.
> +
> +Required properties:
> +- compatible:		"syscon", "microchip,sama5d2-piobu"
> +- #gpio-cells:		There are 2. The pin number is the
> +			first, the second represents additional
> +			parameters such as GPIO_ACTIVE_HIGH/LOW.
> +- gpio-controller:	Marks the port as GPIO controller.
> +
> +Note that the driver uses syscon and should be the child of
> +the syscon node.
> +
> +Example:
> +
> +	secumod@fc040000 {
> +		compatible = "atmel,sama5d2-secumod", "syscon", "simple-mfd";
> +		status = "okay";
> +		reg = <0xfc040000 0x100>;
> +
> +		pioBU: piobu {
> +			status = "okay";
> +			compatible = "microchip,sama5d2-piobu";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +	};
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

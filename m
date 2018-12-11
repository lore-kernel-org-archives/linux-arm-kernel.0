Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D66C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:33:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962A92081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gZWWI4pi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qoEqno7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962A92081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ta5L6maWPpucuPNFwIbXMxofJnwe2IyUhiXqvY7fh3c=; b=gZWWI4piD80bpU
	MmZXGNpQyfi2j9zGfVsxy08tpNwBftcu1sf371HoOiOd7M7buIKEk0q1HUpVfy/uAQ0WjnNJQrpfL
	l02Ac+tEnN3gcpcP4wCDcfhRodpQzTMJnT0URHLFz1n1uM6r2iuMiJzXBnFFJ0qpwX1B08PkrAu0J
	YPVKkkHrniqaTXp9tShTyhHb5jk6V5aGQdTX35Ki/JhHSoIviqBsuKxyQEtuRLmYTlytBRU1wnOxN
	ZM5Prz0i796kPHM7rRsRrFej+e31IdLJ7d9rk7jsh31DNrnJiHMBs19J36HFRlgfL1NYgAHLDYMoW
	gfEcze96ks91Udgfbplg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWhDm-0003EV-9a; Tue, 11 Dec 2018 12:33:06 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWhDi-0003DJ-0B; Tue, 11 Dec 2018 12:33:04 +0000
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; d="scan'208";a="24232166"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 11 Dec 2018 05:32:44 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 11 Dec 2018 05:32:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBCzqyuLKy6zjnGaXCt2XCD/j7AEagAQhXorNxnF+l8=;
 b=qoEqno7pREOQXDf57IdoFLHhj3YHWkUgDOjNl7CvdOgitOilWawkA1Ma0I67vPsTJiIt4VRu6h53KJbLvV/Fu+aFYDvfzWVyTJ3ATyp8XHxAnJVQHhA3ov6Kn2A72pPZww2wSaYiDwlZS+hdxOjqk+my2xEYQpljvWWe7h7gM6k=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1970.namprd11.prod.outlook.com (10.175.100.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 12:32:41 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 12:32:41 +0000
From: <Tudor.Ambarus@microchip.com>
To: <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Thread-Topic: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Thread-Index: AQHUkKvzXXGQaMBmgEiVjL0m4mUE46V4f0+AgAD6hoA=
Date: Tue, 11 Dec 2018 12:32:40 +0000
Message-ID: <22730de3-55f0-df21-312a-560a02f02dc7@microchip.com>
References: <20181210171511.21002-1-tudor.ambarus@microchip.com>
 <20181210213553.GK8952@piout.net>
In-Reply-To: <20181210213553.GK8952@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0099.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::25) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.240.19]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1970;
 6:2s+iQ3KBRgTi2QnSueCY5xDmGFI8mSm7tQLq0QY4gwMSAgYMp9DOZptJrGPZXRRY0XnB+KSHdqaOKRXA9CcFFTe+f60UoGw5XPyQFGbA1757/Jk7bH4SCSIHmfAeHZHKBWGkt/xFReQOvH8wsrLvq8phj62cjic9qWuHRMl32jx9oE9yZsKKdkOsD1Mr+5NDAkS/i/cTarEkUMEegJkbvJSEZUzXp1EkO72qO3wstix36gC7BARwzSiCI8dEmR7RmoM4DnEjCz/QwQDxwnFPb39riVbyHmb4ml6Vyu2Fu1UZHw9tQW9+k80XT1FcZc7IzCgufV6CfAErLW2LXseTImD6XKSW2rNP8/gUENW01NBj2q6NfxTjz02PHERZ3aULlPSvlA698ex9MX7eWoxceq+3bRAn5JJpR9bXpFfQmzrtfhzUECW7QSzx5PqVci33lZeeZYABkqWde2+XDqlznQ==;
 5:vv48AWDGtEVt1ZedShQajiZpPRsmcFSMOGqYpo0sxIGSCDW84rcFhrh6jtBHePWfsGAMRvTPYUk2ZL0BfO3t7rs+/obEHWgCqpY1SuUwGFVcPzqZ8WMAtJjYVrawWs1oBuEtMdMipHuv6sKRx4KyzZmetB2dl/wgQ08/LVxU4BI=;
 7:rmKxgbWMyniBFBkTQIX8lvD5bndYL+gnIqCMmZ8FvsQJ9VEUkNkiU9MepnHznOeGrFuFQOVioMMIm56O9T2sSzwb8yJQzamXDQz+3SGDmgimG1EtK8OrzIYDKtRKAP545o+TrOSVrXcqMkqrECKYSA==
x-ms-office365-filtering-correlation-id: deb2d04d-ae0a-424a-3706-08d65f64bdce
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1970; 
x-ms-traffictypediagnostic: BN6PR11MB1970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-microsoft-antispam-prvs: <BN6PR11MB1970ADB4E694A05071DDEB43F0A60@BN6PR11MB1970.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231472)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR11MB1970; BCL:0; PCL:0; RULEID:; SRVR:BN6PR11MB1970; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(31686004)(229853002)(106356001)(7416002)(386003)(6506007)(71190400001)(72206003)(71200400001)(99286004)(68736007)(3846002)(8936002)(6116002)(6246003)(446003)(52116002)(97736004)(6486002)(25786009)(11346002)(6916009)(478600001)(2616005)(186003)(53546011)(6436002)(256004)(14444005)(102836004)(486006)(476003)(76176011)(217873002)(86362001)(5660300001)(26005)(66066001)(81156014)(36756003)(8676002)(6512007)(2906002)(54906003)(81166006)(14454004)(7736002)(4326008)(305945005)(105586002)(53936002)(316002)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1970;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: leNb24rlb82FmNPlgFEALcCPYaId0V+J8Pj/pSEq4GSivEKUt7dmxZH+Ok1NAwtrL6Ymt8sa8pfnzXFilF7HrKm17Ea/DhIKYZTIoq7cVy4yT9DuHGl+ZvvPdJuePC6SeDYqjB10+lKJe2zLbNCtdkHzIXIXzUpEbMrbhJg3QPIPQPJ/I/UfOKhSOxENAkUXv+9rTRNW3LRz4dYeNlimNIE7tWBgYJ252ZSxiP3gto0x8JABNO/1tUqBDMiRfnvt9nn27VfG21qU+Z6e03+xkQ6X6J6kW2FpkVduQ/Da3QHPls1eho37gbVXrZe1egG/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <FDD38498AEBB3547A3FAB81144C33D0F@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: deb2d04d-ae0a-424a-3706-08d65f64bdce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 12:32:40.7972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1970
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_043302_157391_700D6177 
X-CRM114-Status: GOOD (  13.63  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, broonie@kernel.org,
 Cyrille.Pitchen@microchip.com, linux-kernel@vger.kernel.org,
 boris.brezillon@bootlin.com, Ludovic.Desroches@microchip.com,
 robh+dt@kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Alexandre,

On 12/10/2018 11:35 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 10/12/2018 17:15:29+0000, Tudor.Ambarus@microchip.com wrote:
>> From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
>>
>> This patch configures the QSPI0 controller pin muxing and declares
>> a jedec,spi-nor memory.
>>
>> sama5d2 Xplained RevB and RevC use the Macronix MX25L25673G flash
>> memory which advertises a maximum frequency of 80MHz for Quad IO
>> Fast Read. Set the spi-max-frequency to 80MHz knowing that actually
>> the QSPI drver will set the SPI bus clock to 166MHz / 3 = 55.3MHz.
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
>> [tudor.ambarus@microchip.com:
>> - drop partitions,
>> - add spi-rx/tx-bus-width
>> - change spi-max-frequency to match the 80MHz limit advertised by
>>   MX25L25673G for Quad IO Fast Read,
>> - reword commit message and subject.]
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 31 +++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> index 518e2b095ccf..171bc82cfbbf 100644
>> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> @@ -108,6 +108,21 @@
>>  		};
>>  
>>  		apb {
>> +			qspi0: spi@f0020000 {
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&pinctrl_qspi0_default>;
>> +				/* status = "okay"; */ /* conflict with sdmmc1 */
> 
> Isn't that conflicting then because I think the default is okay.
qspi0 is disabled in sama5d2.dtsi.

Thanks,
ta
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

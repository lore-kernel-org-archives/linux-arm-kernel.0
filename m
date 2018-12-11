Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE427C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:50:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71792084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EhIeW4X5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="P3kpqB0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71792084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rAv9kHklIVxxBm3fQb1xUZTZUpnFIrQ46o6Lnp8f/Aw=; b=EhIeW4X5//inhO
	YhGEqs4Ineh2wUnuwjnbPsWo+KYejhE1LKbenlqPoK1EtA73W5vypMcfjNXDUEdO7kVjCkbbvXaFQ
	XPYsL1Hdyug0MqqVE3QgZY/mZXosFXFGwRCEIukoW41d4w8LHoqyTnXCXvVy0PdCCmzfdIUlmth9Y
	kr1yGm7y5uPjS/v1uBrajAPkRZ16truwWu7MNd+PJ0ob9HuXKkFpvdMuXVvXLBA5qZRY/fnw2gQp7
	zbUYIHvUwrNGpopQBR9Do4lEhhw5+8sfIU/6G4kNG7kBlUmSrNkVl/Yh0OUQ8TT25KZ+BtbTWx3bp
	ATfoof0jiXM6Vqms1zKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWjMP-0005p0-GN; Tue, 11 Dec 2018 14:50:09 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWjMG-0005EY-3g; Tue, 11 Dec 2018 14:50:06 +0000
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; d="scan'208";a="24236732"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 11 Dec 2018 07:49:47 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Tue, 11 Dec 2018 07:49:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNKu8IAA+qKn5ERU3lyO8d+jgFQpq/KVmfE9jMqNrQ0=;
 b=P3kpqB0F1Ixkv1HsGHufNWnzIZ4Xso6I3HcwpC5QhVX5cCMrwFIZ7SY7mPF2qe/TEVT5cDq40mYS4bDThr27Ve4XRLFn233/aOmiIX11yelGgmhmhnRJ1k8IERE1a7oqokFrSRfH2PlHk+SSTTcGPs+iYx2woovn7+6gIT7MyVU=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1363.namprd11.prod.outlook.com (10.173.33.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.24; Tue, 11 Dec 2018 14:49:44 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 14:49:44 +0000
From: <Tudor.Ambarus@microchip.com>
To: <boris.brezillon@bootlin.com>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Thread-Topic: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Thread-Index: AQHUkKvzXXGQaMBmgEiVjL0m4mUE46V5nZmAgAACiIA=
Date: Tue, 11 Dec 2018 14:49:44 +0000
Message-ID: <6e2aa831-dc12-8431-d089-10f35cec4cd6@microchip.com>
References: <20181210171511.21002-1-tudor.ambarus@microchip.com>
 <20181211154033.076506aa@bbrezillon>
In-Reply-To: <20181211154033.076506aa@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR03CA0065.eurprd03.prod.outlook.com
 (2603:10a6:803:50::36) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.240.19]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1363;
 6:mD7pnay1GdXrdJ09aQJEpFBRCEfkGzNdlLzX6t4cYzkN/Osc7BX6a/rAARmt6eKkpzR8BGq3jZ8h+W/Cm/g/Hk3OP7EUJ+v6Voe91w1vrEHz44G6+yd9W9R+WjzchiF82h2Cffps4JL5o+HFC9xZ7DSuDpYSARPTt107ncKOR6U4lqrOfnNUNqTfbI/OQF2BFQO+VFWaIo49tTXjHuRXoFbSHWSiS+X4WNbmx/nf1UvXtraAy89rAXPq8kwN8rgA6aXEOrUqWMB7C1hMG4vZfK6N30J5eYBH4LYBiM8E4p0qdF2AR5RqUYjkGjykEopA/gA26eVAq6z4epetD+rgjOGPyS/FyJ/CWH2E/4HJxV2A1Ht1f29MxqOBU83GVeM4rKvzU/e2X+1alxiCabYxIeFoFwrqZQRWK8Xh1gL17nIGtrS/4GnsgBNxmdzxg/MB7xLHS19wyQ6l4Ih6YECovw==;
 5:LcBqHL8lz2Fcznzk8LsZ2s92aa+1PkMBBAagOUC118971sTHRdNIMpDzUzsZKfEcnPJK3TqdXPh2zXf5Q0fiEAAPwcGkHz6grmf1k2c1Rg7H5Nx5EF0lL+e7lu9Ni6iJ5Xpl8nBJ4T4UkeiP1q5dPt6yWt9ziAJbn2NRt6sQfxc=;
 7:OL3QBwaSgBbChusIcFneOOFY7QO8dmBLp7LCG2CKdBYGqHn8rCNDNW47EBMqIBheJMHTpsJmgzsWhAHJReEMwWIKjBVmiCNFzrJE9wQFCLDvImk66++h1fsAfEFCcOaTOXL6pq/cUlaJ77M3paC6uw==
x-ms-office365-filtering-correlation-id: 86c0f57b-36c2-427c-7080-08d65f77e37a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1363; 
x-ms-traffictypediagnostic: BN6PR11MB1363:
x-microsoft-antispam-prvs: <BN6PR11MB136376FA5B0DF859EE126FA3F0A60@BN6PR11MB1363.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231472)(944501520)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR11MB1363; BCL:0; PCL:0; RULEID:; SRVR:BN6PR11MB1363; 
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(8676002)(6512007)(86362001)(36756003)(6486002)(53936002)(5660300001)(31696002)(14444005)(256004)(478600001)(316002)(72206003)(8936002)(6916009)(106356001)(4326008)(229853002)(25786009)(31686004)(2906002)(486006)(81156014)(2616005)(81166006)(476003)(97736004)(105586002)(446003)(76176011)(11346002)(14454004)(6246003)(186003)(52116002)(54906003)(66066001)(71190400001)(26005)(7416002)(386003)(102836004)(53546011)(71200400001)(6506007)(217873002)(7736002)(6116002)(6436002)(99286004)(305945005)(3846002)(68736007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1363;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lZTt+nImGvAkaBkh4f8ns1A9PV5aDcaKfNRyH/dzUJvUBo2HOpyNu4brL32MOGT8If+DEI8xNmuf5rWrrzFs/plXrfRVqtKq/B3kU1FCjhNPEfBXhIZudhyD3VZuvFo817bhlhCjGVkSJTOPhlXuPzb6MJm87L3Q15XwQXqgCffqLfeHU+DeaIcWroP8ZgziKCecn0l8FfaSxwFfTl38tqujyfO65frB9iFguLHmoYUH0kXHAr3M1WhtnT4XEueUZ0NK/qgeH5uLB442OB88sSBL7o1355uvzTk2PgNbkJT4BRsUUaFzQOPeKRlKDvod
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <5AE205E46F5C584988A42C922C116D79@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c0f57b-36c2-427c-7080-08d65f77e37a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 14:49:44.5556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1363
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_065000_353931_1FC65181 
X-CRM114-Status: GOOD (  15.65  )
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
 alexandre.belloni@bootlin.com, broonie@kernel.org,
 Cyrille.Pitchen@microchip.com, linux-kernel@vger.kernel.org,
 Ludovic.Desroches@microchip.com, robh+dt@kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Boris,

On 12/11/2018 04:40 PM, Boris Brezillon wrote:
> On Mon, 10 Dec 2018 17:15:29 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
>>
>> This patch configures the QSPI0 controller pin muxing and declares
>> a jedec,spi-nor memory.
>>
>> sama5d2 Xplained RevB and RevC use the Macronix MX25L25673G flash
>> memory which advertises a maximum frequency of 80MHz for Quad IO
>> Fast Read. Set the spi-max-frequency to 80MHz knowing that actually
>> the QSPI drver will set the SPI bus clock to 166MHz / 3 = 55.3MHz.

s/drver/driver

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
>> +
>> +				flash@0 {
>> +					compatible = "jedec,spi-nor";
>> +					reg = <0>;
>> +					spi-max-frequency = <80000000>;
>> +					spi-tx-bus-width = <4>;
>> +					spi-rx-bus-width = <4>;
>> +					m25p,fast-read;
>> +				};
> 
> I'm a bit lost. What's the point of defining this if the QSPI
> controller is not enabled?

You can enable qspi if you disable sdmmc1. I thought of having all described
together and choose one or another depending on needs.

ta
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

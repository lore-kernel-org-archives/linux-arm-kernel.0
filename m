Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECF4C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:52:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2444120870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FxXOa3yo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QQBYBi8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2444120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QYmO7jtn/8oIxmPZiLsek/9nlx8+0c9E4OUZez/P8J0=; b=FxXOa3yolgn3cn
	BTNJybJfubYIT5gojzb6GjyLW5V4d4vcTwW6yuHYPQRdWRDj1P/T2m5uWezmpumTOuC731Hosr6Nj
	j1fWHClIPE2oU+tSjzsGPeCQTlUxzHgXvt2KY6Tvg2dRyu6PP0NHVTncLRlT1UeZOMNJhW/mmSKRq
	UdZnOlxTK4tFNBS7il6gChoxrRHcF0yEMPbrSm2FWILc1DIqkETHNHT5aW/vu7urqJidXHm0wX3/t
	8kXIlETUhgTjEim1fmsBZnISMJDWnSyfIbi5SeBTTwTGJP92dfE4/JV6xCzY1XBIRuKx/ZDjdMivz
	ro44rVJkDLa3KGgIpgRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpSgY-0005qd-Td; Fri, 01 Feb 2019 06:52:22 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpSfv-0005JN-1f; Fri, 01 Feb 2019 06:51:47 +0000
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; d="scan'208";a="23292582"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 23:51:41 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 31 Jan 2019 23:51:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZDgZU6+pucwKLRCr1vWx6iiX0mB7rOL75MR4MHzrqg=;
 b=QQBYBi8W7LLywjqD2mElWgJSBwXw5h80okEJbg6vyml25Dm3il8E4Btf496PbEySCRepnOXVB/Tcjm66/WsoHJmnrp9GyIvF/ecmK8E3pQ1owEY7SpypNF/ZwdcpuRX1NKcXhzPdh3u1R0pRSUHVfHBrxUitrD1HQUhTNZUxyYk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1954.namprd11.prod.outlook.com (10.175.101.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Fri, 1 Feb 2019 06:51:39 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Fri, 1 Feb 2019
 06:51:39 +0000
From: <Tudor.Ambarus@microchip.com>
To: <bbrezillon@kernel.org>
Subject: Re: [PATCH v2 01/10] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Topic: [PATCH v2 01/10] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Index: AQHUuYAu+viSD5s94E+u9UEZBRyorqXJmJGAgADpjwA=
Date: Fri, 1 Feb 2019 06:51:39 +0000
Message-ID: <a0f6dbf3-e9c3-6695-2b85-3907b3f679cd@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
 <20190131161515.21605-2-tudor.ambarus@microchip.com>
 <20190131175535.3f60ccff@bbrezillon>
In-Reply-To: <20190131175535.3f60ccff@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0019.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::29) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [188.25.201.46]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1954;
 6:9vp6s1ZJyxy3qz3RPeoqLmrV6Nu7TPXXsEUvofjhekqPKCX5nnXQm4bmR0SBU9XKy5BC0eLetcI0eaT3Rt5g16S6fkhBodgHteiQ0MZYgC715QsL0szcOIOKICsf1g+BK9Rmgiewb4lgd2gAi6KVY1OMfdaY48ee4kb5ypSTus6kOkvU+MefC9oft5n0l3FAxKnpgGL37Sx6fgHyiPSwrvoeDbDgVTvMNBkzlhqCsh5LyRQKzv8om6zQdKMok+sK7ponTaVSh85SlSSXBZsj61LmhH5MdPqz8rf7szDkDD9tyRdfbiS1q1Yv7JJYn56vPi6D0hhTLV7RA4AkLjJgtl8sdGPkW5x0NfRAyxEgD0GXexRk5NIynNbY/PcpB/BIhhtYQUNHbuNBfkl7hXiZeC2B5PFD3BKbGFGHbusLHQn0v0Mau42S7o0MC6uUmqErBIB1O+6/qehdprEtIi7G1w==;
 5:UEKe/SKYLPtpfIpQO6ljn0asMojXmKMkg/b8cAjTBFbVddWpDOSG3GFrqvGfSozVam33ojdrRVTTkib5/kBn3DuinaMSFXTv5R5qJZgFu/c5ckZw76BoMmigdgD1FrLteTFXIcQm6gy7TjnC3as0y0OSCho9TsZgvscFPZ/3pv9nYHvFqhclDXwiHTgsGq020l0NWDpMv7XLHsxaqrn99w==;
 7:M0nFZptSbK0Smd0PgqFGndj+m53C00+n3iYqIM05j2txS8wbz+8f4RRJEj3MhqHlawqxlaoYtzI37Nckr/zp0yLkwPBudTjIfkZZHxYs+78RdU4YDXE5irdq1s2YjFcMvEf24yySwPXNln/TdGaQfg==
x-ms-office365-filtering-correlation-id: cc9aa2de-ed2a-43cd-15b6-08d68811b70b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1954; 
x-ms-traffictypediagnostic: BN6PR11MB1954:
x-microsoft-antispam-prvs: <BN6PR11MB19542852F4151F6B5F8A5971F0920@BN6PR11MB1954.namprd11.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(396003)(346002)(136003)(39860400002)(199004)(189003)(66066001)(72206003)(6436002)(68736007)(305945005)(478600001)(4326008)(97736004)(106356001)(105586002)(36756003)(6306002)(53936002)(76176011)(6512007)(81166006)(2906002)(8936002)(2616005)(446003)(81156014)(11346002)(476003)(486006)(53546011)(386003)(256004)(6506007)(14444005)(8676002)(14454004)(6246003)(7736002)(966005)(52116002)(186003)(26005)(229853002)(6486002)(7416002)(3846002)(6116002)(316002)(54906003)(86362001)(99286004)(71190400001)(71200400001)(31696002)(6916009)(31686004)(25786009)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1954;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vbsaHPQIta9CL4V+qG15iCdoZpIGJ7RhLMQ2CGsGGyMfhuQJ6bizZ0781MUzZqSGpaG2IjH668oQbtOjFpr2iaQbXrt6G7htLGzr6lP9eBAvHtBCTbEgPptEwl5a1Vxt526ZcZsrMoHFgXzNYQ+8IgPrAqz468xQ20sLbvF3u5/qWI0m2zieK89kLulNd+s6slhpdVge8BWsbWkoEBBYYMVeUlatpnw/y5XuLvU7P9KLCB2Ct9VJLceKxd3hte8/6LYTnTOvQUmpj4NwHleYhCboHZ361bStq4z2nD+x7hH8/wVLbCTfqbSP5/mqNNqub/cM7KEDUfgJBtw4d9nLa8ysFy1VSVgdsESGcuuHpOtSlLCx5oEy4rO8XYrrDTHMUw4m4OGiluynjnVkohNuuLjkjO7YLuxgegbJn7CGGiU=
Content-ID: <AD8D57D6CCC52140A936C75E8005BF0F@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9aa2de-ed2a-43cd-15b6-08d68811b70b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 06:51:36.6225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1954
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_225143_682202_4623BF6F 
X-CRM114-Status: GOOD (  15.13  )
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
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Ludovic.Desroches@microchip.com, robh+dt@kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 01/31/2019 06:55 PM, Boris Brezillon wrote:
> On Thu, 31 Jan 2019 16:15:28 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> Cache MR value to avoid write access when setting the controller
>> in Serial Memory Mode (SMM). SMM is set in exec_op() and not at
>> probe time, to let room for future regular SPI support.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>> v2: cache MR value instead of moving the write access at probe
>>
>>  drivers/spi/atmel-quadspi.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
>> index ddc712410812..fe05aee5d845 100644
>> --- a/drivers/spi/atmel-quadspi.c
>> +++ b/drivers/spi/atmel-quadspi.c
>> @@ -155,6 +155,7 @@ struct atmel_qspi {
>>  	struct clk		*clk;
>>  	struct platform_device	*pdev;
>>  	u32			pending;
>> +	u32			mr;
>>  	struct completion	cmd_completion;
>>  };
>>  
>> @@ -238,7 +239,9 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>  	icr = QSPI_ICR_INST(op->cmd.opcode);
>>  	ifr = QSPI_IFR_INSTEN;
>>  
>> -	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
>> +	/* Set the QSPI controller in Serial Memory Mode */
>> +	if (!(aq->mr & QSPI_MR_SMM))
> 
> 	if (aq->mr != QSPI_MR_SMM)

then I should probably rename mr to smm.

> 
>> +		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> 
> You need to update ->mr here.

of course, thanks!

> 
>>  
>>  	mode = find_mode(op);
>>  	if (mode < 0)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

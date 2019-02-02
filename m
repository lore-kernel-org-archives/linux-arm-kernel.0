Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC964C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:38:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FF620870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iw6bKbMc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="VdKfaip/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FF620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P2ua0Xc+QfOOqBmEh1O0TKPTFTa2C632xb0Pr3gSajQ=; b=iw6bKbMc4CdRCx
	RBFhBEEfnvaH2AIqdfY7M5HgdxY3ESOZuIKmsWZXE1rl+6FX2AC5yreXlHTUK5xiG25xMHBUMza0V
	yP+iOxA9u3DuwhdP/Vl0hWNuN7n6C+UZ63qXSqTnouXGhLtF6kT5Io5x7UJvWRmr/GmKv5O4YxtC6
	44F2vwOGU3YQh3sGfQ85P2GXBJEe7sn87HbnqVe6OpDiDVAErKBqGRmQrsoTZYfKNJdEJsni/xxRI
	cbKrP6YpaLAVw3P9MAz/+2OI4yqG2ArsYNdeO5rLtkOd5KsgLRGYJljYFNse3nDdQgo1g3nUF7aWj
	QXsFs56wtwXo28cHd/GA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpqpD-000462-Kn; Sat, 02 Feb 2019 08:38:55 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpqp9-00045E-6Z; Sat, 02 Feb 2019 08:38:53 +0000
X-IronPort-AV: E=Sophos;i="5.56,551,1539673200"; d="scan'208";a="24149870"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA;
 02 Feb 2019 01:38:44 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Sat, 2 Feb 2019 01:38:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ2T7XKEtfASLBg202ZllOssDx09WpS+ngu+ab+5YTA=;
 b=VdKfaip/7si+oXtva+2PL9pjZYoTctMbHCg4VF1iEs6to8sK0CuluP0jgYvZythdeUIZmCEL4WlwrNhUUfPEiztopxlnkRzb+P+NaPRO9z92WogGUEXlJr0tW7Rn9te/koSnJSp8EMiA7Y0sRNwRbEtiZQwYLVH12OfHZl0ai5Y=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB2035.namprd11.prod.outlook.com (10.173.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 08:38:40 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 08:38:40 +0000
From: <Tudor.Ambarus@microchip.com>
To: <bbrezillon@kernel.org>
Subject: Re: [PATCH v3 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Topic: [PATCH v3 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Index: AQHUuqzGfGfknscimE6zODgQQX/E96XMFmIAgAAZnoA=
Date: Sat, 2 Feb 2019 08:38:40 +0000
Message-ID: <adf1d099-b8fd-6f91-75d7-6eee256b470b@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-2-tudor.ambarus@microchip.com>
 <20190202080650.44becc2d@bbrezillon>
In-Reply-To: <20190202080650.44becc2d@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0093.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::19) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB2035;
 6:tE3TQLDaNKhwwQxRXYeuyn5ScRAbXCYoRmfIgHgk120TUrWhpiUkXXfT3Vex+veMJggUWX0Tyhl7jq2eESrK2a+WtGkmHT4VVhTe0xKpk0vHq7LzzyGFPTB//j8mrCHkzxKtrZSPzI8WWQVIZ/UnR68jiiF2dEpyLBaD0zQjL1cq7idB8CA4ZiKfWqpH5a8/4zTXqzGBdQbTQkXHeE2orq4P2K1e0MjYtGmYfktVYuPCJWTzdTxPJwZXbsMiHsPRd8IIfkbPRn6RZmVHC22BZxN69fobl0NaO4yMnPS9BPU5gB7qd79ZwGfsTn0xTDRSyNcBQcGKTafLB6UGgMTwPayQvBxSzTxXJwu4UzGjZPEd2llAxocVAU/PpuPUZgUw8unTktkb9Df5XGSF8SSu4+iamZSLZX1VC2FvQOVXeJPft5HVTVrz011li5XbwiQZDSPwBfGTkMHqMKnaABjXPA==;
 5:YrUVJhv4rPLVepkgv6adLsSLDgeExQ5HiTzV0IN/6c5jxvnJ19/cwTkQyaHjCpNjoUk8G4iaYFlOfKrLyREAGhtHMIoGuuUpnRp35V30tmGzJDKV07dvgkvCx/ceIjB0/MFxADNfTQ5Y8PVrWoxdVBKxLINjIstr7dPC7iAIX8H1WpLHqTVbN/xcADkT1o2h7ZAw2Ky5C8v48SqP8xntTQ==;
 7:Wj/3qpt+pk3h9W9/Ewbt3tL4//cyscqdXikW4JmLgFPFtMkAs/WISVvvB5isoaBtMUf0GciJ5asl0ce5dqdOomhgD9+T081CExBONT1ENpi+GKdua4pvZSlyLsGiZ4L4bTpQxgcMQPIbAo/6vFYh+A==
x-ms-office365-filtering-correlation-id: 8086988f-8c79-4035-131f-08d688e9d4dc
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB2035; 
x-ms-traffictypediagnostic: BN6PR11MB2035:
x-microsoft-antispam-prvs: <BN6PR11MB20356B50F2AE9650521BEE71F0930@BN6PR11MB2035.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(396003)(366004)(376002)(136003)(189003)(199004)(2616005)(8936002)(7416002)(11346002)(31686004)(105586002)(71190400001)(14454004)(71200400001)(81156014)(36756003)(8676002)(81166006)(486006)(97736004)(966005)(446003)(2906002)(3846002)(476003)(68736007)(6116002)(102836004)(39060400002)(106356001)(6246003)(229853002)(25786009)(6306002)(6512007)(4326008)(99286004)(52116002)(72206003)(6506007)(53936002)(6436002)(54906003)(186003)(256004)(31696002)(66066001)(26005)(14444005)(86362001)(53546011)(478600001)(6486002)(386003)(305945005)(7736002)(316002)(76176011)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB2035;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9QP5TYLaK6B20r/n7h0rR85xLQAh/ToQUhFhbjzY6dwvC15PB0WiA0JRthbUJ13xL5YBg4vRmxXnXZSA9DVW+zQtdbXjojJ+UVVWxkjI74dvlJpPLpoK7ngvqLc4z3uQQu53FxcSR0MjnJgAPEMtd0Rktl7Z4LJkFXr3wBn7Z/fF7fPw35trRkDWu3fY68Oq5fYEaXAlU8xDntLJXiOmWXHlfENW/9WDWWxig1u+wZURYLtCJohISSwhXl9qnQ9OPhbIJGJfHxn/ePUWG4hjkuMpBqtgl5U1grsEmMSYcI7ZjMVBshfTSP+ezdC2nffvHF/nAv+48bgO/wk4ZR/5pswY6a0TroFitZjJ1mZs0TLlzNvg3uvNehP74PhVgZ9rn1zCzLGxmlDJ2ENNWY3p4+vapgZsZKw+2RvsxJuIpyA=
Content-ID: <5481712A5D9E7D4CB4C58E8754D3914A@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8086988f-8c79-4035-131f-08d688e9d4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 08:38:38.0938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2035
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_003851_397140_421AB08E 
X-CRM114-Status: GOOD (  18.05  )
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
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
 Ludovic.Desroches@microchip.com, Cyrille.Pitchen@microchip.com,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 02/02/2019 09:06 AM, Boris Brezillon wrote:
> On Sat, 2 Feb 2019 04:07:13 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> Cache Serial Memory Mode (SMM) value to avoid write access when
>> setting the controller in serial memory mode. SMM is set in
>> exec_op() and not at probe time, to let room for future regular
>> SPI support.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>> v3: update smm value when different. rename mr/smm
>> v2: cache MR value instead of moving the write access at probe
>>
>>  drivers/spi/atmel-quadspi.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
>> index ddc712410812..645284c6ec9a 100644
>> --- a/drivers/spi/atmel-quadspi.c
>> +++ b/drivers/spi/atmel-quadspi.c
>> @@ -155,6 +155,7 @@ struct atmel_qspi {
>>  	struct clk		*clk;
>>  	struct platform_device	*pdev;
>>  	u32			pending;
>> +	u32			smm;
>>  	struct completion	cmd_completion;
>>  };
>>  
>> @@ -238,7 +239,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>  	icr = QSPI_ICR_INST(op->cmd.opcode);
>>  	ifr = QSPI_IFR_INSTEN;
>>  
>> -	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
>> +	/* Set the QSPI controller in Serial Memory Mode */
>> +	if (aq->smm != QSPI_MR_SMM) {
> 
> Sorry, I think I misunderstood your previous suggestion, I thought the
> reg was called SMM. If the reg is called MR and the value you expect in
> there is SMM, then the field should be named ->mr as it caches the
> whole reg, not only the SMM bit. So it's actually:
> 
> 	if (aq->mr != QSPI_MR_SMM) {

No worries. When keeping the reg name, and not the bit itself, I would expect to
do the check as in v2, to let room for checking other bits too:

+	if (!(aq->mr & QSPI_MR_SMM))

I don't have any problems to keep "mr" name, but I would like to understand your
reasons.

Thanks,
ta

> 
>> +		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
>> +		aq->smm = QSPI_MR_SMM;
>> +	}
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

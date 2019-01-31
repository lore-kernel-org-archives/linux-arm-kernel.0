Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC341C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:40:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D36D2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ALMeJzex";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3KTbYpOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D36D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mZoDty48yx0aFywuC8dkF45Dg9GyWhZHR+84/D57WV4=; b=ALMeJzexQLY7hM
	47xvL0lN/0if/De/F+XvbmzNzeTXzoAZuFZQAyQZnRP5/4HruBA3gzfDs2MHnWCTgJxZR0Yb8XXWB
	iambVwmRE2j2DJC86fBUfJhxhQalRPfd8zh0GDcy/drVcwFKifT4huT2l8JDV7xPdfOGGs/r04Jy/
	YjOepaCPrdPXNpQp1d9rYgC0Vja2av36dLibchNXuSRAOJyvaqnqCoNp3BiW2B1V9fugRbb+2pT5e
	kqM5X8YoxYKQlnP7fWyhM+czFVIOS4rZumSxnT0MTV03InA1VEsnuBAxp4AHIAopNMx/mneIPRaZm
	OH7iFugCp9zecrVMDXIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBdc-0002eO-Kt; Thu, 31 Jan 2019 12:40:12 +0000
Received: from esa5.microchip.iphmx.com ([216.71.150.166])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBdZ-0002S9-1p; Thu, 31 Jan 2019 12:40:10 +0000
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; d="scan'208";a="24062509"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 05:40:08 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 31 Jan 2019 05:40:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPP5EtC2RQCrxMPpZgCPgEsafF9RMaEPXCNV4k0Kgq0=;
 b=3KTbYpOJkrPkm+SYlr78peKlwZjFHPStQQzCLuTCMS6U50ZI0ALK5D2Om2frjpxky7utX2no7eNkVMlp7ZlqUysnjVwm9sZbVg/YzZqLm9qhoAhtLsf5IEVa1TGtrSCCRGdYbSGQPh7EMPuiwWdETLZSGU5QctBLwGGEvv3DUQY=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1779.namprd11.prod.outlook.com (10.175.98.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 12:40:04 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 12:40:04 +0000
From: <Tudor.Ambarus@microchip.com>
To: <bbrezillon@kernel.org>
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Topic: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Thread-Index: AQHUuK2zcy+YTju2sU2WL87l1ywXpaXJRlGAgAAMeQA=
Date: Thu, 31 Jan 2019 12:40:04 +0000
Message-ID: <5a91b6b2-0fed-f411-6e96-568e610f15fa@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-10-tudor.ambarus@microchip.com>
 <20190131125504.3eff449d@bbrezillon>
In-Reply-To: <20190131125504.3eff449d@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0100.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::26) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1779;
 6:tyZs/Pu+L6GaLzUI1EeQ2Tc/8Mea7WKW1fu5X4cYn9lK8KDCaNUtoWPr6nkTgnkyxgLXeiYyuXil46OBifhPU5hcIy6hWJ4DD2VdLrXtjxxdGEFOmqgsjv1zGs4zB0hn34sqiqAFpmA7j0Q4pF0vlOZ4bBO1V1kzrtseH8veeZchhQPfG0ZElBA+VwrazMItU3Dm4pBuaaSCClzR14DpaZBnhjqGgW+si/mpfH6LE2wyWYOKsVGUiyCj/yZ+wYkofDfwbHm9xw/Qmqb9mYb2PrgQsnAPRcA7vNQ9p0Lf43CbNV53am59iqqc/zZtcbTq86xyE83qnKpxH1duuEAA8Z0nW+m029Tr9We4gX+gYo0vvfck0jEx7Hm4CPAIh/LR9fHkcYwLZtC3mOF3l/GlZIXUWHxmoYpux7kxVTylMc12cn1FFYDnErAIjwnL6A+E1I7AnxNkhkmt0rmKVvUhPg==;
 5:VHyvM1gVCB5QGXE3PNtBsCiV9iSM/rz4JTNwcww8AIbWjxF8P0RaXbf5gcDpMFN9JkqO8sdHfaDjaCCDu2GmQ3HykaLE+3D51wVXG7S/iEYxlJFcVreT80lj8qrzF5KPN8DxmGp22K/n/dHxEBk0yjbGQYMxKak2g9lnEZhPqYXZPAPmGkjnmYEWE3IZwpKC1J9wOJlBouoZlKTvh7HxEA==;
 7:P+eMofd7E2zur1WXvHk8HdwU2q80RHpskM/Oyec2vvp+xkFZ69+YmUKm9baZcVvVTHrDa4eYk7383/ZAOJcGpg0y0jJddfPqVdI2i348XYuCW7wfStsKeWYykIabCH3Qaev1BW9vMVCTJoTdXZ+XrA==
x-ms-office365-filtering-correlation-id: ae864e42-49db-43d0-de75-08d687793964
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1779; 
x-ms-traffictypediagnostic: BN6PR11MB1779:
x-microsoft-antispam-prvs: <BN6PR11MB17790526981C6026A0672447F0910@BN6PR11MB1779.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(136003)(376002)(39860400002)(396003)(189003)(199004)(52116002)(81166006)(6916009)(31696002)(3846002)(8936002)(478600001)(11346002)(54906003)(316002)(476003)(446003)(8676002)(72206003)(76176011)(81156014)(99286004)(6436002)(6116002)(6512007)(86362001)(2616005)(6306002)(53936002)(71190400001)(26005)(71200400001)(7736002)(305945005)(229853002)(31686004)(14454004)(386003)(53546011)(186003)(106356001)(97736004)(966005)(6246003)(66066001)(105586002)(486006)(68736007)(2906002)(36756003)(14444005)(4326008)(25786009)(256004)(6506007)(102836004)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1779;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bYFlxlpeN70qVr/LbxfUR5cNfysSc6KXeqzIbOUi8n0N1L3ZgMSLPjbpgbnVzcRzhJdquotqpWnF4ytCaPgV0/3Lnsiet+frcFG2VKR4ZfJdNjXVxJTEUy2uYvt0BmL6q/tzx3MZmgD7qMD06+vGh25vCRlqwLTSkSGcHzp/KYeHzNfFdsE9xAZy4loHmJTz1RafyWzAE880rLOPctw9Q4NWkdjWUHfudacCNzYYZ6VxsJPeN/kK42ilHmzXs1nY3wbPlp+6ADxx/uVkv1pis3RPGZGee1vxl1w6ZoIioRAeByeU63TutFRkiM/z7PMkhbA0U8cgU2ZquGbNH3Cbz+vp7qRow3FJcS2V1C6BH8XAMHLhEBYEZqxaFlWaqDbaIEdJq7BDD6Xca8qQYyMv1/1loT5tJinseJ2UfnF4RDk=
Content-ID: <0D3620EBDEE88C4B8700FAC63CE881D0@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae864e42-49db-43d0-de75-08d687793964
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 12:40:02.8075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1779
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_044009_216907_8317B967 
X-CRM114-Status: GOOD (  11.98  )
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
Cc: alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 01/31/2019 01:55 PM, Boris Brezillon wrote:
> On Wed, 30 Jan 2019 15:08:47 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> +
>> +static int atmel_sam9x60_qspi_set_cfg(struct atmel_qspi *aq,
>> +				      const struct spi_mem_op *op,
>> +				      struct atmel_qspi_cfg *cfg)
>> +{
>> +	int ret = atmel_qspi_set_mode(cfg, op);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	cfg->icr = QSPI_ICR_INST(op->cmd.opcode);
>> +
>> +	if (!op->addr.nbytes) {
>> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_REG;
>> +		if (op->data.dir == SPI_MEM_DATA_OUT)
>> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_WRITE;
>> +		else
>> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_READ;
>> +	} else {
>> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_MEM;
> 
> Why do you use a MEM transfer here? What's the difference with a
> regular transfer?

QSPI_IFR_TFRTYP_TRSFR_MEM must be set when one wants to read/write in the serial
memory, and particularly a memory data.

QSPI_IFR_TFRTYP_TRSFR_REG must be set when one wants to read or write to serial
memory, but not a memory data.
Read examples: JEDEC_ID or QSPI_SR
Write examples: writing the configuration or the QSPI_SR.

Does this answers your question?

> 
>> +	}
>> +
>> +	/* Set data enable */
>> +	if (op->data.nbytes)
>> +		cfg->ifr |= QSPI_IFR_DATAEN;
>> +
>> +	ret = atmel_qspi_set_address_mode(cfg, op);
>> +	if (ret)
>> +		return ret;
>>  
>>  	/* Clear pending interrupts */
>>  	(void)atmel_qspi_readl(aq, QSPI_SR);
>>  
>>  	/* Set QSPI Instruction Frame registers */
>> -	atmel_qspi_writel(aq, QSPI_IAR, iar);
>> -	atmel_qspi_writel(aq, QSPI_ICR, icr);
>> -	atmel_qspi_writel(aq, QSPI_IFR, ifr);
>> +	atmel_qspi_writel(aq, QSPI_IAR, cfg->iar);
>> +	if (op->data.dir == SPI_MEM_DATA_OUT)
>> +		atmel_qspi_writel(aq, QSPI_ICR, cfg->icr);
>> +	else
>> +		atmel_qspi_writel(aq, QSPI_RICR, cfg->icr);
>> +	atmel_qspi_writel(aq, QSPI_IFR, cfg->ifr);
>> +
>> +	return 0;
>> +}
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

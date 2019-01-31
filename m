Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DE6C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:43:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C54218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dU6V1DZS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="iO63x+Ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C54218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DkKnHHLdFreAHyj8w0k2hR5m7SKFlrAUADk8Fnyp/qU=; b=dU6V1DZSBL/8qi
	SIeEAwsRdRDoz81p3ecXq0GZDOc8D2Aj/988fZE7vrJuOd7z8UpeDCo0tdHErwGUbmz9y5z4HmtcH
	NlY3SeyCvBOIR52zPb9PU9j3q9rvqz+u8mb3/Y7K1pBQA7HGD4cRv0SjnqSohh03yykQSNvm2L50o
	HCL1nTEo7ngWxepIiSEXadGMt4jKl30ho32KCmXlVfhup1EUPIx1e9m/ndGCYnc6pQFekGvVgfoMB
	bT1Hyl1INK5rCe2Q3OjWIrCYSwbDBFXXL1psFvChiEMI5pIBZJBfQz0MGL6ArmC4B5i5Mi8UNvBkE
	2bCvxwEdRduaFeJaiH8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp9oJ-000839-7w; Thu, 31 Jan 2019 10:43:07 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp9o2-0007tm-7f; Thu, 31 Jan 2019 10:42:52 +0000
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; d="scan'208";a="27102416"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 31 Jan 2019 03:42:46 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 31 Jan 2019 03:42:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYDv8bmVeIcOyx64riWKiG1necLkZPll10wPuBKIIXg=;
 b=iO63x+AhmaCA4k/jQkxJcTL6e2qLi9S7U7DCdei4oNgpzSZyiqmmLnKNOKkzieyRM7EyAjoECql9/QmYDkNKtFx5jpXrqK/tm6BbLX/AHBfqVW98L4GMTH9RWHsGLCogRo57NFMg6qfq1pUFjE1s19wTURQvPlr+T31wZvk9rTw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1556.namprd11.prod.outlook.com (10.172.22.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 10:42:45 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 10:42:45 +0000
From: <Tudor.Ambarus@microchip.com>
To: <bbrezillon@kernel.org>
Subject: Re: [PATCH 1/9] spi: atmel-quadspi: optimize qspi init
Thread-Topic: [PATCH 1/9] spi: atmel-quadspi: optimize qspi init
Thread-Index: AQHUuK2oYIgYi2Phc0CCu9Nb5y7hkaXIDV+AgAEkngA=
Date: Thu, 31 Jan 2019 10:42:45 +0000
Message-ID: <3ae8f1c2-b201-f7ee-5715-e49f39b9cdc1@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-2-tudor.ambarus@microchip.com>
 <20190130181505.4f495d3a@bbrezillon>
In-Reply-To: <20190130181505.4f495d3a@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:802:2::40) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR11MB1556;
 6:l4WUwBNkbLF3l5lrsr27sR2py3qlhKoIuTjHugy28rUlgZj41u7G27MIh7ySkfX+cWlNLyvokHnh5zowmeYm+bV1Bp7prMXoeE7AKazQO0A8IGvteMmqDE7NqQfJdHpzVhTlOAjpnpY9bcLhCcA0D02nxi3YzCYA+o57asQhOzgaBO9MtBogRwjXfjN69urDSrE1i4Mx//ehbQMam7n9tljFhUdgc0RVmtrHvNQztzYdA538nQ+DiWO+PXibrPwHVuYWrQkMpinW9/iGg0O3j+r9M/p7humBXZEgutdJ+EnQpq9CjjDPcJwwO1lEDIhmIl7WPjEzESA4tQ3+dvcov5jrCcQWlEv7a7fFlcrEJas7rIfBlnfo2Xl6hDHXxxY90JbtQvJhXwKTjWFJl2svye3SnNDibnsmvcmShyg1NkPBs9JhgZe11NEBu9uXtALTM7xHqO32H/2ecToi0zPkGA==;
 5:3xufTaZ7TE17rEAnBm4Ms14ZVkExu4F3q/XFwdMbeRDZgVLLX+o+BF8/lU9JKUoe60CYxcbEb6AaCAkl5vvN+7FE4Ppae51ypI21YGcpKEXyF/OvduJEUYiDNjoUxHKKclkVsXURg9V/3B8+bsR83ZanDkSBDVLZPoUYLIS583wiqTAR7RkRCgxU5P6NB6GoTLIJqbXY87GZjoMkdPsI6Q==;
 7:5uTs8KxsOYtGf8L+FNs41soYFOPgDGkIsjXYwBUzg+BiNwU1M7cyjj7Xz5SN4GrVPDRpELfdC3wfH+aQK2o24N5BVvpqvqWb7Gy2qH0P602bG5+B2PHmDUIETb1QeZNSb7kV375jPHPbU1sYtEf5Gg==
x-ms-office365-filtering-correlation-id: 6fc078e9-e918-4fee-dc69-08d68768d585
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR11MB1556; 
x-ms-traffictypediagnostic: BN6PR11MB1556:
x-microsoft-antispam-prvs: <BN6PR11MB15564A9DAA23F7580A14BE8FF0910@BN6PR11MB1556.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(54906003)(86362001)(105586002)(31696002)(6486002)(102836004)(316002)(66066001)(52116002)(229853002)(99286004)(53546011)(72206003)(6436002)(2906002)(14454004)(6116002)(478600001)(3846002)(106356001)(4744005)(4326008)(76176011)(25786009)(53936002)(6246003)(36756003)(386003)(6512007)(6506007)(8936002)(81156014)(7736002)(8676002)(476003)(446003)(305945005)(11346002)(2616005)(14444005)(68736007)(71200400001)(26005)(256004)(31686004)(486006)(71190400001)(6916009)(186003)(97736004)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR11MB1556;
 H:BN6PR11MB1842.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E4Yyj/t8qAQ8yX9P2hvGmjey8hHHQhdWSBZct+Hj2hPcTWUmcx/rTh+j9EYPjsC07Y/qxp8GFwDOFk8Dgiv5gB2+iN9w18TkOWjXgdH4QuvXAKuZ3eMSDDXnf7q7UxYkBLo3A3g0RSEohx8tiXDQf2PM7mILWj4MS0VVcrsbonLTjXjTHxjF1r4GTE6MEGL47lp9p9NKNm/VtcJgHNwv8Ph/N7trYUYwa2PW3mILMxOgc/pHS53djaZGH/DY/H5KStbW9cNHTcFUB+9nqB7dVoMj5tCtP5zwMUrx6dM0e2TYM9G+kUIaRBgku86Cb6PA3UI4siQZ8Q+n3iiRQB/IPSyYgcImpMMnryEkHCKCTDFOtEGuU8GAb9vmYPjGz61psB31ExPHfLgiB0DVFZX6IyH/m7SPoI/mbNYQ0PH6sec=
Content-ID: <762667507B21874EA0F1817206AD37BD@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc078e9-e918-4fee-dc69-08d68768d585
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 10:42:39.9761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1556
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_024250_431660_A8A56A96 
X-CRM114-Status: GOOD (  11.14  )
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
 Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 01/30/2019 07:15 PM, Boris Brezillon wrote:
> On Wed, 30 Jan 2019 15:08:29 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> Set the QSPI controller in Serial Memory Mode at init and not
>> at each exec_op() call.
> 
> If you ever want to support regular SPI you'll have to put it back to
> atmel_qspi_exec_op(), so I'm not sure this is a good move. Another
> approach would be to cache the MR value to avoid doing a write access
> on the bus when the value hasn't changed.

I'll cache MR value, thanks!

ta
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

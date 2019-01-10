Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9A4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:51:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF43208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RHoZnH6s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="e0eaSSwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF43208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GauI5mBiK7L3dlPMN/Hk0gdKSLc2gf2+OR6kTTDNTzg=; b=RHoZnH6sjFkKdk
	Cv8SIfO1NNSNOhcMPxAMzVg+TrRw0thmFWn+eWX5EMYf31OcW0uGsZxI9AVvGgQ3nt0hReKmaDwSg
	Z/Vw0rxcaMHYcTdKkDt3k32gljTGN3E6FakndVJcsF7PywJNZ0gO56d7q8d94fhT2GuxzgBwNqxGs
	MfX1M22aYgcECok3osHl1miKwXTElvvd2TENQoB8RQAO7N+uq57WrRqkkqwWOjnRWYBytDnJocrtI
	BuKlp3Q3TDMS3Zq+jsh3O9TRo22Q9Cxy63/bPxTeU6v0ZI4FurCaGyzobnl3Q4JxZuqZAEzWdfrH4
	2oKax1+gBKik2342M4og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghfQR-0006bF-91; Thu, 10 Jan 2019 18:51:31 +0000
Received: from mail-eopbgr30133.outbound.protection.outlook.com
 ([40.107.3.133] helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghfQM-0006am-PM
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 18:51:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eRcYr0zfyS/t91uH/JUWF0T+8RavFfKOOdOGvqb9bU=;
 b=e0eaSSwRfOeRR4/js1wtLOprdk0p37wxV2OHPFfSqCoSL19/rM9FOLl3hN9U0iwj5dkAd/v3u1MVYlnyHhkRHKSLTBmGLap1mlXIPcYH2nXR7LOS8BOPWqC5+poqjkqlEK62w3zf9OPo36sYZRLW8m6tyYuSPAP0XLykeMUJhiI=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4485.eurprd02.prod.outlook.com (20.177.196.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Thu, 10 Jan 2019 18:51:22 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Thu, 10 Jan 2019
 18:51:22 +0000
From: Peter Rosin <peda@axentia.se>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes,
 wait for next frame
Thread-Topic: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes, 
 wait for next frame
Thread-Index: AQHUqParKHXTvsIK8EaTrDTiqxp7vKWowhmAgAAW64A=
Date: Thu, 10 Jan 2019 18:51:21 +0000
Message-ID: <a31e6514-1643-9e47-cbb4-3323183fd370@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110151020.30468-5-peda@axentia.se> <20190110182904.5efd08f2@bbrezillon>
In-Reply-To: <20190110182904.5efd08f2@bbrezillon>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0901CA0051.eurprd09.prod.outlook.com
 (2603:10a6:3:45::19) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR02MB4485;
 6:piBcS54mCxeoYQlnkYoRzMCiI5YBeMZk0CruVzn85NUonAuhwPtEu3fm15nJLksnsR0ImcrgOsIbq232IhbeaQEPA50BhZrtdfiJV7Dpiqneq5DXUe37BXvfk2R3Lbxvl++BGpeO1n6ey6cBzjRG0m7jSG/vFBTxuXBfSA+atGwfCIeBdkP4pvyMZ/9XIyjvRxmnCI4hs91JHSdwdO0sqTWQvVRDdh/lfTL45nvKmxrIa9BTtSefFIPyPRiCobdzhOutvfRXD5XM4XTy6n0mEdwjlK85bPrY6rgBbHKnRoFMWcg6MxrnsgdO3t5VfmwIBZYbScdKtF/c56S8OVvnO/ljNQ4eR5rfVddC49RLMhD5HcUtNv8l9dtK0jSEAKY+dSdcxWskkU8H5i/CCgoxfZdhTj+bIcr4snbvsi+jSDsgRMS4rcwTdukTzAm8Z8JXdimTrSorFvqA6Qy+4v7Xrw==;
 5:CWyuIRmM1zqg0v0A8mPfBCdVsnezTr2D21QifmNnyt1yGQvdv1KamFZV/1t/ZmxcbOjltCxtUJbMdq4YTNgnOr6/kmfljVbu8T5Rm0ibPakG15q5s939Foi3FgTJYamzO+3PuFoWDxFNgZAqe1hChZDwULNw/mTW6wKhuBRYL7YXNcyq+Fa0h7n8fVhOdgGr/gsO1LnnQpRO5yQf2jegsQ==;
 7:8kokNrpOymnBgiiwfCJXBsVcBSPycSHw5CGlGgRdjKzg1r8AyjQRLMZq1U95BdL55kv9w64+ARh9yFoi1+9qE5iQu421S4SBqNAZv6BgO6uHRdhb/Qoxg/7CWVuFP0Y5mYUVHTByWTG5jezi49bIQA==
x-ms-office365-filtering-correlation-id: ebd4ae03-4e34-4dac-441c-08d6772c9cf0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR02MB4485; 
x-ms-traffictypediagnostic: AM6PR02MB4485:
x-microsoft-antispam-prvs: <AM6PR02MB4485FA8901ED0258E5B15048BC840@AM6PR02MB4485.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6041310)(20161123560045)(20161123558120)(20161123564045)(2016111802025)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR02MB4485; BCL:0; PCL:0; RULEID:; SRVR:AM6PR02MB4485; 
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39830400003)(136003)(376002)(366004)(346002)(189003)(199004)(229853002)(5660300001)(14454004)(8676002)(36756003)(76176011)(8936002)(386003)(6916009)(53546011)(6436002)(102836004)(65826007)(6506007)(86362001)(31696002)(6486002)(81166006)(31686004)(81156014)(99286004)(52116002)(316002)(508600001)(3846002)(6116002)(106356001)(97736004)(25786009)(54906003)(7736002)(305945005)(58126008)(105586002)(2906002)(486006)(74482002)(71200400001)(2616005)(6246003)(476003)(14444005)(6512007)(66066001)(256004)(64126003)(65806001)(11346002)(65956001)(53936002)(71190400001)(446003)(26005)(68736007)(4326008)(186003)(14773001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR02MB4485;
 H:AM6PR02MB4470.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Do9W+swun3Jod8AJYlpwRkNn09y8q7bAT6M6pMnzxjZf7liMn/eU6zhK+OlGS/5f32LbV9KgBZfIRJ/cSFIq0Xt7nyCVusFjmDAaXqLwaiJMGVxTiICs9aW2xE2JXaALifi3fHOfUuxQV/nV9c0bM6FZ2NmcrN1rEWEazSfQ+GhnulKTE/kQIT8/71beFkOUX3JKFAsH9su5jYpGHb9ydoTFDsZbVJEWEuv3Irtjf/gQm9b39C+Z6b7lRAAiO78mLOw5gq4szMqD5lpqiUaYXFJRv+bm/dSig/jYahH/7erbe10xCe9mFEGdVaoKfKdU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <B8D1CE5D5B041B4CA9B8EB38E274A41E@eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd4ae03-4e34-4dac-441c-08d6772c9cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 18:51:20.7206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4485
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_105127_300417_CAA7F2BD 
X-CRM114-Status: GOOD (  19.87  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-01-10 18:29, Boris Brezillon wrote:
> On Thu, 10 Jan 2019 15:10:48 +0000
> Peter Rosin <peda@axentia.se> wrote:
> 
>> The A2Q and UPDATE bits have no effect in the channel disable registers.
>> However, since they are present, assume that the intention is to disable
>> planes, not immediately as indicated by the RST bit, but on the next
>> frame shift since that is what A2Q and UPDATE means in the channel enable
>> registers.
>>
>> Disabling the plane on the next frame shift is done with the EN bit,
>> so use that.
> 
> It's been a long time, but I think I had a good reason for forcing a
> reset. IIRC, when you don't do that and the CRTC is disabled before the
> plane, the EN bit stays around, and next time you queue a plane update,
> you'll start with an invalid buf pointer.

It might be possible to clear the EN bit in ...CHDR before enabling the
plane in ...CHER. Or is that too late? But this patch is not overly
important, I just wanted to avoid the resulting "black hole" when the
plane DMA is disabled mid-frame. But disabling planes is probably not
something that happens frequently and will perhaps not be noticed at
all...

Cheers,
Peter

>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>> index 05519e8c6586..f2f570642f84 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>> @@ -728,9 +728,7 @@ static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
>>  
>>  	/* Disable the layer */
>>  	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHDR,
>> -				    ATMEL_HLCDC_LAYER_RST |
>> -				    ATMEL_HLCDC_LAYER_A2Q |
>> -				    ATMEL_HLCDC_LAYER_UPDATE);
>> +				    ATMEL_HLCDC_LAYER_EN);
>>  
>>  	/* Clear all pending interrupts */
>>  	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

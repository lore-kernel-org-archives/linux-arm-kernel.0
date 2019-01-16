Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6498C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:48:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A0C20840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LTzq4MdX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b75uGW5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A0C20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qLqAlFe4sDkM5N9Cg7Ukj+nWV6r3gWSKfBViVqfF4b4=; b=LTzq4MdXMqJQcv
	OhiBQLAuHOBwpdIklOlNk15bC2lpzW9gCH+aTUxgWg1yxlBY7XoaDS1u84sG6W0en/tlYRAgW+xJU
	9TdMfBFndB8TKRsPLrJvNMn3bS/gX6HbKk8UYj53DEyR54cP4bAcW6ew7I3nprEd4ufvAaEIR2j6Z
	8D5BJnHboWR+YZGU4efbAooBjW0HfvjXbXNS8w/OzjmSkQINWa2qzIAWD7vrPDELxLo150HIAiZ2f
	cOrJ26otJlJRGbtt9n5t2DJ6QZ3trUd1/r1YNnKZeD8Ty4YM0KPNfudrR6Uz8t4qc0uk0nt0Ak+fS
	+GthiXKjyZfQEEAhRA0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjgsO-0000jN-2j; Wed, 16 Jan 2019 08:48:44 +0000
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjgsK-0000iU-Hx
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 08:48:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KH1hrngfGhtmSD9y6vpXgNNTfxPho2lwqmSJd0NLZc=;
 b=b75uGW5LlIYq+LvYWDzv4xZkTTf07Ya/sxsWEsletKgozpYSbW1xTi4eqZM8BrM/PxVOVkWkQoF2HK9e43FE+cm5xBwfoXfkUZ4Ulj1uBCO3e7fXOzhvT/wWoBmCKzwb/bjQUcdQ++cZrrkcTyz9VlEvtrS0vtTPf8YNhSTpQmU=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB2157.eurprd04.prod.outlook.com (10.166.43.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 08:48:28 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::9c6e:406c:e2bd:c293]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::9c6e:406c:e2bd:c293%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 08:48:28 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: imx: defer probing on dma channel request
Thread-Topic: [PATCH] i2c: imx: defer probing on dma channel request
Thread-Index: AQHUrNscebgymanw5EqY6/es3fB8+KWw4HEAgAC2V4A=
Date: Wed, 16 Jan 2019 08:48:28 +0000
Message-ID: <633db479-e1be-3b8b-45c4-06d1b651fe12@nxp.com>
References: <20190115140332.30417-1-laurentiu.tudor@nxp.com>
 <20190115215549.sepj7rmpqmtlxwbw@ninjato>
In-Reply-To: <20190115215549.sepj7rmpqmtlxwbw@ninjato>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB2157;
 6:9DnXq/9LwAuLeT24a7UC9gkHWstdaCeiu8cntKPHWccC+P66+7zE2STASZpCXLWiso63RkJciBuNhiSrmomT707ghTWJ8mzpx9oDf70H6uuWGBMXhaGD0+8vAjPtLpbhlcnalp8/peFggZAX6QstnPejWHQjnmIXX2TCgtjhgfE+bNTR7hao+FzUhuUYy7MNsNcfR78KW6ipvBh17gkMPhg8+o4aABIhzLI0fcUt+gCxW+KIZJiM4BUia78o6CL0VJ2Ag26s2xxCKLzggOzh7xPkru7KlPc1a0ZGHLMKtr5amtJQsYV85fd36GhT5eOyHzEb4jjxShooHPiTFRjHJqHdbRy7jaYfXOmpGIZhyLVnb4I/k2cs9YtvFTtKSC8E4SEjC7Z50jPQ2+Uxg1+145rfvo0sXjTify7ngvK91HoWUXfdYhVnf0aW2KvI+Bv8Y7HuGjo+dpvjJjJz6Cbb3g==;
 5:/iySYbRQ/uUWdZPt9JjidUfVSb4znjY5vRV0X+uJmPVLREYu5G92GmbckQWbY6ATMpzI2lYVKZvLL9I+Iy7ODDrT4Xe7gxK7KCRZG0hu8iZGzHIShQne2T5S0+07W+2IYeKQEeg188vbvGg+ff1ctinlKiOXfLbSfPcgd5uyFnvcYUKJ5/QfSQb5n+oHZuB4gW87ZvQliRMcKPg8qRTBHQ==;
 7:uS7NKiKJvmng4nSToS92uZCn2Nn4npBmJ5+AxUtBinpENIgMXMXunts2U5abnpBaggI6DFNdZGQhlq6w0C9GuSA47/eE79ilEgDttyVSDH2vmA65w8Q2+nvASp/SlBw2yGUhWleVX6S2S1FW+JQ2Uw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 697b2dd5-0701-44f6-2a8d-08d67b8f62b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB2157; 
x-ms-traffictypediagnostic: VI1PR04MB2157:
x-microsoft-antispam-prvs: <VI1PR04MB2157D86CC52664ECF0D1CF45EC820@VI1PR04MB2157.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(71200400001)(71190400001)(6436002)(6486002)(6512007)(6306002)(6916009)(229853002)(7736002)(26005)(102836004)(8936002)(53546011)(81166006)(81156014)(68736007)(14444005)(256004)(305945005)(6506007)(11346002)(446003)(31696002)(476003)(5660300001)(2616005)(76176011)(86362001)(2906002)(186003)(8676002)(44832011)(54906003)(99286004)(486006)(6246003)(31686004)(316002)(66066001)(53936002)(966005)(97736004)(478600001)(6116002)(3846002)(106356001)(105586002)(4326008)(25786009)(14454004)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB2157;
 H:VI1PR04MB5134.eurprd04.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sz/RTeXUHrrO2EeTGIbCAJvNsGvfk4fM0ls/qEnoKRjsUxBCUolT+xuAfCQB7g3kmAsP3XYpWRWd1H4+wjv6zS67irkj2qjfDEW15hXv9c3D4zMJUfEF21Kt05Er3Hn4mBZaqf542VU6Xvx9WU5k+B7/d1t7lR7kwl5Ebn+x04HGqOicqgYnyisYlb1dspQ+RGPVMU5/4tSQ8D+ZauZcDqmED6Xsn4EXyblo+v8ZAzQacYR6Boj5CUkbtMPva5u9dIAg4m2wceaZ23B/CH4TTvQkl+K8qNVQ4DePBGd1dABDv4j0MfIl6k2JUF8QPP8TZZwvzH+Pzaf6Y7OVyfVkBjatubdxqYtib4A0nYsvZNA9tjwg/NPBJjeMnwkg2t5XaH0qeXvTVrs5gzyfVkKgZEAo6Rh/GoJtilK5DITYOko=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <1515DFC079315A43BEFC0B7DB76310FF@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697b2dd5-0701-44f6-2a8d-08d67b8f62b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 08:48:28.4104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2157
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_004840_597393_62D968EE 
X-CRM114-Status: GOOD (  14.19  )
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
Cc: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On 15.01.2019 23:55, Wolfram Sang wrote:
> Hi,
> 
> On Tue, Jan 15, 2019 at 04:03:32PM +0200, Laurentiu Tudor wrote:
>> If the dma controller is not yet probed, defer i2c probe.
>> The error path in probe was slightly modified (no functional change)
>> to avoid triggering this WARN_ON():
>> "cg-pll0-div1 already disabled
>> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0xb0"
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> I just applied this series to i2c/for-next:
> 
> http://patchwork.ozlabs.org/project/linux-i2c/list/?series=85099&state=*
> 
> I haven't checked carefully but maybe it fixes/changes your issue? 

Not really as it doesn't seem to defer probing until the dma controller 
gets probed.

> If not, your patch most likely will need a rebase on top of the above.

Will rebase on latest i2c tree and re-send.

---
Best Regards, Laurentiu
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE2AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:46:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B3321927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t3elLSsF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="CuqBwUv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B3321927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D5Qqmiuh0kP2gnY8WVlglwbZXayOBHlGPUyBvQmWh/Q=; b=t3elLSsFfBxJql
	ojKRkqBDs4JckOgFldGcODbqJfV+QsDQJgfG6cfUmen5W41b5kxEqRmiohTHEdf1brtR1TBEVY9xB
	oRxbLREzbufPxYXVCeeBAoqBZ4gvdsrOdQW/COyRltSmjzqhVFkWare86mLERuBFDV66kVoR2xm76
	rp7sZwJ+zdoT2subTWFaopAsK9+dkjKNPijerHE/oIPZAr8E2u3fOZsLcW0T+XKZ6pumqxVpQiGNF
	SLG0ElQITVpGZZxDfmaUquAoSItu8NUKPQfvdFFfQZ4UkHeuIRxDqmahSelNhSfqxAXOlgje6jXRK
	BvXS6/zpjtcoycuj7ckg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaPoe-0003Qr-1G; Fri, 21 Dec 2018 18:46:32 +0000
Received: from mail-am5eur02on0700.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::700]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaPoa-0003QI-Sm
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 18:46:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBL69DahXTu8tAUg2Vmo5SZ+cXUEqJN+MGIRSnidJDA=;
 b=CuqBwUv6ViRPmLLESuqZQrXig0oA86PakXX187Qxxc0D3xGqIo7Jn1olzyw1ht0how6Iow83oJk4gyxpUFYPpXN/0jBWNzWxwJsGc9oOER+IKuYp3ih4vrcbKYX22K+r1+3oDc9pQQ3ZNNIF/+71AaS99zkJ+NPKi2HGtO3aJOo=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB3103.eurprd02.prod.outlook.com (10.170.236.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Fri, 21 Dec 2018 18:46:12 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8%5]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 18:46:12 +0000
From: Peter Rosin <peda@axentia.se>
To: Sudeep Holla <sudeep.holla@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: at91: replace gpio-key,wakeup with
 wakeup-source property
Thread-Topic: [PATCH] ARM: dts: at91: replace gpio-key,wakeup with
 wakeup-source property
Thread-Index: AQHUmVivQqIWiJjdrEKDiARCuPmK/6WJiC6A
Date: Fri, 21 Dec 2018 18:46:12 +0000
Message-ID: <c22dacbe-ddc9-04c7-cda8-100dcbe0e70b@axentia.se>
References: <20181221181149.6708-1-sudeep.holla@arm.com>
In-Reply-To: <20181221181149.6708-1-sudeep.holla@arm.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR07CA0038.eurprd07.prod.outlook.com
 (2603:10a6:7:66::24) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR02MB3103;
 6:0pR+/VTN9rKYJRalBGD3ABpixu2FuCmCHmXAfOvkT8L7R0P+o0MaIeLweG2RKMEC/akw3rdY1MtUarjw0xjcVay+zT7E9AMaQnR65/pCW3pU6bxRK33IO21Dbke3PUaS43gRLN4Duz+vvWa6884smFIDDPRBdkLcb62oZ1o+zXoCiN84zweRV9b7adEuX/iiWZc+yMTrHdjWU+NKUtjYuYsdCf2kn/cDbSVfUmigqtCPXMUJ6iTmNaHipct57w++qqUpc/CdQplOJWAwwSkY0cBT42umbQYRCy9J42BUk6J08fa8PpYOiQAY1MAdDkZKfO1VhNXedHBCmw92B8p9yQM/haBQWox0b5proWxTJ0caPmrGdOFD4Xbn0g3LLfmny0B9BDzNrqnwmdyYtLau6nzeKJGXegZg9sdnBX9HEIF5Eoaxm2DHxxUBbBpNpi5B7HlkofJWYkSpNGx8dQv/Ag==;
 5:OT9uXKTAqAxyN5/U6kiCTmqWIv4w99LW9Ned5ciOfJkkNRYbdmgW4Z8ezz3PgjhSQP4lKUoQF1/HSAxVu2+ffnpnlW50H6Hd+RT74W1slhAZmMXY3y796YYJuunN6omHt/7RF0P0lrvkneFu/LHRai+dPzA2Ol9UTu2nHiKbMBU=;
 7:E2MImlzquYYdtcYQlNH6PDMNZUOb46PIUIpGArnaYFKFED3zRVofwqUwlrn++yf8kOrAOjlyJ7Vz5lha52DFzxbCXtVGKz7JQQQPmnlf/YUwsx9JPVGp/45HeW0Egcpv8XGAwWc2qvPpILAULUCe2Q==
x-ms-office365-filtering-correlation-id: fd1ce1d6-397c-4c03-2398-08d667749421
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR02MB3103; 
x-ms-traffictypediagnostic: VI1PR02MB3103:
x-microsoft-antispam-prvs: <VI1PR02MB31030BA680B42C13E860A9D4BCB80@VI1PR02MB3103.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR02MB3103; BCL:0; PCL:0; RULEID:; SRVR:VI1PR02MB3103; 
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(366004)(39830400003)(396003)(189003)(199004)(4001150100001)(7736002)(97736004)(446003)(26005)(4326008)(14454004)(11346002)(8936002)(6486002)(74482002)(3846002)(102836004)(6512007)(25786009)(53546011)(81156014)(508600001)(71190400001)(71200400001)(68736007)(2616005)(8676002)(256004)(186003)(81166006)(476003)(305945005)(53936002)(386003)(6506007)(2906002)(486006)(6246003)(6116002)(229853002)(106356001)(52116002)(316002)(110136005)(5660300001)(54906003)(58126008)(99286004)(76176011)(65826007)(31686004)(31696002)(36756003)(65806001)(65956001)(64126003)(66066001)(86362001)(6436002)(105586002)(2501003)(142933001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR02MB3103;
 H:VI1PR02MB5119.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VvP0IedzX6tdrOFWRsQQRoORqGxAP1N03hUIz9FVi5ESw/OU5MAWmvxMtcpv7GO/cV6AuyVliRRsLshSlLid6UWH+s0qI750TXV/+/uLKTmScgq62p0aCeTD08Y4gRImeMZbE0uqCy/g10VwbjPim8gLSTFRcDapVDEfm7aB6RWhDepI6q5mEGDxLvfvq42E8dK1+3cO8aeCkR3Nypb7x/y+q0AWv49NHgwgnJ2RHrrXEn/Ck0JRJDIbFGyuJietj/Pql2oqXPHipQrFCjlNrstL6cV964npleD+sIWkBB1VtfpY6fRC10UrTvwr+xet
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <64532381741D0B44AF9CB5D446BC903E@eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1ce1d6-397c-4c03-2398-08d667749421
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 18:46:12.3074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3103
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_104628_928843_F02D8BD5 
X-CRM114-Status: GOOD (  12.08  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2018-12-21 19:11, Sudeep Holla wrote:
> Most of the legacy "gpio-key,wakeup" property are already replaced
> with "wakeup-source". However few occurrences of old property has
> popped up again, probably from the remnants in downstream trees.
> Almost all of those were remove couple of years back.
> 
> Replace the legacy properties with the unified "wakeup-source"
> property introduced in the commit 700a38b27eef ("Input: gpio_keys -
> switch to using generic device properties")
> 
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Why is this not v3?
Why did you drop all the tags you already got?

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

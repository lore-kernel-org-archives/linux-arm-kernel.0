Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC78C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:29:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F84B20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eGlwo8pR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Kfsa3NbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F84B20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jb3QvixZYxBbXOdRjL9mL+mn9mSv9Lp3R51J0bP24Os=; b=eGlwo8pRTBHU4h
	PCdIn9IvOdyfJrn5DiPIs80quRVGCyrdyaFVmi6CrD1TCziOUsBqFis/D2c6jZHkqclba5bPpwlk0
	6Ed+HsYqp2JQG3c1z//gCiFJE4rekoEUscPHZA+r488M65s1m+bJqjcgBYSJ/VvKjbMRBbIgFJYHb
	WqG82MaKEcZizDBtnPLy4CLKmLY7rDNHjzWVDFPHvhSSp0mf1Ucv0Lc56VyIcroidYOLJbj6SUUSm
	F8nPmLd82V5j20e2oNQ4jVc7CJane2u8+Bpb6p22Vu/cBleNjXUcloekva932MSlUXyvc5v07dXiI
	OQ1RP4tiE/g3LhIRkUcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghwsP-0004D9-VO; Fri, 11 Jan 2019 13:29:33 +0000
Received: from mail-eopbgr00106.outbound.protection.outlook.com
 ([40.107.0.106] helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghwsM-0004Cc-40
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 13:29:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MhBJ+Zjq/sFTfW4lcm3Bqh9Y7u+XGywWwPWEs5gV8U=;
 b=Kfsa3NbUDC3VqQCXwHPzq+FWvQi/Na245LOeOa+aXjrc+4qwSrtSwzb15rMxZyMkEbTSbj3fvAmtL/atNKvZQc4grvDJhl1WpvwOBACOeRft2Xv7WdU0ucFzUYsgq6oKUoQ8uMmnQuA6OASDn+7Vx+NQB4tlJnUIjh8Y8kHmZZI=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB5269.eurprd02.prod.outlook.com (20.178.89.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Fri, 11 Jan 2019 13:29:24 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 13:29:24 +0000
From: Peter Rosin <peda@axentia.se>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 2/4] drm/atmel-hlcdc: do not swap w/h of the crtc when a
 plane is rotated
Thread-Topic: [PATCH 2/4] drm/atmel-hlcdc: do not swap w/h of the crtc when a
 plane is rotated
Thread-Index: AQHUqPal2z9iTYzgb0+a4YlOuMR4jaWox3GAgAFJ8YA=
Date: Fri, 11 Jan 2019 13:29:24 +0000
Message-ID: <23d60fbc-42c4-a2b2-5616-d21eabfd0a3f@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110151020.30468-3-peda@axentia.se> <20190110184816.63350396@bbrezillon>
In-Reply-To: <20190110184816.63350396@bbrezillon>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0101CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::26) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR02MB5269;
 6:ZziP3gtq6GpEmDlkAe52fhjBowZwH3pd0Ilb351VkdgxKWv08JvNoESRAKnjfTnEqi6TAqyrlG6WU3MJKEGN5wIFr6sDCWA9JSnXQfyO+j0teMItSkmKxaQEj4NXpmlvRl5UxftU7LaURYoPaL9VUPcHSNb0B6ugaPoZ//cgwRN6GNzIKhQ/yB9Bd8nh+10kSGSZ33qpZpnT2iOUbiwi0H21ydBbDUMcHsBjhuCvdZMPjc4cOxUDeuIwsxk9XLiSZ7oiXCsUNa+mXTkRLTCISiWttWtJ2xSYEXx9HRwW6ifqMlWr18mW753WunoLOVW06PR1Jos8DybYjkDGdRnmnRsf8xxJj/4fKcS5luV5ZvkO75EeYnCd3otjNEJpPoIuwd4jrAFX57q8pWLxwqwtGp0qbMGmkpiwqYwxEE0UKVWH23ZsMX7X17Excx29J1zb5m24R4z13ileW/OQW0Q6+g==;
 5:APXzV+xbooikA/UYUnFLhhTU/Hrrkxq6DPSHlzixrkinpebCl/rBMw7qzpBM4Y9xmtKJd43ZS0NSWoAmwVqJPSpOEopN0uNmRx9TzwHwacqvjE88aByY8lSvE7qZ9ngKus3A5STSXq+m90RjaQXWJbGO1/qLpy6u1JPYQKUEMZBtLIfYKfI2wK7LXAV309RN84wHgI51is1agIhzaQHz4g==;
 7:LbnHiX1mmMhZhdeJZZ25KCClmZ5RYP5pn9b5CCA2XMJaxrIySWBVVG73mHU77TbGdbVRVciWAD7kuyTlVOtiymJUGu7cCjQAJ30oezbOUKsuqhZeqaMSGEU2KqEL3m8AuaT7IbdB79bOJDzJJStFSA==
x-ms-office365-filtering-correlation-id: 709c964c-05df-43a4-aa5a-08d677c8cd46
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR02MB5269; 
x-ms-traffictypediagnostic: AM6PR02MB5269:
x-microsoft-antispam-prvs: <AM6PR02MB5269BCE62C6F61FD31C2DAAABC850@AM6PR02MB5269.eurprd02.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39830400003)(376002)(366004)(396003)(346002)(199004)(189003)(31686004)(8936002)(14454004)(99286004)(4326008)(386003)(5660300001)(65826007)(7736002)(6506007)(305945005)(6246003)(2616005)(97736004)(54906003)(508600001)(106356001)(316002)(58126008)(105586002)(3846002)(71200400001)(6916009)(6116002)(6486002)(68736007)(52116002)(256004)(486006)(74482002)(71190400001)(53936002)(65956001)(65806001)(76176011)(229853002)(6512007)(575784001)(14444005)(8676002)(81156014)(186003)(81166006)(26005)(446003)(86362001)(66066001)(11346002)(6436002)(31696002)(36756003)(102836004)(476003)(25786009)(2906002)(53546011)(64126003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR02MB5269;
 H:AM6PR02MB4470.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3EbIQaFW/dZXB60KiNKR5Rie+qYPuiAAM0WSm/nnNSBaobu7zYWKDXhf+STjr9+yDcpPDg185Z07HIRNnc4/O9qaaUJnzVlsxM5w19MwbYnBiDiYEKbM3DS4BlK+EhnLtgMSYl9Sws8Qo2XiDPvfQjwEU7rK7e0n045nSswRHc6I6Fpm9Ki6sbxJDXbJfm8/RMNULejqI14fASc2eHZ4zmDdw3pBBExUgoUB4BVVjRML2qRODOiy/9jkvQHRZiKw3rmikRVFI50AIfhEABj0JwS8spi7PWea04sTNoBWpplCCGbAs32Df6hp7cJWGQNJyf2JhExETyoZadKax1imuNfgrLXVXi8HqpOyhTFb0UGEefsRa+8ZI84AVqSaqYVrSwrSVFAOaRrt0K98sRbOwPfjKOlFgqrufxz94XPhzOI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <0E9D57C3371C3A44882D045EAE859C83@eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 709c964c-05df-43a4-aa5a-08d677c8cd46
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 13:29:23.5515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB5269
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_052930_370408_267FAEC8 
X-CRM114-Status: GOOD (  18.19  )
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

On 2019-01-10 18:48, Boris Brezillon wrote:
> On Thu, 10 Jan 2019 15:10:39 +0000
> Peter Rosin <peda@axentia.se> wrote:
> 
>> The destination crtc rectangle is independent of source plane rotation.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>> index ea8fc0deb814..d6f93f029020 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>> @@ -642,9 +642,6 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
>>  	 * Swap width and size in case of 90 or 270 degrees rotation
>>  	 */
>>  	if (drm_rotation_90_or_270(state->base.rotation)) {
>> -		tmp = state->crtc_w;
>> -		state->crtc_w = state->crtc_h;
>> -		state->crtc_h = tmp;
> 
> Again, I guess I assumed ->crtc_h/w were the width and height before
> rotation when I initially added rotation support.

And I thought so too, possibly since I have only been doing drm-stuff
with this driver, but I also suspect that the incompleteness of the
libdrm modetest program is to blame. I don't think it's possible to
specify individual src and dst rectangles with it, and that seems
rather limiting when dealing with rotated planes. I can easily see
why someone using modetest thinks the crtc rect should be rotated by
the driver...

> This change might break users too.

Right you are, and the same impossible scenario. Fix things to do the
right thing and risk breaking users, or don't and preserve the buggy
non-portable issues of the driver making it unusable for others.

I don't care either way, because rotating planes with this stride-
method is practically useless here. It simply requires to much
memory bandwidth. I might work ok for smaller panels with lower
pixel clock frequencies though? I think the LCDC might read the same
data more than once when data is not in the "natural" order? (no,
I do not need an answer to this question, and I do not have time to
dig in this area at the moment...)

However, if you can't do both patch 1 and 2 (because users regress),
then patch 3 is no good either. The reason is that
drm_atomic_helper_check_plane_state assumes the rotational
properties fixed by patch 1 and 2, and the behavior is "odd" if you
have that wrong.

Cheers,
Peter

>>  		tmp = state->src_w;
>>  		state->src_w = state->src_h;
>>  		state->src_h = tmp;
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

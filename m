Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF74C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:37:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD9C21783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OSruVKud";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Y6Z1fT0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD9C21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LawAOv6td19lv1XhTSOXTq6b6i8m/2XzYJB8scwVmKI=; b=OSruVKudLG+8Zr
	iv5NJ42ITW5UwJZcvBSDm9NIl+LrkPoPt6TQSGX+PqM1smGDixZBCwnK0yUUvN1naplG826jpP96j
	EmqAjuZYNE7382M4Cj06P9itjVWBRZQpxXw6R5J9BF0UuKajhUfJ6qZl/GO9w9bP/70IdRAZvowBf
	UJ5JmDcRv3Po2BHd+g/AzaoGRbMAcqAtniRqMSxuJ3VlXAanm2Lzkt39xJ9/eka7csyujVd/yo2Tx
	/XzW8nxoSGwgcdr0i6Z7BO2bnpY0fBRc7TDXQN5wqs9KUY98A8XGI/JViKZwrxPemtKvP1pKaoS5F
	EPOkKgOuM+F4nlASHlUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghCAq-0000y7-Js; Wed, 09 Jan 2019 11:37:28 +0000
Received: from mail-eopbgr20106.outbound.protection.outlook.com
 ([40.107.2.106] helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghCAn-0000xf-7X
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 11:37:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAalFn861qDG0kSiTqVPf2yVqsW/Ab8NVmJFvoVZtsg=;
 b=Y6Z1fT0vfheTZgYnlevbCMz/dTu7Z97qQ8NoBEWCGQ2at62sq2Twgfw1ncboF9qUkBualCBk21Bpg80WEYX39aZf1sElKiOB+ixyGE/ImwzvR935ysGYfUPoykwwtjU+6aA28i8KGXrUyjTVPWjc7CZB7VPNyk1SRQMXEsKdpb8=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6SPR01MB0047.eurprd02.prod.outlook.com (20.178.87.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Wed, 9 Jan 2019 11:37:20 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 11:37:19 +0000
From: Peter Rosin <peda@axentia.se>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, David Airlie <airlied@linux.ie>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Boris
 Brezillon <boris.brezillon@bootlin.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm/atmel-hlcdc: prevent divide by zero
Thread-Topic: [PATCH] drm/atmel-hlcdc: prevent divide by zero
Thread-Index: AQHUp04YoDtjtNas+0efeF6OnACb7KWmuQUAgAAXtgA=
Date: Wed, 9 Jan 2019 11:37:19 +0000
Message-ID: <9b73f5fa-e5c2-ea55-8d96-be6de8a1f34a@axentia.se>
References: <20190108123129.20031-1-peda@axentia.se>
 <20190109101224.GT21184@phenom.ffwll.local>
In-Reply-To: <20190109101224.GT21184@phenom.ffwll.local>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0330.eurprd05.prod.outlook.com
 (2603:10a6:7:92::25) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6SPR01MB0047;
 6:rz0aFzGvYtgGOpVkEoAVDZZagngOuteg1To4JRQIxfi+Ozn+Jgp4nkMJR+aOQIOoLyTUy95zMzYHMQG1XOE+eSCr81edlT+HN/LsktChLhv3gP7eQ2cJQoCRJ+kPb4zOXJVb2acbWv0FvlzQulfZWRRZt5CArKkHmn8Rb3gF6EEcGq66LR/RfQ0sEkgzKLe2iGx6xapnx9tTETpBR7F7gPZOIdH0w0Diqd/KdhSoZ4zANHpqGp8jttqbg1s5NOUXHyhCRT8XdCfNTeg2FRwErkHkCcCLvtZ/r+by5xoKLVTMMX3ZhMurmspseqCCOLDgpA9bzWNRAhEW6xQMlvTPd8cLr34NwJaJguOQ3onfdWUnBYiX6B85OZ97ir0rzeW72yIcbZPB5SX1SK5DSPP08XATt5Pj7bACyyDdpKdW8eLbdjpqP/dG45bsiLC5OkZOTVxzEapCArJN0t6aC7z/Sw==;
 5:YGe0duJJKccr3y/Ghe8HEVm7IUErz7xGiltTj9fRKsFzP1jZNjzvwagxbj7Z8ShbG2nwgelBgvEmbs+SwdcqQP/mQYyJjyCMiwqNuQfSCxoY25bQTeTBFRCq7/uFpRor+qcGYal3QogeMN+qdbdBQeawFXKPG3f97s6YVt277P6163AMKtFoPmGv97H8ETnPuEXQR/Q3hf70xE6x7asGsw==;
 7:7rDE+TPOrd+UN97R3sWTXu0mDUtjL5gZO485NlZ8rzwsZLbcie81SW5POn8dXocXWdngDVfOb82ooewkTI0zraD9Hmu2vBKaAYs1s9Ja1SPWk8wcpHNYLI9DjwNntb0WhUGa5JnsS29desyl8vW3/g==
x-ms-office365-filtering-correlation-id: bf483fa5-9247-4852-c436-08d67626d06c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:AM6SPR01MB0047; 
x-ms-traffictypediagnostic: AM6SPR01MB0047:
x-microsoft-antispam-prvs: <AM6SPR01MB0047CDDAD533659DC0B46875BC8B0@AM6SPR01MB0047.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);
 SRVR:AM6SPR01MB0047; BCL:0; PCL:0; RULEID:; SRVR:AM6SPR01MB0047; 
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(39830400003)(396003)(366004)(376002)(189003)(199004)(26005)(102836004)(186003)(446003)(8676002)(53936002)(7736002)(476003)(305945005)(8936002)(36756003)(81156014)(81166006)(66066001)(65806001)(11346002)(71190400001)(71200400001)(65956001)(2616005)(31696002)(316002)(86362001)(105586002)(74482002)(2906002)(31686004)(110136005)(2501003)(6512007)(106356001)(14444005)(97736004)(256004)(52116002)(76176011)(6246003)(53546011)(64126003)(386003)(58126008)(6506007)(65826007)(68736007)(3846002)(6116002)(99286004)(486006)(25786009)(5660300001)(6436002)(229853002)(14454004)(508600001)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6SPR01MB0047;
 H:AM6PR02MB4470.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4KV0K5WVK78BcBh9kSmQIq+f5CQI3dpyi+Hq0RcIsaSo1avKyKEUnJyoDKB3S3/6XksBHALPlkRy2tS8ItFqcnJlIKw6qBil8zvVLhjCJvBvC89BJkYRmFXHWK8pZMo/M9/gsyoQBpY6kuW3XqfRWelgR0o27vdYHyuBc7f/V5WDjRHTLqeI2DXN9TEGFGnSBYeqLMQVDyoHiG3bw1iRIOxEbSftjx/zKHiQ8u/pb5bcXiUmTI7xvQHJ9c7LpNWIjc2EoTajYsQAroTbKMFjjYykUfUOBGKhw66amIdvPnbF+L+/aAPTrW+7aom0vscR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <BA3B1F688464474AABF0CC5D81CB3628@eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: bf483fa5-9247-4852-c436-08d67626d06c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 11:37:18.8881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB0047
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_033725_273445_A1724C53 
X-CRM114-Status: GOOD (  15.23  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2019-01-09 11:12, Daniel Vetter wrote:
> On Tue, Jan 08, 2019 at 12:31:36PM +0000, Peter Rosin wrote:
>> While trying to temporarily hide a plane, one thing that was attempted
>> was to call (from libdrm)
>>
>> 	drmModeSetPlane(fd, plane_id, crtc_id, fb_id, 0,
>> 			0, 0, 0, 0, 0, 0, 0, 0);
>>
>> This call causes a pair of "Division by zero in kernel." messages. Kill
>> those messages, but preserve the current behaviour that also happen to
>> make the plane disappear with the above call.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> Side note, when comparing with drm_atomic_helper_check_plane_state(), I get
>> the feeling that the src rect should be clipped together with the crtc rect
>> if/when clipping is needed. That function calls drm_rect_clip_scaled(), and
>> the equivalent does not seem to happen here. Should clipping be performed
>> on the src rect?
> 
> Any reasons atmel can't switch over to that helper? Would compute a nice
> ->visible state variable for you ...
> -Daniel

I have not researched that, and as stated above, I was not sure if that was the
correct approach to begin with. Boris, any insights? Does this code predate the
helper or something?

Maybe there's some register bit that hides a plane explicitly, matching the
->visible state variable? I haven't looked at that either...

Cheers,
Peter
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

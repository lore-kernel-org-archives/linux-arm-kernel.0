Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C17C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:13:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE852087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OvYmc/C/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="ZR5eaPYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE852087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xxq2jv/jXglcve4UvSA+85YgQ9TQMg7WQVQVeusrsG0=; b=OvYmc/C/MoK2rj
	vBaccqIkYNz/Sz3ypO3tAi3Qvnbl0EGnH7Dgu4KDjpk8BUVWHt0X10bAdtNGdkBAIUnm1SJjcmI19
	8ScdCnwQ6XU9Y+FJ1oxn9SpKGwMx91SMixSGA4oTCUBZqZ2807aktnu2JdinMvpemIpW93GjufLMw
	bUW5SVXLA8jo27z4A4cT4F/K2halQktUwze5MB64doXScXpcNCaap+r8TYvWbjxAGJivFX2Y6jbv8
	y2nyvecFtwVF5GINhg7nmQ6NJZWcBo8VTPwf7JEuytUwSLx9UoOTOLEx+QGtScuUIx8zCJv+2Gf8x
	k96zNkki+lB39yCM1i7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpC9t-0000N1-0n; Thu, 31 Jan 2019 13:13:33 +0000
Received: from mail-eopbgr00106.outbound.protection.outlook.com
 ([40.107.0.106] helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpC9o-0000KP-Tv
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:13:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK5tZy1W9j3mtA/lZUtoYYOLJszdB6vdOOVsSgZgaXM=;
 b=ZR5eaPYSqWtKUS82So+RNVB/oVDcv2ozHOvx16d4JvrNa/Qc+2eOz6ZcFW78aJV9P4+iWk5nt9k279vwiYsecY+1gECsL+RouquZRklB3Ts98jpMLCPK6b/XTgeZZeFo6ieLLpfa25pl4m/jGQtqX+x62hQ6GGSksV2nwZXP/Fg=
Received: from VI1PR0201MB2112.eurprd02.prod.outlook.com (10.169.131.25) by
 VI1PR0201MB2096.eurprd02.prod.outlook.com (10.169.131.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Thu, 31 Jan 2019 13:13:22 +0000
Received: from VI1PR0201MB2112.eurprd02.prod.outlook.com
 ([fe80::515d:5c88:762f:9d37]) by VI1PR0201MB2112.eurprd02.prod.outlook.com
 ([fe80::515d:5c88:762f:9d37%6]) with mapi id 15.20.1558.025; Thu, 31 Jan 2019
 13:13:22 +0000
From: Peter Rosin <peda@axentia.se>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Topic: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Index: AQHUqPaeuHFV8522kE2kP/gCblgMKKXC4lQAgAaZNoA=
Date: Thu, 31 Jan 2019 13:13:22 +0000
Message-ID: <d2e24b73-dee1-b31a-dc87-02d2e75b6dd2@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190127092709.3863c954@bbrezillon>
In-Reply-To: <20190127092709.3863c954@bbrezillon>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0176.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::24) To VI1PR0201MB2112.eurprd02.prod.outlook.com
 (2603:10a6:800:24::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0201MB2096;
 6:jcy4lA4Tiqjq/84J+7VKG4aUVjaP2R0fArkDQvvEhfkv3N2OpSDXqvfGzXcdyHeU3evOQL79HnKl5ab0u0BCdyPPGYLBI1yynC9rd5+YDBCMvu5MpQwP/89psxvyVy/t1I79THOYEg25QTkcLZI+oqWcGij7SNNfSK4Q8WxJiQdvOMUfVe87IlHqeJZcPaS16zCTa6AQX90w+LrXdhkowX8+lFeB2lqFLRALEVhaJY0gnhSh9AmVVtTTEt3wMvPRW57U+XX2PdJuU2x3NBsOU6xff7JUS0xfRTtH5SMRTnYx//ko38CYPRTHcUHzBj/DkrxrHzssZsd3cNGnjXMdjelCltmtM09FLUlphkbipegnLcr2YliMBUATxwdNCt+xJaMF8LR9V788LRhmGsPYWvBHM4Pnkcfl257OtHuWUycAP7RQ6yBgsNnTdRTn0P2LOt68RPEwazfuJSeCZzkWBQ==;
 5:B+GGnEbRt5wfKX3YvpEyLZKkjnZFZfHtLQZzZ5tKDXeloy4zCPfWCP5s4l7RzShIBUcqu5PvyyVtzbOaroOVqOhyp6iViUjKjFLkhNeVOfrgA+Z1rhmRLTHpVyUTuY0pX5z6kDYjWcUMKj2U8JlM9FamvA4E15L4Qt5zgJnq0Qek54xL6BH/SHG0m3zB3oBE2QsWjq8LgVPHLNabP2Th0A==;
 7:MSCth/pKLz73+sFpuibJ0S4ge5R44OyqzIwXO+7IAODx0TF0438Bp6aZxftoAHEm+DRIZk0JfsciNheug8rEUTh4kTGoKv3URH+sYas8MjZCM4Abo1UNV6x57z66f2NtDoS5y+LMaqnvR0dd/QGm2A==
x-ms-office365-filtering-correlation-id: 751f425e-42b2-49f3-9d92-08d6877de004
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0201MB2096; 
x-ms-traffictypediagnostic: VI1PR0201MB2096:
x-microsoft-antispam-prvs: <VI1PR0201MB209656A70ED2E398CF228202BC910@VI1PR0201MB2096.eurprd02.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(346002)(136003)(39830400003)(396003)(189003)(199004)(6506007)(2906002)(2616005)(3846002)(74482002)(6116002)(6246003)(14454004)(6916009)(11346002)(105586002)(71200400001)(106356001)(6486002)(486006)(36756003)(229853002)(446003)(86362001)(31686004)(476003)(6512007)(31696002)(97736004)(71190400001)(6436002)(7736002)(8936002)(66066001)(65806001)(53936002)(4326008)(64126003)(256004)(53546011)(8676002)(305945005)(386003)(52116002)(316002)(54906003)(58126008)(81166006)(81156014)(99286004)(68736007)(102836004)(26005)(25786009)(65826007)(14444005)(76176011)(65956001)(508600001)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR0201MB2096;
 H:VI1PR0201MB2112.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SWQdR8/hQu0KFEYnaBJ08G67Tk3YTyD9UoqALH4uifpKZju9gfQU7PJT0g7XB8FbrVNSBdfZIor2scbc33Vv4h6ky2ok4CIkhQwCqqwAtR8acw4QiCLSSMJnHAr/W/wvUhygqiIE5ZlY93hXWaHSN0bYMpPReMKoF8oPF2xIxmJ8UkzF/wv5zBhIHqMg6U9LGWFS4UvZlImetimjY23VYDHkmSy9d2dg9Sv4efq6TSjGzwooPf+cSagEw+HrBr4181CZtDNeLt0sbtX8XvossYSQ2Ecj4diHL+lZrKD8loccqc5cD+c5IuKmJngHDq7vkSi9s5txG0rj335J9utpd+lHbJomgVzpXr/Pb4uXBtzZOM7ueNg04UrPH1y/q23M5+1bemJhBaWSEgtNAIONnaT+iKfv/k7jsIJnswqG4Lw=
Content-ID: <3FF5C38029451345A2864983E6C4930F@eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 751f425e-42b2-49f3-9d92-08d6877de004
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 13:13:21.2470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2096
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_051329_221981_C4E7792D 
X-CRM114-Status: GOOD (  17.48  )
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

On 2019-01-27 09:27, Boris Brezillon wrote:
> On Thu, 10 Jan 2019 15:10:28 +0000
> Peter Rosin <peda@axentia.se> wrote:
> 
>> Hi!
>>
>> I found an unfortunate issue while recoding plane handling to use
>> drm_atomic_helper_check_plane_state(). The driver rotates clockwise,
>> which is not correct. I simply fixed it (patch 1/4), but maybe that
>> will cause regressions for unsuspecting users who simply assumed
>> that the clockwise rotation was correct? I don't know what to do
>> about that? Adding an option to get the old broken behavior seems
>> useless, wouldn't it be just as easy to just fix whatever app to
>> rotate the other way instead of adding an option somewhere?
>>
>> I have only tested this series on sama5d3, but I did check the docs
>> for various other chips (sama5d2, sama5d4, sam9n12, sam9g15, sam9g35
>> and sam9x35) supported by the driver (relevant to patch 4/4).
>>
>> Cheers,
>> Peter
>>
>> Peter Rosin (4):
>>   drm/atmel-hlcdc: rotate planes counterclockwise
>>   drm/atmel-hlcdc: do not swap w/h of the crtc when a plane is rotated
>>   drm/atmel-hlcdc: fix clipping of planes
> 
> Queued patches 1-3 to drm-misc-next.

Great, thanks.

>>   drm/atmel-hlcdc: do not immediately disable planes, wait for next
>>     frame
> 
> Still waiting for Nicolas feedback on this one.

[Adding back Nicolas, he seems to have gone missing from the list
recipients.]

I have done some testing of that patch and for me it's a definite
improvement. The test I did was removing a white plane from a white
background. Without the patch, the driver will output black where
the plane was for the current frame (since the driver does that
disc-area thing for the largest hidden part of the background).
With the patch, I get no visual glitches when removing a plane.

I use a plane to scroll a text, and if you know what to look for,
the black rectangle that flickers by as the plane with the scrolling
text is removed is little bit disturbing. Not a significant problem,
and maybe only geeks notice it, but still...

Just wanted to say that the resulting "black hole" mentioned in the
other thread really does exist and that the patch may make sense
beyond the fact that it removes usage of undocumented features.

I have not seen any bad side effects fro the patch, but admittedly
my testing was very limited and I did not try to remove the plane
while doing other stuff with the driver. So, there might still be
reasons for removing planes immediately...

Cheers,
Peter
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

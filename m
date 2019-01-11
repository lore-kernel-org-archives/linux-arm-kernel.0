Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1803DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:17:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36CC20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U24Q/gRU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="tNGRBLlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36CC20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d/uL7azVQBjPSxz9xfmXkAqDSeNBBmhx+sH56QPCcyI=; b=U24Q/gRUh90s3+
	76v18DMiJ5ZsOhSmeCorV4DdW1kudKXODnexPZrNIZfAb+TSr3Oe9Xp4utrscZHkRpj2VdC6V01nD
	h1WMsDpLGwAw3GrS1lccl1OTQU6x3EZTdBVaB6hTnIyHtrLYcwA898BcfzOwJEhpQ5t1YW4j+ZLCb
	JLp0DHttMx0vwP4G25QBHrhfrSDSNvMd2s1Vz/mIpShPSMGWgOjiOiWiw0+BsL3SO17mVwynLuk75
	2lBR1lFJBqJLFN1JNDFUUZgeiXGntgrSOt9PEOsSzFwQ5aBhBiMkSmP5WyllQubfeVlKbAt93b0et
	YGthidrFVESiI/5wrPZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghsw1-0001pF-BE; Fri, 11 Jan 2019 09:17:01 +0000
Received: from mail-eopbgr40123.outbound.protection.outlook.com
 ([40.107.4.123] helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghsvx-0001gK-Ql
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:16:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=527uqIgKGmDpWU40YpnV0nKSBafJDnhPf9ae9jS/AVs=;
 b=tNGRBLlHtLsebbqKPXon9pntpw7jCaX/XN5368L079FwSig1ZqGlJLybck2zVEgOynBqjynV2X028T6xpIudM/ei9yrwMdEoVdnt1WaQaCxjCEcefrnybSC7PBJwLgrd+31sqDDXm109JC6H7Y5Lqr9fqnBbb1HD+FqRPj+J9AU=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4454.eurprd02.prod.outlook.com (20.177.196.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.11; Fri, 11 Jan 2019 09:16:54 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 09:16:54 +0000
From: Peter Rosin <peda@axentia.se>
To: Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Topic: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Index: AQHUqPaeuHFV8522kE2kP/gCblgMKKWoxn6AgAAqWgCAANn/AA==
Date: Fri, 11 Jan 2019 09:16:53 +0000
Message-ID: <995284f0-b29d-feda-6c3d-13a59533b7a0@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110184446.75b4350a@bbrezillon> <20190110201636.GA7074@ravnborg.org>
In-Reply-To: <20190110201636.GA7074@ravnborg.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0283.eurprd05.prod.outlook.com
 (2603:10a6:7:93::14) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR02MB4454;
 6:zCu68lT8t7YOrRNYf+SifOQKGZWacaF70D26qUYgz/aKdrKuHrhP6Cw2T4sZeRFPEId668bFgCtT6r6g3pt/zYCTDDMLr/y9D19srhpoGbqqUzO+Js1hJM9NDtyfOBkh+lKeC7zBrElIk/fsdzTD82hTvdwwbc/8AXKkpHtLast4jUrdWeK+rxia6Io3lfXx8db0EY+3I82ZfNQxGTgtemX4/oFwUW1bUZTS2ir25euR098lCFpJSYJ6072W9SGG/RvKPg7ofmkzXy4l2+0laT2fWYE0Kmhzow8N6y0ibSkgGTj6mwVHhC2KqrX5r9lS302sfvHJjgN+0ljWdmJ2RZg1VwdfzwoDu/Bl8St+nVUzNsXOIKNmXqBcZhTYgN0mJaAlP7f33lWuuuMkOBR6zAcZZ4Wxms9FoI+LLkpt4OLYjX+LkJwXc+nNOapQauesrqLOZPcxnDLVRdDS10hBZQ==;
 5:miKPwntdf0fIa0fNMzuDrSfqFmKDDKx4+juuyUalBEAkrA5ACJ0as9JZLQRBbaVcNO/5RYBMWYlsP47e2kjWSu8ss4qTzWBlqGXPbXBV3ln1dxMedI5Ehix4EGNGoEIqL030ZUlW1l94tXyBuZQ/QsVBQyuW5e4G7w8nTcd0X8O/qi3t8BzLvEMDpIG9iRKbkDt/mOugCAZrV2QY8dZUPA==;
 7:bSukjdCjfinpobqUaqrDy9IE/WCVUPXOnYi0/n6qn/+nHExz5N4+4Hsex4qAV3FmGlmAeg2K2jZJ/pHM21c0WuvOBqvTYBzFhatpHqKALEWTWgsVLYC+RF5nyoGMbmcESge0E4G7eKP+fMh5ugbQSA==
x-ms-office365-filtering-correlation-id: e7d1b449-ce51-4ac8-0261-08d677a586ec
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR02MB4454; 
x-ms-traffictypediagnostic: AM6PR02MB4454:
x-microsoft-antispam-prvs: <AM6PR02MB445414F8BED61A1D8CC69F0EBC850@AM6PR02MB4454.eurprd02.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(39830400003)(136003)(376002)(189003)(199004)(54094003)(52314003)(966005)(229853002)(2906002)(36756003)(4326008)(186003)(65806001)(25786009)(6486002)(6306002)(65956001)(26005)(97736004)(6436002)(3846002)(6116002)(53936002)(316002)(65826007)(256004)(5660300001)(71190400001)(486006)(6512007)(102836004)(66066001)(64126003)(71200400001)(386003)(305945005)(31686004)(446003)(7736002)(52116002)(476003)(508600001)(6246003)(86362001)(81166006)(106356001)(81156014)(105586002)(58126008)(8936002)(54906003)(110136005)(14454004)(31696002)(8676002)(68736007)(53546011)(6346003)(76176011)(99286004)(2616005)(74482002)(11346002)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR02MB4454;
 H:AM6PR02MB4470.eurprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +axoUt5iHCLXmw7iAbU4SFcjEgVWE4SQoz9zi74QhJ252sTbhZg9zJxP4Zeog8GQa/qlLWlRTzoJHqmXUM1N4iaAJBltG4uNZaY1meWSNgZ26m79Q79fQ4EEK2MvSuC0xXZFtPBB8x/bVL6FKnSmWutYQvOmyLbqm5md0lAXKQthJCAODgo77N9b9hpe2ZAn/UtMknMYPRmCialIQK/VP3PlgSQWqcuodJ8eCh1lPcSfj001YNQhNyF0FS8iYBrUBCWThPfBDfJvUBobX88RwWT0cMski5cUbmE2S8HVuex9e33WVIJZMsLj+VlmH+PURP07z1ryK/jrfOAVNfVigfA9LcndE/ekaE/XFZhVlfl2i61rjjoD2BdZwGaUUfBi+I005I0tURfQv7ExU0xwb7IOMhTt3I3O2+p8xzXDhIo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <DF0F2BA89937EB4B8756D2E1D308EEAF@eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d1b449-ce51-4ac8-0261-08d677a586ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 09:16:52.7650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4454
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_011658_108552_FC4E6D10 
X-CRM114-Status: GOOD (  18.41  )
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

On 2019-01-10 21:16, Sam Ravnborg wrote:
> Hi Peter.
> 
> (Hijacking this thread as I lost the orginal mails)

Assuming you wanted to reply to this patch?
https://patchwork.kernel.org/patch/10753571/

>>> I found an unfortunate issue while recoding plane handling to use
>>> drm_atomic_helper_check_plane_state(). The driver rotates clockwise,
>>> which is not correct. I simply fixed it (patch 1/4), but maybe that
>>> will cause regressions for unsuspecting users who simply assumed
>>> that the clockwise rotation was correct? I don't know what to do
>>> about that? Adding an option to get the old broken behavior seems
>>> useless, wouldn't it be just as easy to just fix whatever app to
>>> rotate the other way instead of adding an option somewhere?
>>
>> Hm, rotation support has been added before the standard rotation
>> property was created, and at that time I assumed rotation was clockwise
>> (which apparently was an unwise choice). Anyway, I don't have a
>> solution for this problem, so I'll let Nicolas decide if it's
>> acceptable to change the rotation behavior.
>>
>>> I have only tested this series on sama5d3, but I did check the docs
>>> for various other chips (sama5d2, sama5d4, sam9n12, sam9g15, sam9g35
>>> and sam9x35) supported by the driver (relevant to patch 4/4).
> 
> I wonder if, when this code path is anyway touched, could benefit
> from drm_rect_rotate().
> 
> It is obviously not a simple replacement, but could it be used then
> I hope the resulting code is simpler.

What are you referring to that goes beyond what is done in patch 3/4
in this series? After setting up the strides, the only use of src_[xywh]
are to calculate the scaling factors, and for that the position is
irrelevant. I.e. src_x and src_y are not used. Sure, in some theoretical
sense it might be good if src_[xy] are also transformed into the rotated
coordinate system along with src_[wh], but it seems a bit backwards to
switch over to struct drm_rect when the interesting properties are the
width and height, not the coordinates of the corners. No strong feelings
on the issue though...

Cheers,
Peter
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

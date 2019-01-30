Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EB2C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:01:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3041220989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J4Ypza23";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i8gpv7AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3041220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VjEKxqLCv9XZGWzwD7kb7dofbzk08JBnNUz847CwCx8=; b=J4Ypza23Ajfc/E
	T3Cvt1W3Qg4WaX82EdtnW6hVdU2med6zZRzjlUs1sEXoXkyonI7cdaHqDhTrlHRbakVsWhlDxqINr
	Xbje+P5GkGcrcKysSBomL+6w2aKRSOskkmBJ0rMKs3luiu7aeA+9kVh/LdXCFrfbgzR8naOzuG5El
	KCTAsWqlze62hrCvkaqz4M4H+zC+ZmtUa9JVZyDdSl6bPtCpQ1ERnIMBWSYZP4WTVFD0loDxIJ1lX
	XJ3gv//bYsXtx+OnN4pweC8Zg20hh2EgoyxV60VZRGahqkgxripsgbWFiH3gwBkx6OZmeSckl9hoK
	NaLNMEIHXMuSHMluAmHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gow2x-0003Bc-Cl; Wed, 30 Jan 2019 20:01:19 +0000
Received: from mail-oln040092000096.outbound.protection.outlook.com
 ([40.92.0.96] helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gow2t-0003Aw-R5; Wed, 30 Jan 2019 20:01:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRVNT3BFciODuz5nWl30CBONZ7QO2Wur+Hw7Y+H3vQQ=;
 b=i8gpv7APSbQ+Ut0KeMKxQsRxhQ4pN9YzTTwxOz0aayA5kLKkw/PKfT3fdptWZS+ER7T3djSlKz7EQzvLpu2xau3qNKowa4+NKt1PcCvNlwpcfnReRgbYWOF5B5+89hr3xm136j3B+GGJYPwKCl0KcFuER/1h3yCdlQAYwJ/aR1W0PJsFjo/jlECjez6iR6UVFclSJXxU3aV8syUFWRfRF7is1cx3CPueOZ1FjjzYNV/IyvcvIJ23ilIl5LHCKaBYiotTYO5rNShfMvi+s625yS9Mk11GSN9kHyK+Nba50iluKxI80i/01MrLCaZ01rLJeWxqVK4v4Oi9tDgrVvMwkg==
Received: from SN1NAM01FT046.eop-nam01.prod.protection.outlook.com
 (10.152.64.52) by SN1NAM01HT100.eop-nam01.prod.protection.outlook.com
 (10.152.64.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Wed, 30 Jan
 2019 20:01:13 +0000
Received: from RO1P15201MB2012.LAMP152.PROD.OUTLOOK.COM (10.152.64.56) by
 SN1NAM01FT046.mail.protection.outlook.com (10.152.65.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Wed, 30 Jan 2019 20:01:13 +0000
Received: from RO1P15201MB2012.LAMP152.PROD.OUTLOOK.COM
 ([fe80::914e:44b0:65a2:a915]) by RO1P15201MB2012.LAMP152.PROD.OUTLOOK.COM
 ([fe80::914e:44b0:65a2:a915%7]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 20:01:13 +0000
From: Carlos Henrique Lima Melara <charlesmelara@outlook.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] staging: mt7621-eth/ethtool.c: Correction of SPDX
 license identifier
Thread-Topic: [PATCH v2] staging: mt7621-eth/ethtool.c: Correction of SPDX
 license identifier
Thread-Index: AQHUuKrcmbJ1/Slp9Uu1hNB7UlhL06XH7/gAgABLx4A=
Date: Wed, 30 Jan 2019 20:01:13 +0000
Message-ID: <RO1P15201MB201234F951531D13328C4FF2A8900@RO1P15201MB2012.LAMP152.PROD.OUTLOOK.COM>
References: <SC1P15201MB2014C3E0CAB4DA9ADF330797A8900@SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM>
 <20190130152956.GA4195@kroah.com>
In-Reply-To: <20190130152956.GA4195@kroah.com>
Accept-Language: pt-BR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CP2PR80CA0037.lamprd80.prod.outlook.com (2603:10d6:102::23)
 To RO1P15201MB2012.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:4:1d::10)
x-incomingtopheadermarker: OriginalChecksum:575977F9B7CB98A486810912E3966728025778F9C82408C67025760731873322;
 UpperCasedChecksum:7CB8BC7C81102ADBBB0E44039B3A71EBD46C045079EFAE35375B4994EEB5436C;
 SizeAsReceived:9055; Count:64
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [re8PmgQJNBUJzMRMTIB8IGAf8LxrNddyoGpASTzIe3+eS7gdFefmoBUSksw8GLDI]
x-microsoft-original-message-id: <c9304dc1-ffe8-d49c-e994-b3998e8ebce6@outlook.com>
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN1NAM01HT100;
 6:hyORNiOf2r9WO8mV+FGtAeMdcvjxllAa0K1R4sv+ilKV1fxMQrqK61YqPkaqh/G7U1t1EJQ6sbh4UMSwjB73w5QjqR+P1xLC7XE/E0bhJWPXJQ7+f6fJfGqBrL4KHTllnO0LGfPb47w+SvNr3u/K/ru3iebXBu5sfrEYPd3/kS/x1Jba/ElX9i67jb72Ev+ml9NSPohQi4u6UoFGoiIzgEI0EpAyXVIpledAPQGTPdzXzQWWE4VAzf5FzxQZL+pHP2UdY1WkkKJ0wgbjW3uQYcbmXg6I5T40dpuVa/HtkGHcQFpTo69e5ywkbpgdkPPmG/J4oIS9KnXmP0FM1WB2cZlpIIHpoTshYrnF+IABE4GGyfrDQALsFPxvRsESyNiUffj2iStzijtJfwSl0bCrd91WmcODftEAbGjcQnqAW9wnkl8t6JCkOhTQXllkmohd3mjVwNYkDfhtIHrNWauIrA==;
 5:BpmTZfqsfHxCKnULLwcgckqD7fNfbtesfbPjMbxOkRuU8PCnX6ABYpinUwvxX3RJofB1BlXtzODEdyJ6mjtrn0Bwy2vkfrN60FS+pPic5/BeaMViy0Asi+qLYhpATvvLvVxmQkgdt+bWbLddHh1hdwK0Bg5ZQPE2bW6EPmTWtPXKeWu2VItCF2Dayq5OG4CE1f+1zRBWqWJef2XrJNgaGg==;
 7:6WloiTEXvr6wHE3ujCFrCUg0mHFU/618mhK27pkmx14fpxgP3n+eCTi7v0t9OysrT7hzG/bduTZRx/pUzskpLJPYRgEyTMcTTQAWhlckMgzoKnKKsgyJQSRhgt+UcniTaM12fNwpbI8LohBM1gtVXQ==
x-incomingheadercount: 64
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(9118020)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:SN1NAM01HT100; 
x-ms-traffictypediagnostic: SN1NAM01HT100:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:SN1NAM01HT100; BCL:0; PCL:0; RULEID:; SRVR:SN1NAM01HT100; 
x-microsoft-antispam-message-info: K+zuSF/SBOFEzWo+8IZdFrhKJElInAZpaR+nH3TYg+yOqOEgqDH5gSqxd1IUz/an
Content-ID: <F15E69E1BC3E5A4888E02762FFEC36A6@LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 24fd1209-d934-423e-a578-ee886993c07f
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bba45ac-e274-498b-0d39-08d686edaf80
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 24fd1209-d934-423e-a578-ee886993c07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 20:01:11.7019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM01HT100
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_120115_964538_87CCF5BB 
X-CRM114-Status: GOOD (  17.74  )
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "neil@brown.name" <neil@brown.name>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 30/01/2019 13:29, gregkh@linuxfoundation.org wrote:
> On Wed, Jan 30, 2019 at 02:48:27PM +0000, Carlos Henrique Lima Melara wrote:
>> 	This patch fix the checkpatch.p1 warning:
>>
>> 	WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
>> 	+/*
>
> Why did you not fix up the indentation that was already mentioned?

The Warning was about the missing SPDX License Identifier, so I added the 
identifier according to the "license-rules.rst" for C source that is:

>   The SPDX license identifier is added in form of a comment.  The comment
>   style depends on the file type::
>
>      C source:	// SPDX-License-Identifier: <SPDX License Expression>
>      C header:	/* SPDX-License-Identifier: <SPDX License Expression> */
>      ASM:	/* SPDX-License-Identifier: <SPDX License Expression> */
>      scripts:	# SPDX-License-Identifier: <SPDX License Expression>
>      .rst:	.. SPDX-License-Identifier: <SPDX License Expression>
>      .dts{i}:	// SPDX-License-Identifier: <SPDX License Expression>

I think that was the correction needed, right?

Still have a question about the license comment in the "ethtooll.c". 

> /*   This program is free software; you can redistribute it and/or modify
>  *   it under the terms of the GNU General Public License as published by
>  *   the Free Software Foundation; version 2 of the License
>  *
>  *   This program is distributed in the hope that it will be useful,
>  *   but WITHOUT ANY WARRANTY; without even the implied warranty of
>  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  *   GNU General Public License for more details.
>  *
>  *   Copyright (C) 2009-2016 John Crispin <blogic@openwrt.org>
>  *   Copyright (C) 2009-2016 Felix Fietkau <nbd@openwrt.org>
>  *   Copyright (C) 2013-2016 Michael Lee <igvtee@gmail.com>
>  */

It puts 3 spaces between the * and the text, should it be corrected to 
only one space?

thanks, Carlos Melara.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

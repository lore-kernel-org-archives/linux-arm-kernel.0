Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8B5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:45:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737BA20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fAjYnTXc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nwzwTuSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737BA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fP00zA+ir8xGRWf2EZwld55XBrxnqHs33g+H+2EfqXk=; b=fAjYnTXckAsdqX
	R6yh5oQVVbKwBLf+/xWYq7aP/Jmt5HTD0VlJ+gTpbnYnxVl9alc6jC3NNQ6T0oVMOyMhBfdTU/P+L
	tFczPbDnB2zHnuFjto3I0hV4gtkih+OGJvDoPePbWlT+IsRbxMZmvx40Z8zilQpijJid2e0jWMTUX
	ls7XoAGle3dlrS+j7tzCN118Z1shLxBdTHKhCK5c/Zssv4dqxPzfnOPMosKR91r1CC5ITU4vzudip
	ZRviZIKCJTiXcXuqAI4r1f/p0kAlfoaX0ADUZMNAPzVE+KOCniTY5USt5xryvmN5YvBhr5m5df42N
	hqFQEs6Yb+q4+6K0mcig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSBK-0003EU-9O; Wed, 20 Feb 2019 13:45:02 +0000
Received: from mail-db5eur03on0617.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::617]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSBG-0003DV-AX
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 13:45:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOD5VjR6LGptJXHMiriHDibn8S7wClm29BQhTSGWwDI=;
 b=nwzwTuSrPYBL6fI8PnXjuaeZFfGrwuDnu1UrkxvrjGnPvS7I8HYNVjEhc4kVhxKcnMiFs3k+ZINKg9ZwwaQtfJ2B1GPXVJmz7qtFXn2Po4uncy3nzozTqn8NM3vJHviKZkz1OlsQL1pKSGB+u2D8JedY221PlT9MJSoMu4G/cZo=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB6102.eurprd04.prod.outlook.com (20.179.5.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 13:44:53 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 13:44:53 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>, Marco Felsch
 <m.felsch@pengutronix.de>
Subject: RE: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Topic: [PATCH] dt-bindings: imx: update scu resource id headfile
Thread-Index: AQHUyDGr6JcuNwk39kK74/kE/Vm176XnE3iAgAAGyxCAABmaAIAABhpAgADPbuCAAE95AIAAFTeQgAAWXoCAAAIvkIAAE7mAgAAZdrA=
Date: Wed, 20 Feb 2019 13:44:53 +0000
Message-ID: <AM6PR04MB42154C73B66A9F7E99597274807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1550566601-11497-1-git-send-email-Anson.Huang@nxp.com>
 <20190219125211.2pg2bqxner4klcb5@pengutronix.de>
 <DB3PR0402MB3916AF3AA0283DB22DF61E2FF57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190219144808.qqpaubjcsb4huoml@pengutronix.de>
 <DB3PR0402MB39160A56E168ED20410674D7F57C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB42152D05E62753E760741160807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
 <20190220081650.cu3yzausx55jefb6@pengutronix.de>
 <AM6PR04MB4215014B734F71D409D617A5807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
 <20190220105249.u2hcvk6ut3cycvqs@pengutronix.de>
 <AM6PR04MB4215D9FE015E9251425B0FFC807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
 <a55e0643bb2acd522145c74ec0e8b74a16b718f8.camel@pengutronix.de>
In-Reply-To: <a55e0643bb2acd522145c74ec0e8b74a16b718f8.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44767822-1e52-49d4-c373-08d697399806
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB6102; 
x-ms-traffictypediagnostic: AM6PR04MB6102:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI2MTAyOzIzOmtoZTQ2bHRyVHErODhNc2FZNFpWbGcvekNI?=
 =?utf-8?B?R0pvQjFZNWF4K3dCcmFkZDBUcWNYOCtLaEhTODhzcC9KTFRDSDROd2pVYk1s?=
 =?utf-8?B?MUxoZU4rcVFpMnlNQ3o2L0RVQVdEem9hbnNBVStxTFhwNHFkVWkyU2UvcnpL?=
 =?utf-8?B?RGlyOHhxempDU2gzTEZpcTB3cHl4UXA2RDZka1I0RGFBSGJNVDhMNUhMRmRL?=
 =?utf-8?B?MTQrRktPZGxuK2xibVUzZWNmVGxxdlkrSEtPZHlmc0xVbDZVK1U0VU1vNHJh?=
 =?utf-8?B?RXhDQncvalpvVHNRYzA1NCs0eThaRmt4MVhTOWZQVGg4VnNhaEdiMkM5Wkpw?=
 =?utf-8?B?aU92VmNMOGRwQlpxQUtIUjdDdENMdHZNMjlkL1J0ZTB4aE93R1hMRHFSbkdo?=
 =?utf-8?B?YlNURmkwVDBFOTloQUpQUmw2eHBXQTdKTmRKakthQnMxSk4wWXNjU3ZyZWIr?=
 =?utf-8?B?eTBYMFQzeTQ2WXBmT3ROTHBHU3ZNc3pMankrTkh5NUNJeGJqZmNXN1puSmQ1?=
 =?utf-8?B?SjVLSnhPMFhSWGRjSVlnUkh3NnoyTFplbEtqbHA3SHJPdytoMTAwSG04emU0?=
 =?utf-8?B?Q2Q5NDJuYjc0Y25lUmtNZUVQaERHa0dLekNsTWVMdXNMbUgzc1dGZ1ozYXRG?=
 =?utf-8?B?TE5Tdzd5YTZUemsxUFNuU0RRTVR3cVNJZUJnZFdwazJoS1AzaTBIMEJNY0FE?=
 =?utf-8?B?WXZkRXR5NVUxOFcvMkdSQlFkbzdQd1IrbjVHVU5zTm9sSi9BSFZCdUhPMjRa?=
 =?utf-8?B?VEJCek9jWWdvdlRBVFpvRHlTQ2IyL1ZhZndHT25Zd0t4blVoUWJZZWxaNWZK?=
 =?utf-8?B?R1FGM1FESE45Q1pFVVpqZzlFd1hzWC9LSlhpY2lwd3VHRGtpKzF1VDEzQzJT?=
 =?utf-8?B?RGZudHlTZU5qa0JRdVkzWDVwY0ZQemYySzhOZHV3ZEk3UHhUM2JZck43SDk2?=
 =?utf-8?B?OUlzKzgvejNzRHNBeWxtekJNT0NMR2dSVG9nTXRuTlFNM0xGblFpMkpDNkpD?=
 =?utf-8?B?dllUeW5vRlU3WlNBMUlxWlo4Vmh5ekJXRlRkaEtrQzFId3FUWlUrNkQwTXpz?=
 =?utf-8?B?T3M1OVBTZGhhYkp5NldwN2Jya1BaNFdqQ3Z6azY3Z25ybHpjVldFS2dBOHVS?=
 =?utf-8?B?cGdNeXFWajNkKzZTa3dBYkZlNEtyeEVJdFp0M2VvenVBSFlXcXB0MWsxemha?=
 =?utf-8?B?dUpzb2Q0WnlNWnloaG5XSkkrTXpXU3I0Y3k5cWx4ckNEbWVSemV5YzVFem9n?=
 =?utf-8?B?U2tWdkQ1ZXduSURhMFY4S2hQY0RXcy9yOGNIK203Q3NnczRlK3laNUw5U3Y0?=
 =?utf-8?B?bU1UOE5WcU1ZS1g3NFVjbnF5azIyYlROMkhVWUxyNG1WMGU4bXRyVHh4L3JK?=
 =?utf-8?B?SzdvdklrRDRjQnNHdEpiWEg1Z3ZuTEZPSWY3elFBZ2MrYTZRTXR4OFkzVG03?=
 =?utf-8?B?N3ZKM0MwbW5YdUlSdi82RU5qeXp6NHRNWWN0U1VITnN6UHA3SmVLL2gxazhh?=
 =?utf-8?B?QnRtc3ZVcHNGbyttdWU3cFBwV01ySUwxNTdySGNvRlpJbmswWGFYUTI4ZXU2?=
 =?utf-8?B?WEdGOWx0UTYxSUFybU5CQmNRaGRCQzJCVDhDUEhZTDUraXFyQjJtbGdXeldQ?=
 =?utf-8?B?aTVVSmtJN2hnTXBSSkRtcTFGMWNjdnhUNE5nZncvNnVZbnVCcVl0Sm4wSEpj?=
 =?utf-8?B?TXVFYlEwUVJYNGdkVlN0Tmp3YkxpR2RLd0VDc2JPTDJKeFR1TjR3bUh6TnEw?=
 =?utf-8?B?WGxiY3dGMUZXMDA5OUs1M0VxQ05pelBJZHY1T1AyQ082ajVuZnZXalBlMmFu?=
 =?utf-8?B?c1ZweU16RGNGM3MyVlFIYnQ0RHlVWjJzR2xYYktHWERVOVRPU1luZDZ2WUd5?=
 =?utf-8?Q?uDWoF54DJU4=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB61022847E3FAE04BB027ACB1807D0@AM6PR04MB6102.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(396003)(366004)(39860400002)(376002)(189003)(52314003)(199004)(51914003)(11346002)(68736007)(229853002)(446003)(14444005)(256004)(476003)(25786009)(106356001)(81166006)(81156014)(8936002)(486006)(7736002)(74316002)(8676002)(93886005)(6246003)(478600001)(305945005)(44832011)(105586002)(4326008)(53936002)(14454004)(33656002)(97736004)(86362001)(102836004)(9686003)(7416002)(7696005)(26005)(76176011)(6436002)(66066001)(15650500001)(55016002)(2906002)(99286004)(3846002)(6116002)(71200400001)(71190400001)(316002)(5660300002)(54906003)(110136005)(186003)(6506007)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB6102;
 H:AM6PR04MB4215.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pjOUPnnkk/a55dHLl638zn5OpH28ykqxDNdxgV8WZet4lLefyv4/tHov6NHw82ZTstjbrvEQXmFK4ikDmeEuq5JaBECj8L3evDpk5o45nOnD5A8cs2vnfgjyXpqOzT4ZNaAJMWrWiBt3xownnqilDA0EyYGqizDSE9ZvXhzMATHrbCyQK8eOKAwNNRZjqzGYiX3ZSdwQH1TDvWeFxxlRE0cLEFgmvbaPt7nn0EGGVj2y45ikSGRYXQXrsOox3YZat1Zh1jCCCWWQ2wNI54ja+vC1FRzDF+9vMRhNJegm71XmHF3gs8aA8GXVagXGpFBQ/mnubQZYeUTmUd5Lj1gZka0JQdfAL3iSvg9hPUt7Ezhlq+UkyQpbKls0Fia6UqorJFUWtphO36cQFXwSP/Drlj/uLjk5AsUjVQc57jo62gs=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44767822-1e52-49d4-c373-08d697399806
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 13:44:53.7953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_054458_648774_67CE4BAA 
X-CRM114-Status: GOOD (  32.83  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Anson Huang <anson.huang@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Lucas Stach [mailto:l.stach@pengutronix.de]
> Sent: Wednesday, February 20, 2019 8:11 PM
> 
> Am Mittwoch, den 20.02.2019, 11:21 +0000 schrieb Aisheng Dong:
> > Hi Marco,
> >
> > > From: Marco Felsch [mailto:m.felsch@pengutronix.de]
> > > Sent: Wednesday, February 20, 2019 6:53 PM
> > >
> > > Hi Aisheng,
> > >
> > > On 19-02-20 09:49, Aisheng Dong wrote:
> > > > > From: Marco Felsch [mailto:m.felsch@pengutronix.de]
> > > > > Sent: Wednesday, February 20, 2019 4:17 PM On 19-02-20 03:38,
> > > > > Aisheng Dong wrote:
> > > > > > [...]
> > > > > >
> > > > > > > > I don't like droping some ID's (e.g.
> > > > > > > > IMX_SC_R_DC_0_CAPTURE0) by mark them as unused or even
> > > > > > > > worse give them a other meaning. IMHO the scu-api should
> > > > > > > > be stable since day 1 and the ID's should only be
> > > > > extended.
> > > > > > > > Marking ID's as deprecated is much better than moving them
> around.
> > > > > > >
> > > > > > > I agree the SCU APIs should be stable since day 1 and the ID
> > > > > > > should ONLY be extended, but that is the best cases, the
> > > > > > > reality is, there are different SoCs/Revision, some
> > > > > > > revisions may remove the resources ID defined in pre-coded
> > > > > > > SCU firmware, like the
> > > > > > > IMX_SC_R_DC_0_CAPTURE0 etc., so SCU APIs removes them after
> > > > > > > real silicon arrived, now latest SCU firmware marks them as
> > > > > > > UNUSED, they could be replaced by some other new resources
> > > > > > > in later new SoC, I am NOT sure, but if it happens, this
> > > > > > > resource ID table should be updated anyway, leaving the
> > > > > > > out-of-date resource ID table there will have
> > > > > issues, since it is NOT sync with SCU firmware.
> > > > > > > So how to resolve such issue? We hope the SCU firmware
> > > > > > > should be stable since day 1, but the truth is NOT, could be
> > > > > > > still some updates but NOT very often. And I believe the
> > > > > > > updates will NOT break old
> > > > > kernel version.
> > > > >
> > > > > Hi Anson,
> > > > >
> > > > > Please don't mix the dt-bindings and the kernel related stuff.
> > > > > Unfortunately the bindings are within the kernel repo which in
> > > > > fact is great for us kernel developer but the bindings are also
> > > > > used in other projects such as barebox or other kernels (don't
> > > > > know the BSD guys). So you can't ensure that your change will
> > > > > break something. Please
> > > keep that in mind.
> > > > > IMHO solving that issue should be done by the scu firmware. I
> > > > > tought the scu is a cortex-m4 with a bunch of embedded flash and
> > > > > ram (I don't know that much about the scu since it is
> closed/black-boxed).
> > > > > Why do you don't use a translation table within the scu? As I
> > > > > said earlier I don't like the redefinition of ID's since they
> > > > > are now part of the
> > > dt-bindings.
> > > > > The bindings can store up to 32bit values which is a large
> > > > > number ;) IMHO wasting some ID's in favour of stability is a better
> solution.
> > > > >
> > > >
> > > > As far as I know, those remove resource IDs are pre-defined and
> > > > has never been used and won't be used anymore by SC firmware.
> > > > (Anson can double check it) So I think it's safe to remove them or
> > > > mark them as
> > > deprecated.
> > >
> > > I think marking them as deprecated by a commentar is better than
> > > redefining bits to be unused. As I said the bindings not only linux
> > > related they are used in other projects too.
> > >
> >
> > For other projects, the result is same because SC firmware does not
> > support those Resource IDs.
> >
> > > > Personally I may prefer to remove them as they never worked to
> > > > avoid confusing, especially at this early stage for mx8.
> > >
> > > So why they are there if they never worked? Wouldn't it a better
> > > approach to start with a basic and working ID file and extend this
> > > rather than adding id's because maybe the will work..
> >
> > Ideally yes, but may be hard in reality.
> >
> > SC firmware code usually is developed quite early before silicon comes.
> > But the real chip may changes, e.g. removed or added something.
> >
> > AFAIK those resource IDs removed have never worked in SC firmware, and
> > they're likely to come out of pre-silicon definition. But chip changes
> > later.
> >
> > > Sorry but this seems wrong to me too.
> > > I know the approach from driver development, adding a driver
> > > specific *_reg.h file and later figuring out that those bits won't
> > > work as aspected. As I said this will be driver and only linux
> > > related so we can change them as many times as we want. But in your
> > > case we are talking about dt-bindings and this approach won't work.
> >
> > I would agree with you if those resource IDs have worked before.
> > But they never worked.
> > Should we keep a thing never worked in device tree just because It
> > makes us look like keeping compatibility?
> >
> > If that, I'd rather removing them to avoid confusing in the future. Life is long,
> right?
> > I don't want people to bother with those unmeaning things anymore when
> > they look at it.
> 
> Removing things is totally fine if they have never worked. Re-using the now
> "free" IDs is what is problematic. Only ever use previously unused IDs when
> introducing new stuff into the SCU firmware. This is something you need to
> communicate quite clearly with the SCU firmware developers.
> 

Yes, that's right.
I will forward this request to them.
Thanks for the info.

Regards
Dong Aisheng

> Regards,
> Lucas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA11C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:33:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F7B208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E/MkA5a5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iTsNkOog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F7B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K2m/khVUjCKXnZp8uSDY1iJC1R86uAnTJZu3TBRsA+w=; b=E/MkA5a5Gd5O4d
	5I7a8zg/eQjV4NOcURL+Hpqy08YHjm0l4WSWq6hFjVDwlMCHM+qKUd0BxgcCJqBMHuulLQjXFsIw/
	JE+F1xmVwk7gNEMVh9Br30PP5ccKCxuqsISgMGgy7hymeiBaZ6j1WbGWNk2EWjJLYSOtydVA2B4LR
	qjGDPDkidKMwlb3iHiGayK6fLpvH//X3LnPLR2bSMsmfH0kyjcwyo2cw3On/824w/N88290TIjBks
	kDbZYBxlFGwAc2xISyLGaCc8QYxXWYMgCQ1V+Wmz1Ff0tUfUBSMrOwyTTRGSfvV7OBQznu/+r+3XW
	8mRyotU/Mq8twDV2TDsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsqd-0004S0-DI; Thu, 06 Dec 2018 12:33:43 +0000
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsja-0004tb-C6
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:27:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iVkP2f6JGrwWM+kfJnozMeoiXQayhK5Og85S15Ey0M=;
 b=iTsNkOog5UFDSUlvhdXGCjEb0PdRUcUwk8DpkrJzo8XHcP7sQzzTjCfd72JEZ4k7OC5ehjoIyHxcAu21PFqdRCYJWJHLQhUamX+Xwgtm7VWIpK5GBzDQyO1DUEtguTdoQojrlJVQ6b15VkgUY6s4E38C0d4EAef3scbeAOTJo28=
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com (10.168.11.142) by
 DB6PR0801MB2008.eurprd08.prod.outlook.com (10.168.86.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Thu, 6 Dec 2018 12:26:13 +0000
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07]) by DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07%7]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 12:26:13 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Suzuki Poulose <Suzuki.Poulose@arm.com>
Subject: Re: [PATCH V4 5/6] arm64: mm: introduce 52-bit userspace support
Thread-Topic: [PATCH V4 5/6] arm64: mm: introduce 52-bit userspace support
Thread-Index: AQHUjLl4fOQ7Xtd5CU6Lx4bVfQoqCKVwdYCAgAEuwYA=
Date: Thu, 6 Dec 2018 12:26:12 +0000
Message-ID: <20181206122603.GB17473@capper-debian.cambridge.arm.com>
References: <20181205164145.24568-1-steve.capper@arm.com>
 <20181205164145.24568-6-steve.capper@arm.com>
 <e1a9b147-d635-9f32-2f33-ccd689dba858@arm.com>
In-Reply-To: <e1a9b147-d635-9f32-2f33-ccd689dba858@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: DM5PR18CA0061.namprd18.prod.outlook.com
 (2603:10b6:3:22::23) To DB6PR0801MB1366.eurprd08.prod.outlook.com
 (2603:10a6:4:b::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR0801MB2008;
 6:eJbDt9wCbH9Csfw7usLhhpkVQhv2Oeph4v9mnlVSLniQRByTOEHfQ77aQvAC1lZjdiATt8jvPQfjVqu2qxWHMz8oZDaju6TQgExhT9Gf3rRyatfkXa/7LD/xK/4tLLPEBDvaoVRUlkgUKI26Zgktm7X2DnYNGhmv5LBvSINBTcxfe0A5AVaVf/Sr1w3O6EawJP8W8iB0E7heLRzvs3YLhdUS2jJCjepxg5ZCyQrgd6GiKHrx1lzqELVjQA7zwu/ssA+seg7cywVsBJPiW70acVZScRlewZmquIoVOi2x+i2zWzYukhyDOcgvpFn4NMKLgoy0D+fWNURo+EN2bgHuhKR8UrGJ3/mM0IDSchM9+6aPzBstJF0EbkkRANoCvxaqmXfDNRPdo3uSwXvrM74B6UVMKwKwEtek6NteNTInXYoza3lZwdbjsBuwMZygF49TYpPF6Dc0xBreMCow5aNXPg==;
 5:ec+4bmdNeDCScnVJT/wki6qBoZOkx8PkDZfPZS399//Ue1lpJdK3ea18pohkPXGlxU8qMwmUcdwDA2t+kxzawrTqpJyoN7yToN5bybV5xeT631GpFUTHXt0BY4zxiB1YR0GXLyyMnNhji/32ot7A71Ncqlf45l/6n+v9QYrCHhM=;
 7:yEH/halH0TMvw+MgQMMIeUDtMmTI75LzYzgEoF12XKyTFqCN+0ZSHbT+6MzDBs06LYidLSOjyInIQHBrSjwy5/vd+j2UMwvmmKSa0mb6z85JOWEiry2lNekePukOHfEfSzw56kVC3CoyfypUukIgTw==
x-ms-office365-filtering-correlation-id: 1d1c0962-83c7-454f-b51e-08d65b760294
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR0801MB2008; 
x-ms-traffictypediagnostic: DB6PR0801MB2008:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB20088F725B559C36C63E9C2381A90@DB6PR0801MB2008.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:DB6PR0801MB2008; BCL:0; PCL:0; RULEID:; SRVR:DB6PR0801MB2008; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(97736004)(33656002)(11346002)(486006)(44832011)(106356001)(105586002)(476003)(25786009)(14454004)(72206003)(478600001)(446003)(14444005)(8936002)(81166006)(8676002)(81156014)(4326008)(186003)(76176011)(54906003)(316002)(99286004)(6486002)(1076002)(86362001)(6116002)(3846002)(6636002)(52116002)(5660300001)(6862004)(6436002)(71200400001)(66066001)(305945005)(386003)(6506007)(53936002)(58126008)(6512007)(68736007)(26005)(102836004)(7736002)(229853002)(2906002)(6246003)(256004)(71190400001)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0801MB2008;
 H:DB6PR0801MB1366.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4w59DSgiNOmGpdrQhv+jAvJ/3mc8NximcXrli9cQpUdNISelZVEgXkLtXAUbC5TE4DE0ilVu/WCkuue/uxgxmvIGmgaazdmOeu2OgxSRXQeaSEHjOOgdCvYCmTrSgV2Y4ywKMCWhLTuAfedGqXxoicTfC9NE8YwILXXFcs4W8VjGF3+738QALDmHYDZwgKiQyEsoU+gRSd93kxs9cIxgTM68Fhawobu5mvuebSSL58UTvNFHG+1kJmr2TkohNfqkWaTLNDAgLdDVY35joPsFLOHhTea/+LKy+J3jqlM7PvMLObMnfsPeSBW0P/8yTFWGfyaJ706sE5T+L1coKi21g40QDq7Lr79fabAvd2VYnEo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <1F5D34DCB0DB9E419B0ABB0B65633BE6@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1c0962-83c7-454f-b51e-08d65b760294
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 12:26:12.9454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2008
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_042627_486956_9B4B6216 
X-CRM114-Status: GOOD (  12.68  )
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
Cc: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "jcm@redhat.com" <jcm@redhat.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>, nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 06:22:27PM +0000, Suzuki K Poulose wrote:
> Hi Steve,
> 
[...] 
> I think we may need a check for the secondary CPUs to make sure that they have
> the 52bit support once the boot CPU has decided to use the feature and fail the
> CPU bring up (just like we do for the granule support).
> 
> Suzuki

Hi Suzuki,
I have just written a patch to detect a mismatch between 52-bit VA that
is being tested now.

As 52-bit kernel VA support is coming in future, the patch checks for a
mismatch during the secondary boot path and, if one is found, prevents
the secondary from booting (and displays an error message to the user).

Cheers,
-- 
Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

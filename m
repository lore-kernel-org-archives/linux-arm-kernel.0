Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356F0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:04:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F2E2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P0nSzpiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F2E2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hotmail.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9oV0qB2auUER/i0ZA9IPD4GI/rGgPh9rhMizVrCuSCw=; b=P0nSzpiZzkfXqP
	mOQKc+j/Xh/Tj2lanM1uKdmOa0uFck5I1RjcPJXnAds3hJR/TeKh1w9AUwYNvSbZQEOeMxa/qo08/
	rF8tnr7jMuc8g8kubAYTNQw6eUsG9DrHEHt5t7hNfGO+uviXVW4T2OnwtiCAWE0SdfQz46UKZXua9
	bY99d6N2e2LwDgGVFu8MjKPhfVtLhDx7c4v71fIiCJmlINxp9jDEPmH5cTNmRjHxNP8a8Ygy3Tg0/
	pEWdDNVM0o4wZP7EdvKb5m8lI6b7RLfuUttJ1H0Upf91D5H3L+RJpYW8oBX1U1u1YV7OxNPgFiesh
	tVNH5ph/4DLM/XoUmlRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwoxI-0005Do-CN; Thu, 21 Feb 2019 14:04:04 +0000
Received: from mail-ve1eur02olkn0811.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::811]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwoxF-0005Ch-H5
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 14:04:03 +0000
Received: from VE1EUR02FT043.eop-EUR02.prod.protection.outlook.com
 (10.152.12.55) by VE1EUR02HT243.eop-EUR02.prod.protection.outlook.com
 (10.152.13.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Thu, 21 Feb
 2019 14:03:56 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (10.152.12.53) by
 VE1EUR02FT043.mail.protection.outlook.com (10.152.13.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 21 Feb 2019 14:03:56 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105%5]) with mapi id 15.20.1643.016; Thu, 21 Feb 2019
 14:03:56 +0000
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH] ARM: enable irq in translation/section permission
 fault handlers
Thread-Topic: [RFC PATCH] ARM: enable irq in translation/section permission
 fault handlers
Thread-Index: AQHUxWnWUPB2na06qUiuVihk2ZlxqKXiTBcAgAZAHICAATa1gIAAP62ngAAKXwCAAETHAA==
Date: Thu, 21 Feb 2019 14:03:55 +0000
Message-ID: <VI1PR0702MB3840C12A5C8CCBE785CBF4B7E47E0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
References: <20190215200533.ypfrdekg7j4ucu6a@linutronix.de>
 <20190216113338.irr5j4ukhpwngval@shell.armlinux.org.uk>
 <20190220110039.2p2iglhqlf6xapsb@linutronix.de>
 <f05d2cae-5664-6cc7-51c8-933d6d1403ec@hotmail.de>
 <VI1PR0702MB3840118FE9014CB1E9801F83E47E0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20190221095744.xtp25ock7o4ydl6g@linutronix.de>
In-Reply-To: <20190221095744.xtp25ock7o4ydl6g@linutronix.de>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0202CA0061.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::38) To VI1PR0702MB3840.eurprd07.prod.outlook.com
 (2603:10a6:803:f::33)
x-incomingtopheadermarker: OriginalChecksum:1F69A3C7C25F3A073F807611AE1DA8E537F2A15DAD7576A81DC6E7993C6CB6EF;
 UpperCasedChecksum:F5F3F8ADDB1762ABC195EB4180C9F478F6DC5C81019C6CF64440AF3099B352BB;
 SizeAsReceived:9031; Count:63
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [pUC7U1yh0S2DGSIE/yDHM4N7JYhy6drm]
x-microsoft-original-message-id: <5b97f56c-d6de-ec19-d002-dc4c5efc42a1@hotmail.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 63
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
 SRVR:VE1EUR02HT243; 
x-ms-traffictypediagnostic: VE1EUR02HT243:
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0; RULEID:(4566010)(82015058);
 SRVR:VE1EUR02HT243; BCL:0; PCL:0; RULEID:; SRVR:VE1EUR02HT243; 
x-microsoft-antispam-message-info: dyAFmze8M9xBBSL686LMCG35AjJ1s8xQUo/+i0auh9couuwjmVwahmxU910LXSRz
Content-ID: <E5C0323017B87B469CECF6F0485C9090@eurprd07.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: d55a59f6-4ffd-4cbe-b66b-08d698056adc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 14:03:55.0759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT243
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_060401_565834_EE2BB36C 
X-CRM114-Status: GOOD (  14.26  )
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
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "yadi.hu@windriver.com" <yadi.hu@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/21/19 10:57 AM, Sebastian Andrzej Siewior wrote:
> On 2019-02-21 09:31:53 [+0000], Bernd Edlinger wrote:
>>
>> What exactly is the reason why we should not apply this patch in the non-RT kernel as well:
>>
>> https://marc.info/?l=linux-rt-users&m=154997565610392&w=2
> 
> I'm not sure that this is the right thing to do. I think you should
> invoke harden_branch_predictor() before the interrupts are enabled so it
> is invoked on the same CPU that triggered the exception.
> 

When is there any secret information in the branch predictor cache ?

When do_DataAbort calls do_translation_fault?

Or after do_page_fault has executed, and is about to raise a sig-fault?

Doesn't do_page_fault have access to information that an attacker
would like to know?


Bernd.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

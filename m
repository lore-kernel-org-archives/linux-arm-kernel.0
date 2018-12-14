Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D58CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:00:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BF9206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q8eLWy2V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="BI8Tr9Pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BF9206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i4YIZ1UHO4gtB5MkSsSWGgSaD+T5EQquJv/rxuNT8dQ=; b=Q8eLWy2VWosalD
	jx9bBF8EGtHpN74CgFcWDeW8rdl6tyXTsPKkPiVqnTQmM6BJPjV6gpe/IXmZVKHnJ3PxsQNIDWqxC
	nLkorElYJQd//i8IXrHC46Hi5L5OTVG54Bh/7jkWMEqhJpVh17WU65cdg5lBqCIFwOt1dsv28CXcs
	D4zzyAmV+CQskB3FaolhZeZpKcY5gWFglt3zE9Nmq4QPaeyr1MnYYC1OcDHhxFPBriAJUfginK3eG
	4JEzND01ejXPSwumKXgp4s5VW+VR5XeS7uppGEBxh/AGZEvxt0H/g1ocscFDuKt36CpEjBUKjwPX6
	hgILeOvK7lpmZqbd7FvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXshH-0000He-Bm; Fri, 14 Dec 2018 19:00:27 +0000
Received: from mail-ve1eur02on061c.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::61c]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXshC-00008i-SW
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 19:00:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQBvrOmLwQ8tU98PWrTZcpi5mx85LRU5bZ/jSg0eUDA=;
 b=BI8Tr9PzxEcRhz8Q6pbCEM5eY8nGsxq3eBbsJrtp+0FBK5Y5/va7CeOamtl1nU8dzbqN8po/IXVGM5cw6czW/znJbSL1UpKJtFpg5y8BQwMjiCquV8aLkEEZpvu8+uYmt2eSL1nH2f49+ayk6mZAHgUbJk8dksbcSCJnfLaP/x0=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB0606.eurprd08.prod.outlook.com (10.163.169.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 19:00:08 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::b9e5:694c:a7d1:d37b]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::b9e5:694c:a7d1:d37b%4]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 19:00:07 +0000
From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To: Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 0/3] arm64/sve: UAPI: Disentangle ptrace.h from
 sigcontext.h
Thread-Topic: [PATCH 0/3] arm64/sve: UAPI: Disentangle ptrace.h from
 sigcontext.h
Thread-Index: AQHUkYd5TQtknm9R4kqjkh+b7I8GJaV+jmIAgAADSQCAAAm4gA==
Date: Fri, 14 Dec 2018 19:00:07 +0000
Message-ID: <5e96f169-d77d-63d0-11ba-f59f572b0219@arm.com>
References: <1544556407-19897-1-git-send-email-Dave.Martin@arm.com>
 <2abbbd29-cc87-a0ad-80b7-e2a1d039235e@arm.com>
 <20181214182518.GH3505@e103592.cambridge.arm.com>
In-Reply-To: <20181214182518.GH3505@e103592.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [217.140.106.52]
x-clientproxiedby: CWLP265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5d::29) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR08MB0606;
 6:gP4PtH4pacCHusHnwwghoCHw2SIT6usGNNulXLQSZrUtLz91K3Ye6g9Ih6rI2Ang9m1cG6+8vuKssHKcyX7uDelhMQSG/PT3Z+cV9AZFHf9Gl7x1XA3gVsv2fi50or/neZ82DjLi1PaD6NuS6l67Kic0OAemZesHZiQRmpVQjTtgztt/iEDPlMKujVq066mN26XCIhK7igMDwtOMe7ufke48PeyiuE0qyEuhMJaPwbdS9gjshevdvJnO/EYdBJfLXL9eUQ9FNcDFG2f8HO1Wb/XbBqFgAQdPxvyRXZKNgdfrNRfxh1viYbt4pO9rA0DC7rrYPsajDToklzZ9wiywv1s8NZjgp7jOGkEZZEGKcuR+kpdfh+WhnQwHsbzOswMOn0Elz/Jr7oUxIwaFEzK5hnZixHNKN4gdo94CueyVQEIkpLV3hZtAK+142fj9UUZtoTLc4MzK+q1ADzM7ak/mSQ==;
 5:RHCClX3VvKx6gNwng5tfMqplp2FknXhf0t2VnCfTfJ0Hn1u1oeLtiiY86HdY6bRWgyFFNGfJ2Xnmi9eoCiwe+3+p5SJsAo9stfPgx4/ICadVxug0+JhM2sNvsvMRPj71SpRkv0uMCaO//GwN3fjuknJmFN/hRQPhGiaIQs17VV8=;
 7:PVHLqcWzEzv6qhs+NU6ADnb8iR3pu04gb7UqoN2j9ii9PjGntti1kSsP9r2EIp8tHJQaIBTZB6osptizSAtfPaDJ6H/CmWCMw7EULzdxffrAc1eVRXkhWzyi3cUs+mBkNY9I0yfa8LpdycmTMRBZ6g==
x-ms-office365-filtering-correlation-id: d2ef2e46-4731-4c48-d4b1-08d661f65d3f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR08MB0606; 
x-ms-traffictypediagnostic: VI1PR08MB0606:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB06060E6A41FAAAB60ADEC302EDA10@VI1PR08MB0606.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231475)(944501520)(4982022)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR08MB0606; BCL:0; PCL:0; RULEID:; SRVR:VI1PR08MB0606; 
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(189003)(199004)(8936002)(44832011)(65806001)(6512007)(305945005)(36756003)(65956001)(99286004)(316002)(3846002)(476003)(6116002)(6246003)(37006003)(58126008)(54906003)(97736004)(6862004)(81156014)(81166006)(7736002)(64126003)(66066001)(486006)(8676002)(25786009)(72206003)(2906002)(6306002)(106356001)(68736007)(31686004)(14454004)(53936002)(2616005)(6636002)(6436002)(102836004)(229853002)(446003)(5660300001)(26005)(11346002)(386003)(256004)(478600001)(966005)(6506007)(53546011)(71190400001)(6486002)(31696002)(65826007)(186003)(4326008)(105586002)(86362001)(71200400001)(76176011)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR08MB0606;
 H:VI1PR08MB4223.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JEE00f9qaOTSViNfledXuqjNWjH6zGMSi+U6DjFzWL4CukGOoVwVLzrVALRqf25XL4xjx+hUw008f2zCLRESNhN58NMHqmRiYKCk1HAXwuJvETbs1+GqqmXbM2K/rSwsn8As7whao92rRMv5hwib/5wM/Z7foYzkfJQmkV3BUsqAl7SURWCh+apl78LkdC4dj0AJSKNrUyPrZ8fy9gbRlMHpHpde9Z5YwaHkQ9Z9sJuAYlKMZeECoTeMTPmR26faWzhQu0nEAajpJZxGMsqnVxYxWePNt1AB0ReM8RAN+e2NlgkTtl8HsTrTnA/ZUpe0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <F6414EBAE69F4943B17087E30D14DFF8@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ef2e46-4731-4c48-d4b1-08d661f65d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 19:00:07.8760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0606
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_110022_931154_B6845192 
X-CRM114-Status: GOOD (  18.18  )
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
Cc: nd <nd@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Alan Hayward <Alan.Hayward@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14/12/2018 18:25, Dave Martin wrote:
> On Fri, Dec 14, 2018 at 06:13:33PM +0000, Szabolcs Nagy wrote:
>> On 11/12/2018 19:26, Dave Martin wrote:
>>> This patch refactors the UAPI header definitions for the Arm SVE
>>> extension to avoid multiple-definition problems when userspace mixes its
>>> own sigcontext.h definitions with the kernel's ptrace.h (which is
>>> apparently routine).
>>>
>>> A common backend header is created to hold common definitions, suitably
>>> namespaced, and with an appropriate header guard.
>>>
>>> See the commit message in patch 3 for further explanation of why this
>>> is needed.
>>>
>>> Because of the non-trivial header guard in the new sve_context.h, patch
>>> 1 adds support to headers_install.sh to munge #if defined(_UAPI_FOO) in
>>> a similar way to the current handling of #ifndef _UAPI_FOO.
>>>
>>
>> thanks for doing this.
>>
>> the patches fix the gdb build issue on musl libc with an
>> additional gdb patch:
>> https://sourceware.org/ml/gdb-patches/2018-12/msg00152.html
>> (in userspace i'd expect users relying on signal.h providing
>> whatever is in asm/sigcontext.h.)
>>
>> i think sve_context.h could be made to work with direct include,
>> even if that's not useful because there is no public api there.
>> (and then you dont need the first patch)
> 
> My general view is that if you want the sigframe types userspace should
> usually include <ucontext.h> and refer to mcontext_t.
> 

ucontext.h does not expose the asm/sigcontext.h types in glibc,
but it is compatible with the inclusion of asm/sigcontext.h
(or signal.h).

in musl ucontext.h includes signal.h and signal.h provides
the asm/sigcontext.h api with abi compatible definitions.

> Because the prototype for sa_sigaction() specifies a void * for the
> ucontext argument, I've generally assumed that <signal.h> is not
> sufficient to get ucontext_t (or mcontext_t) (but maybe I'm too paranoid
> there).

http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/signal.h.html

"The <signal.h> header shall define the ucontext_t type as a structure
 that shall include at least the following members:
...
 mcontext_t  uc_mcontext A machine-specific representation of the saved
             context."

so signal.h must define ucontext_t but mcontext_t can be opaque.
(it is opaque with posix conform feature tests to avoid
namespace pollution, but with _GNU_SOURCE defined all
asm/sigcontext.h apis are there and mcontext_t matches
struct sigcontext)

> 
> Non-POSIX-flavoured software might include <asm/sigcontext.h> directly.
> In glibc/musl libc will that conflict with <signal.h>, or can the two
> coexist?

if you compile e.g in standard conform mode then
i think signal.h and asm/sigcontext.h are compatible.

> 
> Cheers
> ---Dave
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

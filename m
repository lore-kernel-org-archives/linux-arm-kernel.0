Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5419BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:42:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2351B20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mE5wU72x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HneAyCoA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dePS3I+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2351B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iZOwL3SF2zGTG9wT9XiuOrTLRnccJgLTBCmc6vQMEqE=; b=mE5wU72xw4U8zx
	mrwPZoNCvYvAEOYc6XqeuKK/nBxqEYbJu/NxjdmDbbNjLi5BLla58wDTETnTxxoXnM267YS/8cIKy
	m0YybzGvOKS2hvPMqNDkvfNdQsIPsHx3P1AHkKOPP5KiQ7jGX+NnoUr/CY7OBNJGqfmuRTH4svm8L
	d9G9pxHjOwrzuV1ABYZ9uV2DQFz1H8nUh+Jvc24PQB6QcKa+M2FaSrINp7u1ZuxMGO606PY+uQ4GM
	AnQtV3+ioLI+n1dc8njqHEhoNX6qJaKzyhvJhlovvBVSEcX9GKELSVxxCu00/O5pA8jDJHoYfSFev
	rS9isVjKmBa4gyL5uphw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUszN-0001b7-Od; Thu, 06 Dec 2018 12:42:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsyn-0000si-L9
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 12:42:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:
 From:Sender:Reply-To:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eLg8kHC8pu0JbSNbGhbTDcLL6pB3H7eWS31g2c4eijU=; b=HneAyCoASrMszCLZaw55yRgGzc
 zce7SO6j3lo5aYP4Fw0AdaK1SlzFKwQwQBTP1EJ5ho803eyumfitGkDi7swBZEOYJmeogE7Xt/by7
 1Yyo69jr7RN7tIURfSD8FvzDiElZ4hERuRHKuN4Hys7Sly3jarYgWgSEG5wCWgWYEWJqav4H5IWRz
 SNsiHtydxSXnf6I/sV/dtY47E83PjpfAygxhlGjaudRgoBHkYFi7ZRnCK1yOVW0GlEDD2dLyicDnJ
 gtuQ901YQSy6xsGM7ZUrtEYNSQMRroepBzMDlAimWDOYDyCaW3zK6eir5ATyHJZKvKr0eO3UhRxqH
 PulDFGag==;
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsl8-0003Fe-PR
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:28:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLg8kHC8pu0JbSNbGhbTDcLL6pB3H7eWS31g2c4eijU=;
 b=dePS3I+Ew+wC8fRTGKpFJr/Y6EaU2E21VQq7Lz2CR41YdBcgUfFVWDrwFSlmCE47cmPwGb0ul1bBK5taPtG8RRLSE1ks7bF0CH3HNkEsINqSGT15wqQOEL5wNr/8pCkypI9Wf97/YQB/cCVArAOToxkLww4+t9IbFA0zTyuyQzs=
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com (10.168.11.142) by
 DB6PR0801MB2008.eurprd08.prod.outlook.com (10.168.86.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Thu, 6 Dec 2018 12:27:49 +0000
Received: from DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07]) by DB6PR0801MB1366.eurprd08.prod.outlook.com
 ([fe80::8d10:1b0d:4dc1:cf07%7]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 12:27:49 +0000
From: Steve Capper <Steve.Capper@arm.com>
To: Catalin Marinas <Catalin.Marinas@arm.com>
Subject: Re: [PATCH V4 4/6] arm64: mm: Offset TTBR1 to allow 52-bit
 PTRS_PER_PGD
Thread-Topic: [PATCH V4 4/6] arm64: mm: Offset TTBR1 to allow 52-bit
 PTRS_PER_PGD
Thread-Index: AQHUjLl2gn1uy2aaP0SaC5YRGmOjOKVxmj0AgAAKcoA=
Date: Thu, 6 Dec 2018 12:27:49 +0000
Message-ID: <20181206122733.GA17572@capper-debian.cambridge.arm.com>
References: <20181205164145.24568-1-steve.capper@arm.com>
 <20181205164145.24568-5-steve.capper@arm.com>
 <20181206115011.GC54495@arrakis.emea.arm.com>
In-Reply-To: <20181206115011.GC54495@arrakis.emea.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [217.140.106.32]
x-clientproxiedby: DM5PR18CA0058.namprd18.prod.outlook.com
 (2603:10b6:3:22::20) To DB6PR0801MB1366.eurprd08.prod.outlook.com
 (2603:10a6:4:b::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB6PR0801MB2008;
 6:VXBNzSW5ySFR0ustSW3S1bMXr49RN+DM+zmPmmaiIk/K8ZcCwH5XgVtBB9zZI0kSlejJPYZuoQMOXI9m95CJLhBC71HhBMQfkWiHSqgCP4M99gI6SRJN+qckKHPMcofqVGWihaFxBfE3+hjxpLO0DYUCNiKgoVktv6/8Y3VzAAYrW9NfVxArRcvQ5fxf7Z/a/aRqD2JiKEVHYVU+oNSVpSC3ZGNI68y9wuPPFMhZzXHqR23Oh2wYBNtJGtV19RTDJgF0NYvctiY9sqHqOmB7MC5PqbfOQhpIqSM+dUnnkbkpAjSruMVtniBbexyqQsQpdyvI0XslEmhaAoD0YGCevLAlX//iZuE3oCcLpMu4i6R2wJcZo5loROrbnuDCZhDYQlv6VKaEnzk/ANf9d4qnp7WhqdDasvXSgJv7JCWRXYkIBrAbZ3dQeHfgABsbgKCrQ06cuJi35UM3ymByGQky8A==;
 5:dEO1FIenNd4FA14XEVk9v3OVkOgOt1rvYOVD8od7b9CCIlRYrxL/B5d9pf57dsL27UkcuWt7/PwEjC+A1xjvvy7S2418c7dnoSThOJ1bQnrSuOfVs0QrUoNXZCqcGuhoB8A+miz66XGUk0c7H4Sa/STHuYmZ7rNGkH/hmUzQ0Wg=;
 7:G4f/IvOpv8PrtwnGTQB6fZymnhKLlevba0cU1F3jLtMpXMnHEsQKLbm7p1omCJJD3s38Ezv83pUDKbvV1WIIdhoAzer9FiKw9aNesw+UEyOjx+H1JDXmhlJL194qDiuiGsmNyPRtcnI7AA6+wiOsPw==
x-ms-office365-filtering-correlation-id: df475cfd-1fe1-4ccb-4459-08d65b763c00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR0801MB2008; 
x-ms-traffictypediagnostic: DB6PR0801MB2008:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB200883965325D8EA17B5D13181A90@DB6PR0801MB2008.eurprd08.prod.outlook.com>
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
x-microsoft-antispam-message-info: a8J/F5qK4loZOWV1GCnn1aIshYSyUbJwiGQNB/SQRM0WPaLPUwSXQ1HyxCQUQrd7LN8GYj6JFRHzje68Pt9uW96vtAqbe8eD/TNkM7XIVxgvmDg1zp6Z7yv11tP0gPfkHWsLx+JKN4jWDRWBHMDHAlQoWpxqWHUn0o+Z8kpmw+9vXSoOrI5g1jKU0cFG134GCC4fn4h4SbRS6RhWXQWKenawtf8E2jwev5Bf08jFDsvoBl9u5on+pYtTsQlOiSar4i2YUeUDrLsZL4Go/sCErp5vQtgcU45kRfMSinsm22EfQYIDQrUhjgje8aasKk/MxW3MixQEu3kDmraDKh0u6XfmdzLCW7zGFE8hIVa1KPU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <4025061A11372347AB0A498748503E9C@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df475cfd-1fe1-4ccb-4459-08d65b763c00
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 12:27:49.3735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2008
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_122802_819997_E8F36FB1 
X-CRM114-Status: GOOD (  15.61  )
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
 "linux-mm@kvack.org" <linux-mm@kvack.org>, nd <nd@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 11:50:12AM +0000, Catalin Marinas wrote:
> On Wed, Dec 05, 2018 at 04:41:43PM +0000, Steve Capper wrote:
> > diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
> > index 4128bec033f6..cd361dd16b12 100644
> > --- a/arch/arm64/include/asm/asm-uaccess.h
> > +++ b/arch/arm64/include/asm/asm-uaccess.h
> > @@ -14,11 +14,13 @@
> >  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
> >  	.macro	__uaccess_ttbr0_disable, tmp1
> >  	mrs	\tmp1, ttbr1_el1			// swapper_pg_dir
> > +	restore_ttbr1 \tmp1
> >  	bic	\tmp1, \tmp1, #TTBR_ASID_MASK
> >  	sub	\tmp1, \tmp1, #RESERVED_TTBR0_SIZE	// reserved_ttbr0 just before swapper_pg_dir
> >  	msr	ttbr0_el1, \tmp1			// set reserved TTBR0_EL1
> >  	isb
> >  	add	\tmp1, \tmp1, #RESERVED_TTBR0_SIZE
> > +	offset_ttbr1 \tmp1
> >  	msr	ttbr1_el1, \tmp1		// set reserved ASID
> >  	isb
> >  	.endm
> > @@ -27,8 +29,10 @@
> >  	get_thread_info \tmp1
> >  	ldr	\tmp1, [\tmp1, #TSK_TI_TTBR0]	// load saved TTBR0_EL1
> >  	mrs	\tmp2, ttbr1_el1
> > +	restore_ttbr1 \tmp2
> >  	extr    \tmp2, \tmp2, \tmp1, #48
> >  	ror     \tmp2, \tmp2, #16
> > +	offset_ttbr1 \tmp2
> >  	msr	ttbr1_el1, \tmp2		// set the active ASID
> >  	isb
> >  	msr	ttbr0_el1, \tmp1		// set the non-PAN TTBR0_EL1
> 
> The patch looks alright but I think we can simplify it further if we add:
> 
> 	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
> 
> to the 52-bit Kconfig entry.

Ahh, thank you okay, I didn't make the connection that Privileged access
never was a mandatory feature in ARMv8.1.

Cheers,
-- 
Steve

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

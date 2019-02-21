Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E110C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:45:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB232084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X5p6z0CP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="asrrWqxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB232084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sIt6zr7damgsnxExpd91nBchRjQkn+M2i3jkLB2GBPo=; b=X5p6z0CPodH/Au
	EuJCDiY7gy17tDzlpNoyFj/cuFkEo6lRxld5BFRP5Iv7YRBDFHu60EygCLFBLuOyWjHeUeNbugINR
	ZXodGj4TaHq5iJCZibhA9q4ndg2RuU7MvNo3vxmDcDZA2OzUtcisa+GkmMs6SXkIi8eKGxJ9YMDwH
	JWQTSCOHyBPRoWWM33CbC+HwpPTHpHUf2Up+jGmrvsPA/1K1V8nOF7YajhVE23/Drs9J4VpiGTT9G
	eMO8XywL3m5ICOHZEfzp+7hiqmvcbcFIOjyZVwmrQ2/EJFVHroqzdFRzVV2W1gRvXBaeTnXO0WyMK
	SsVaj9VndUdHndqPEW3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwtLY-0002LN-Sl; Thu, 21 Feb 2019 18:45:24 +0000
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwtLK-0001Kp-OO
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:45:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUgnvW4D3Q59fdY5uF+bMrvKS90uxbg7lor04J3kQQk=;
 b=asrrWqxJ4RIzh2tVwbI3cTCKPSS2pZBbh8F80PccZBU0fn98T/lT7uuA2I4MaUN4LnnkIBrsx7Jg/2hYtzsonjOREiInCp7Opz07OC66hgdBxTArDOYxoIQoT4zvCTAxazHdLgijMd7vsDDZpXNATXSBeZQ3ru8GGjV9V/8ztIM=
Received: from VI1PR0801MB1599.eurprd08.prod.outlook.com (10.167.211.15) by
 VI1PR0801MB1952.eurprd08.prod.outlook.com (10.173.74.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.24; Thu, 21 Feb 2019 18:45:08 +0000
Received: from VI1PR0801MB1599.eurprd08.prod.outlook.com
 ([fe80::e11e:abd4:7d4:d8aa]) by VI1PR0801MB1599.eurprd08.prod.outlook.com
 ([fe80::e11e:abd4:7d4:d8aa%3]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:45:08 +0000
From: Dave P Martin <Dave.Martin@arm.com>
To: Andrew Murray <Andrew.Murray@arm.com>
Subject: Re: [PATCH v2 3/6] arm64: HWCAP: encapsulate elf_hwcap
Thread-Topic: [PATCH v2 3/6] arm64: HWCAP: encapsulate elf_hwcap
Thread-Index: AQHUyd/uI9AJ5reSRkq2sqhnffCa3KXql2AA
Date: Thu, 21 Feb 2019 18:45:08 +0000
Message-ID: <20190221184506.GP16031@e103592.cambridge.arm.com>
References: <1550751657-30252-1-git-send-email-andrew.murray@arm.com>
 <1550751657-30252-4-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1550751657-30252-4-git-send-email-andrew.murray@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.23 (2014-03-12)
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LNXP123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::35) To VI1PR0801MB1599.eurprd08.prod.outlook.com
 (2603:10a6:800:19::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Martin@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af43f357-f58a-4ee6-c044-08d6982cb3db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0801MB1952; 
x-ms-traffictypediagnostic: VI1PR0801MB1952:
x-microsoft-exchange-diagnostics: 1; VI1PR0801MB1952;
 20:y0iZjb/0qSvrK6VRKExRL1lXKXJYHRhLvlAbdeLMso3E6QvLd5d86N1ikF8WOf7qF7FCI6OsVGbJRQu3uCJsuOzkmEQVFbVF0kGK3XhM1t/5TTA4SxoKS+Ar3emMnwxzUlXX5biq0mKichaNBgpHAF7BGeQJkfDd6W6m9wSQRQ0=
x-microsoft-antispam-prvs: <VI1PR0801MB19524AC91C958AB13EBA15D3FE7E0@VI1PR0801MB1952.eurprd08.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(40434004)(189003)(478600001)(99286004)(102836004)(52116002)(72206003)(68736007)(486006)(6636002)(8936002)(11346002)(446003)(316002)(6512007)(58126008)(54906003)(229853002)(476003)(76176011)(71190400001)(386003)(6506007)(1076003)(6486002)(5024004)(2906002)(5660300002)(6436002)(53936002)(256004)(14444005)(86362001)(71200400001)(66066001)(105586002)(6246003)(33656002)(25786009)(26005)(6862004)(81166006)(186003)(106356001)(3846002)(81156014)(305945005)(14454004)(6116002)(8676002)(4326008)(97736004)(7736002)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0801MB1952;
 H:VI1PR0801MB1599.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TvbllEcsE1Fn4nR819F00lhHiT70rG62lMdsrJMYtrQGlSsowV5VvIOkrL4dBExe+gHmxfozmeSbgclkWPNtEexUiFudaK7NO3MHetwmw0CNCvYtuHkfCPUyu8U6vENYAKA7lhGy/OgFLY/5fdPSW69SKZIoqhGu8uamGc5FQ0qECoVGQcR8vgRLq5fIgqWdGgsqJFW8uDoLV+QjuniR9RpCHIIuDVaE7RysLKrFh5EOQbxdMDvTGjOCq+egzA00N3W88u54mRT1y+MSFCmJPeM/xQeth5VxmDlsSu2Kk+EiaReXnp7tUbMbjUW13LFfVDqgsyhIT0EnCIWGBryGmCayfFmqyqutVGA1fxqhi/tHK9/1IqM2Pha9xVyQYYGuGIlQL9DgcO3CUyd8Z+VfuOB7jU10KETJeCv6dSwU1XQ=
Content-ID: <B8FBF776DD7B5A4BBFD0B79307B2644C@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af43f357-f58a-4ee6-c044-08d6982cb3db
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:45:08.0978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1952
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_104510_796782_1377F29C 
X-CRM114-Status: GOOD (  15.88  )
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
Cc: Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 12:20:54PM +0000, Andrew Murray wrote:
> The introduction of AT_HWCAP2 introduced accessors which ensure that
> hwcap features are set and tested appropriately.
>
> Let's now mandate access to elf_hwcap via these accessors by making
> elf_hwcap static within cpufeature.c.

Since elf_hwcap now survives and retains a compatible encoding for
HWCAP_foo, I'm wondering whether it would be simpler to drop this patch.

Although this will help push people to use the new helpers, the need to
do that seems reduced now.

People falling off the end of the hwcaps will discover that there is no
HWCAP_foo for the feature they want, only HWCAP2_foo (but no elf_hwcap2
to look for it in), or KERNEL_HWCAP_foo (which should get them
thinking).

What do you think?

[...]

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 6a477a3..d57a179 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -35,8 +35,7 @@
>  #include <asm/traps.h>
>  #include <asm/virt.h>
>
> -unsigned long elf_hwcap __read_mostly;
> -EXPORT_SYMBOL_GPL(elf_hwcap);
> +static unsigned long elf_hwcap __read_mostly;
>
>  #ifdef CONFIG_COMPAT
>  #define COMPAT_ELF_HWCAP_DEFAULT\
> @@ -1909,6 +1908,30 @@ bool this_cpu_has_cap(unsigned int n)
>  return false;
>  }
>
> +void cpu_set_feature(unsigned int num)
> +{
> +WARN_ON(num >= MAX_CPU_FEATURES);
> +elf_hwcap |= BIT(num);
> +}
> +EXPORT_SYMBOL_GPL(cpu_set_feature);
> +
> +bool cpu_have_feature(unsigned int num)
> +{
> +WARN_ON(num >= MAX_CPU_FEATURES);
> +return elf_hwcap & BIT(num);
> +}
> +EXPORT_SYMBOL_GPL(cpu_have_feature);
> +
> +unsigned long cpu_get_elf_hwcap(void)
> +{
> +return lower_32_bits(elf_hwcap);
> +}
> +
> +unsigned long cpu_get_elf_hwcap2(void)
> +{
> +return upper_32_bits(elf_hwcap);
> +}
> +

Similarly, pushing all this out of line to enable elf_hwcap to be hidden
may be more effort than it is really worth (?)

Cheers
---Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

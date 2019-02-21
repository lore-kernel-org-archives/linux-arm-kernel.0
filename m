Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224F6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:45:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32CB2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ky28lQQ/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="QPAdwXc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32CB2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jW+SX8y68AKipFHoSF+GBs3COwB199R1PiA01rQdcz8=; b=ky28lQQ/F1b5Xo
	GG4+MYBTD2yE7vFSDIJEWnDx645QzYFBJbJAKwOyorf5R5XwG1im1ED94NIubxJmZiPNuAUcGHUx3
	YqxiO+FhxaD5Ra6pPF60GCvr0Zh3pkNv3AYJD2YZGOj4PAB6nDbpg4RGED5al66VbiFZ9tWnXsCw+
	SwZNKYuplAnbzba8O+cJOCxWI0/rhoDf736vIrrtZc5pOeaAwWU+UpsklM+diIIJzqvJX4UaCu85D
	pudeJAlmWsV5MxGj3HqZnu4NJkqYiV+DeEkd0oz31Jal4+DheRCvIVum7YcvDoYiQDzBXJ1LEChLR
	BNuIqMWe7Zimy6AmK2OA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwtLM-00027v-Bk; Thu, 21 Feb 2019 18:45:12 +0000
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwtLH-0001Kp-58
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 18:45:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcqJRDCih8Kp0Ud5r920kR+JNm+SsEhW03mEfk8rAOQ=;
 b=QPAdwXc1c0pLpT6r8/Nef8Ha3cxd0k9DlF94RJoErzJKOl70zwhV5TRtIpx4Zw98+/Gf6dZphB2dYezStBFw3B5n6W+HKuEhq/M+8CiZHqrqg5IzYh9xR11Nlwb8HdhIikjSLwVeKqtKYMeYIf7ObSWtK1WKJ0nPuE0n/bdo14M=
Received: from VI1PR0801MB1599.eurprd08.prod.outlook.com (10.167.211.15) by
 VI1PR0801MB1952.eurprd08.prod.outlook.com (10.173.74.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.24; Thu, 21 Feb 2019 18:45:03 +0000
Received: from VI1PR0801MB1599.eurprd08.prod.outlook.com
 ([fe80::e11e:abd4:7d4:d8aa]) by VI1PR0801MB1599.eurprd08.prod.outlook.com
 ([fe80::e11e:abd4:7d4:d8aa%3]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 18:45:03 +0000
From: Dave P Martin <Dave.Martin@arm.com>
To: Andrew Murray <Andrew.Murray@arm.com>
Subject: Re: [PATCH v2 2/6] arm64: HWCAP: add support for AT_HWCAP2
Thread-Topic: [PATCH v2 2/6] arm64: HWCAP: add support for AT_HWCAP2
Thread-Index: AQHUyd/t1Srq935N/UGw8BkLn71pHqXql1kA
Date: Thu, 21 Feb 2019 18:45:03 +0000
Message-ID: <20190221184500.GO16031@e103592.cambridge.arm.com>
References: <1550751657-30252-1-git-send-email-andrew.murray@arm.com>
 <1550751657-30252-3-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1550751657-30252-3-git-send-email-andrew.murray@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.23 (2014-03-12)
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::20) To VI1PR0801MB1599.eurprd08.prod.outlook.com
 (2603:10a6:800:19::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Martin@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e01e7de-8c23-4cd8-3eb7-08d6982cb084
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0801MB1952; 
x-ms-traffictypediagnostic: VI1PR0801MB1952:
x-microsoft-exchange-diagnostics: 1; VI1PR0801MB1952;
 20:hdf5YeyAJvXvoYJbEXJZILfQPhO0ofoMdJwECKvoDAzK1plUZAucbIlR8rT2W9G64TStkOLdTru7KcuT1cHCEC8rG5CM4/s8FOcpmKe9HV8xMu5DrLB0A5N9j4yWHipIRKiQza29oxaj67bQWrg5Q2Ha0AUCYoK05TOuuJrn/6w=
x-microsoft-antispam-prvs: <VI1PR0801MB1952442D89D20CCF2759B9CEFE7E0@VI1PR0801MB1952.eurprd08.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(40434004)(189003)(478600001)(99286004)(102836004)(52116002)(72206003)(68736007)(486006)(6636002)(8936002)(11346002)(446003)(316002)(6512007)(58126008)(54906003)(229853002)(476003)(76176011)(71190400001)(386003)(6506007)(1076003)(6486002)(5024004)(2906002)(5660300002)(6436002)(53936002)(256004)(14444005)(86362001)(71200400001)(66066001)(105586002)(6246003)(33656002)(25786009)(26005)(6862004)(81166006)(186003)(106356001)(3846002)(81156014)(305945005)(14454004)(6116002)(8676002)(4326008)(97736004)(7736002)(18370500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0801MB1952;
 H:VI1PR0801MB1599.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +zCS8TD81fY9HoRmIpRYB8tN/4XeTfrbe8z42CatvxOWPxzwTeVbgkpu50/EyoXiWbYJDonblJUB8IoehHnuijo4LZbmer+avXiCiRgcvObq0ZPHxnoUHjZJGm5eKaVQopYqvSAXbYqOgf+fwEfu/iiNot0PJtR5m1BmuZe3L7VOdrQGeUH3wn+X8baQwhInJZb4IOQuvYzhp1rkH+XGEUGELPArr6rK545q1615NnEulkRneBbcZwPwppObFbaaqUnmltzn4im+yjrK8a1sE7hivQUqiXdh4+M3F7jzeIIFQjVOLrp22Bw8ZUJJBfBTr7wy5xW5RBnlLL9X9axuiCvH1eDn4lj7JYH+QSTjckPP8/Nx7hKShKVvHEM1e0TNGOSFi1FIo5GdbL/3SIX/4HsVzYJ/p8lLFRZUXCQDjHY=
Content-ID: <D4DF55E7E6A2E8408F792AEB925E383D@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e01e7de-8c23-4cd8-3eb7-08d6982cb084
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 18:45:02.4911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1952
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_104507_390125_3331EDD4 
X-CRM114-Status: GOOD (  36.77  )
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

On Thu, Feb 21, 2019 at 12:20:53PM +0000, Andrew Murray wrote:
> As we will exhaust the first 32 bits of AT_HWCAP let's start
> exposing AT_HWCAP2 to userspace to give us up to 64 caps.
>
> Whilst it's possible to use the remaining 32 bits of AT_HWCAP, we
> prefer to expand into AT_HWCAP2 in order to provide a consistent
> view to userspace between ILP32 and LP64. However internal to the
> kernel we prefer to continue to use the full space of elf_hwcap.
>
> To reduce complexity and allow for future expansion, we now
> represent hwcaps in the kernel as ordinals and use a
> KERNEL_HWCAP_ prefix. This allows us to support automatic feature
> based module loading for all our hwcaps.
>
> We introduce cpu_set_feature to set hwcaps which compliments the
> existing cpu_have_feature helper. These helpers allow us to clean
> up existing direct uses of elf_hwcap and reduce any future effort
> required to move beyond 64 caps.
>
> For convenience we also introduce cpu_{have,set}_feature_name which
> makes use of the cpu_feature macro to allow providing a hwcap name
> without a {KERNEL_}HWCAP_ prefix.
>
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/arm64/crypto/aes-ce-ccm-glue.c      |  2 +-
>  arch/arm64/crypto/aes-neonbs-glue.c      |  2 +-
>  arch/arm64/crypto/chacha-neon-glue.c     |  2 +-
>  arch/arm64/crypto/crct10dif-ce-glue.c    |  2 +-
>  arch/arm64/crypto/ghash-ce-glue.c        |  6 +--
>  arch/arm64/crypto/nhpoly1305-neon-glue.c |  2 +-
>  arch/arm64/crypto/sha256-glue.c          |  4 +-
>  arch/arm64/include/asm/cpufeature.h      | 19 ++++++---
>  arch/arm64/include/asm/hwcap.h           | 40 ++++++++++++++++++-
>  arch/arm64/include/uapi/asm/hwcap.h      |  2 +-
>  arch/arm64/kernel/cpufeature.c           | 66 ++++++++++++++++----------------
>  arch/arm64/kernel/cpuinfo.c              |  2 +-
>  arch/arm64/kernel/fpsimd.c               |  4 +-
>  drivers/clocksource/arm_arch_timer.c     |  8 ++++
>  14 files changed, 108 insertions(+), 53 deletions(-)

[...]

> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index dfcfba7..dd21a32 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -17,12 +17,12 @@
>  /*
>   * In the arm64 world (as in the ARM world), elf_hwcap is used both internally
>   * in the kernel and for user space to keep track of which optional features
> - * are supported by the current system. So let's map feature 'x' to HWCAP_x.
> - * Note that HWCAP_x constants are bit fields so we need to take the log.
> + * are supported by the current system. So let's map feature 'x' to
> + * KERNEL_HWCAP_x.

This doesn't read quite right now.

The purpose of this paragraph seems to be that the kernel and user
views have the same encoding, so we can just map x to UAPI HWCAP_x
definition.

This isn't true any more: we now consider the kernel (in elf_hwcap) and
user encodings (in AT_HWCAP) distinct, but for backwards compatibility
reasons HWCAP_x == BIT(KERNEL_HWCAP_x) for the first 32 hwcaps.

So it would be worth rewriting this whole comment to describe the new
situation, rather than just tweaking it.


I'm not sure whether it is more natural to put the comment in
<asm/hwcap.h> or here: you could put it in one place with a brief
pointer in the other.

>   */
>
> -#define MAX_CPU_FEATURES(8 * sizeof(elf_hwcap))
> -#define cpu_feature(x)ilog2(HWCAP_ ## x)
> +#define MAX_CPU_FEATURES64
> +#define cpu_feature(x)(KERNEL_HWCAP_ ## x)
>
>  #ifndef __ASSEMBLY__
>
> @@ -396,10 +396,19 @@ extern struct static_key_false arm64_const_caps_ready;
>
>  bool this_cpu_has_cap(unsigned int cap);
>
> +static inline void cpu_set_feature(unsigned int num)
> +{
> +WARN_ON(num >= MAX_CPU_FEATURES);
> +elf_hwcap |= BIT(num);
> +}
> +#define cpu_set_feature_name(name) cpu_set_feature(cpu_feature(name))
> +
>  static inline bool cpu_have_feature(unsigned int num)
>  {
> -return elf_hwcap & (1UL << num);
> +WARN_ON(num >= MAX_CPU_FEATURES);
> +return elf_hwcap & BIT(num);
>  }
> +#define cpu_have_feature_name(name) cpu_have_feature(cpu_feature(name))

This is bikeshedding, but I'd say that CPUs don't have (feature) names;
they have features (which have names).

So I might prefer to call these something like:

cpu_set_named_feature()
cpu_have_named_feature()

(May not be worth it unless you respin the series for another reason
though.)

>  /* System capability check for constant caps */
>  static inline bool __cpus_have_const_cap(int num)
> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index 400b80b..7549c72 100644
> --- a/arch/arm64/include/asm/hwcap.h
> +++ b/arch/arm64/include/asm/hwcap.h
> @@ -39,12 +39,50 @@
>  #define COMPAT_HWCAP2_SHA2(1 << 3)
>  #define COMPAT_HWCAP2_CRC32(1 << 4)
>
> +/*
> + * KERNEL_HWCAP flags - for elf_hwcap (in kernel)
> + */
> +#define KERNEL_HWCAP_FPilog2(HWCAP_FP)
> +#define KERNEL_HWCAP_ASIMDilog2(HWCAP_ASIMD)

[...]

> +#define KERNEL_HWCAP_SBilog2(HWCAP_SB)
> +#define KERNEL_HWCAP_PACAilog2(HWCAP_PACA)
> +#define KERNEL_HWCAP_PACGilog2(HWCAP_PACG)
> +#define KERNEL_HWCAP_DCPODP(ilog2(HWCAP2_DCPODP) + 32)

For ABI purposes, we should take the opportunity to document the status
of the currently unused bits.

For interoperation with the glibc ifunc resolver ABI, we may want to
reserve a bit among AT_HWCAP [63:32] or AT_HWCAP2 [31:0] that will
never be used by the kernel and always passed to userspace as 0.

I'm envisaging code such as

foo resolver(unsigned long hwcaps, unsigned int num_at_hwcaps,
unsigned long const *at_hwcaps)
{
if ((hwcaps & _GLIBC_EXTRA_HWCAPS) &&
num_at_hwcaps >= 2 &&
at_hwcaps[1] && HWCAP2_FOO)
/* feature present */
}

We would need that _GLIBC_EXTRA_HWCAPS to distinguish the second and
third arguments from uninitialised junk that would be passed by older
glibc versions.

Glibc might or might not choose to try and wegde AT_HWCAP2 in the top
bits of the first argument instead of bits [63:32] of AT_HWCAP (which
we expect to be zero for now, but could still be made reachable via the
at_hwcaps pointer).

Coordination would be needed if glibc carries on using the
<uapi/asm/hwcap.h> HWCAP{,2}_foo defines for here while doing tricks
of this sort.

Szabolcs may have a view on whether this is needed / useful.


If so, we should document any required guarantees now so that we don't
accidentally violate them during future maintenance.  For the benefit
of userspace folks, it may be a good idea to have some clear statement
in Documentation/arm64/ also.

Because of the ABI implications here, if would also be good idea to copy
the libc-alpha mailing list, and possibly also linux-api.

> +
>  #ifndef __ASSEMBLY__
>  /*
>   * This yields a mask that user programs can use to figure out what
>   * instruction set this cpu supports.
>   */
> -#define ELF_HWCAP(elf_hwcap)
> +#define ELF_HWCAPlower_32_bits(elf_hwcap)
> +#define ELF_HWCAP2upper_32_bits(elf_hwcap)

Should we have #include <linux/kernel.h> here somewhere?

[...]

> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 9a7d4dc..4e8d3b4 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -778,7 +778,11 @@ static void arch_timer_evtstrm_enable(int divider)
>  cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
>  | ARCH_TIMER_VIRT_EVT_EN;
>  arch_timer_set_cntkctl(cntkctl);
> +#ifdef CONFIG_ARM64
> +cpu_set_feature_name(EVTSTRM);
> +#else
>  elf_hwcap |= HWCAP_EVTSTRM;
> +#endif

This is a little nasty.

You could give arch/arm its own cpu_set_feature_name() (or whatever it's
called), depending on how keen Russell is to pick it up.

Or for this particular case, stick with the old code (which we now get
away with because elf_hwcap is still exported).  The case of an
HWCAP_foo flag name that happens to have the same semantics on both arm
and arm64 is a pretty esoteric one, so it's not the end of the world if
the standard helpers don't deal with it.

To avoid future accidents you could replace the #ifdef with a comment at
each site (which will also allow people to track down this patch when
looking at that code).

>  #ifdef CONFIG_COMPAT
>  compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
>  #endif
> @@ -1000,7 +1004,11 @@ static int arch_timer_cpu_pm_notify(struct notifier_block *self,
>  } else if (action == CPU_PM_ENTER_FAILED || action == CPU_PM_EXIT) {
>  arch_timer_set_cntkctl(__this_cpu_read(saved_cntkctl));
>
> +#ifdef CONFIG_ARM64
> +if (cpu_have_feature_name(EVTSTRM))
> +#else
>  if (elf_hwcap & HWCAP_EVTSTRM)
> +#endif

Ditto.

[...]

Cheers
---Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

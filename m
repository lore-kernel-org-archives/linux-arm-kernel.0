Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AC3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:11:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736E0217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rbKZ1Dxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736E0217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y2quFo9RkPCfVXujyDJbX4u1lMwIme53A6e4ugWtCGo=; b=rbKZ1DxsoYW40d
	mv2M0SYXLrzuFYgA4nEiFWdvG95EfkE85oWu7hzFyRlCod5WHV5/kpHqI2Pwx6wLqW3LAULNn6jjW
	B9HTyWNI1PqyLJHiZ8t/82qHn0hKpXSgYl/QuIuTaO+XefaYEydNKUcGSQDLkmt2fRhlsiKCaiYp8
	7z99iRyOzKBDc/LlDGGTvQ3nHJVwi/xm35vfso8fzWyncG9mkv04YFbFjMbP9hp5DRFmYCMjTzL5s
	lL7j4r/N48SvTl3CYobVSN3Wk0LQvQhWhk5UnzP3UFxLUnTNxXPa8dB8oax3oLchtoJNUHwSVoGGE
	twJT+Hc77vXVHafzQmRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybaV-0006Nu-DS; Tue, 26 Feb 2019 12:11:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybZB-0005pG-7N
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:10:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EED9F80D;
 Tue, 26 Feb 2019 04:10:32 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F9C33F71D;
 Tue, 26 Feb 2019 04:10:30 -0800 (PST)
Subject: Re: [PATCH v5 08/23] arm64: compat: Add KUSER_HELPERS config option
To: Mark Rutland <mark.rutland@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-9-vincenzo.frascino@arm.com>
 <20190222140427.GI42419@lakrids.cambridge.arm.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9a74d54f-5500-3276-64fa-c838f85bc69c@arm.com>
Date: Tue, 26 Feb 2019 12:10:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222140427.GI42419@lakrids.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_041033_880799_9BA3EDB0 
X-CRM114-Status: GOOD (  36.59  )
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
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mark,

thank you for your review.

On 22/02/2019 14:04, Mark Rutland wrote:
> On Fri, Feb 22, 2019 at 12:24:15PM +0000, Vincenzo Frascino wrote:
>> When kuser helpers are enabled the kernel maps the relative code at
>> a fixed address (0xffff0000). Making configurable the option to disable
>> them means that the kernel can remove this mapping and any access to
>> this memory area results in a sigfault.
>>
>> Add a KUSER_HELPERS config option that can be used to disable the
>> mapping when it is turned off.
>>
>> This option can be turned off if and only if the applications are
>> designed specifically for the platform and they do not make use of the
>> kuser helpers code.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> IIUC, the KUSER bits aren't striclty dependent on the rest of the vDSO
> changes.
> 
> I think the KUSER bits should be split into a preparatory series, so that they
> can be merged soon, rather than tying them artificially to the rest of the vDSO
> bits (which I expect will require significantly more review).
> 

This is a good point. I will extract them and post as a separate patch set.
In doing so I will update the config description below.

-- 
Regards,
Vincenzo

>> ---
>>  arch/arm64/Kconfig          | 21 +++++++++++++++++++++
>>  arch/arm64/kernel/Makefile  |  3 ++-
>>  arch/arm64/kernel/kuser32.S |  7 +++----
>>  arch/arm64/kernel/vdso.c    | 15 +++++++++++++++
>>  4 files changed, 41 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index d898da2e20f5..ed3290494f1c 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1465,6 +1465,27 @@ config COMPAT
>>  
>>  	  If you want to execute 32-bit userspace applications, say Y.
>>  
>> +config KUSER_HELPERS
>> +	bool "Enable kuser helpers page for compatibility with 32 bit applications."
>> +	depends on COMPAT
>> +	default y
>> +	help
>> +	  Enables kuser helpers to be mapped in a special purpose page at a fixed
>> +	  address to maintain independence from the type of CPU present in the SoC.
>> +	  This feature is provided for compatibility reasons in fact allows 32 bit
>> +	  applications compliant with ARMv4 up to ARMv8 to run without any
>> +	  modification.
>> +
>> +	  Warning: Being always mapped at a fixed address makes it easier to create
>> +	  exploits based on ROP type of attacks.
>> +
>> +	  As a consequence of this, this feature is made configurable but be aware that
>> +	  it can be turned off if and only if the binaries and the libraries running on
>> +	  a specific platform are designed to do not make use of these helpers, otherwise
>> +	  should be left on.
>> +
>> +	  See Documentation/arm/kernel_user_helpers.txt for details.
> 
> This is quite divergent from the text for the 32-bit arm KUSER_HELPERS.
> 
> Could we please reuse that existing text as far as possible, with minimal
> changes?
> 
> e.g.
> 
> config KUSER_HELPERS
> 	bool "Enable kuser helpers for compat tasks"
> 	depends on COMPAT
> 	default y
> 	help
> 	  Warning: disabling this option may break user programs.
> 
> 	  Provide kuser helpers to compat tasks. The kernel provides
> 	  helper code to userspace in read only form at a fixed location
> 	  to allow userspace to be independent of the CPU type fitted to
> 	  the system. This permits binaries to be run on ARMv4 through
> 	  to ARMv8 without modification.
> 
> 	  See Documentation/arm/kernel_user_helpers.txt for details.
> 
> 	  However, the fixed address nature of these helpers can be used
> 	  by ROP (return orientated programming) authors when creating
> 	  exploits.
> 
> 	  If all of the binaries and libraries which run on your platform
> 	  are built specifically for your platform, and make no use of
> 	  these helpers, then you can turn this option off to hinder
> 	  such exploits. However, in that case, if a binary or library
> 	  relying on those helpers is run, it will not function correctly.
> 
> 	  Say N here only if you are absolutely certain that you do not
> 	  need these helpers; otherwise, the safe option is to say Y.
> 
> I believe that Will wanted to default the kuser helpers off, as applications
> using them need the instruction emulation which is also disabled by default.
> 
> I'm also not sure which binaries we expect to work on arm64, so I'm not sure if
> the ARMv4 reference is correct.
> 
> Thanks,
> Mark.
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

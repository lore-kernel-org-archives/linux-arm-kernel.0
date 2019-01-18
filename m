Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78AEC07EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:25:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB8220883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z6E35TkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB8220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t1j7duU2hcmVOBT6j7gl5/XRR6EIQX6R1a5j+byBCzM=; b=Z6E35TkM1l4oL/
	QM2rZQalDncqVRJ3X6lYvS6dcq7agN8Dsi1ob17Ln/rle1Sf42SR/Oh3BvgH0YUheI90Q1N0Vky9E
	cZXEWGNPvPHcKrhq2tl1WKEl+Unvujmf30VpNOiFqTH9FNBsuZgk5P8CH1m94sC8kgicxxh3CF2mc
	go3nyUhF5/SCTF1yVZaReQhwt0enF0C7+q+CmmDMvSyUforisUP9rtpIOXsNdHMIx/dBVBm+8FOzp
	EZnpBY92hUrci9zXXG8iP749C9J+KivN+pHQKKJCMBae6AZmJUiicoZ+4JLEeSEEa5gdjvs4iWhMv
	25clAWj6DwvhqACiwqAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXtE-0006Sn-Ux; Fri, 18 Jan 2019 17:25:08 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXt7-0005pC-O2
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:25:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E78980D;
 Fri, 18 Jan 2019 09:25:01 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A744D3F7BE;
 Fri, 18 Jan 2019 09:24:58 -0800 (PST)
Date: Fri, 18 Jan 2019 17:24:56 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH v7 1/3] arm64: replace -pg with CC_FLAGS_FTRACE in
 Makefiles
Message-ID: <20190118172455.GF12256@lakrids.cambridge.arm.com>
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163904.CD7BA68CEB@newverein.lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118163904.CD7BA68CEB@newverein.lst.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_092501_794194_38B03B71 
X-CRM114-Status: GOOD (  16.08  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Amit Daniel Kachhap <amit.kachhap@arm.com>, live-patching@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Torsten,

On Fri, Jan 18, 2019 at 05:39:04PM +0100, Torsten Duwe wrote:
> Ftrace instrumentation might also be introduced by
> -fpatchable-function-entry, not only -pg. Ensure the Makefiles are
> flexible to filter out the respective flags in "notrace" directories.

I think this is a cleanup regardless of whether we use
-fpatchable-function-entry.

Can we please give this a more complete description, e.g.

| Currently arm64 makefiles assume that ftrace will use '-pg', and remove
| this flag specifically, rather than the contents of $(CC_FLAGS_FTRACE).
| 
| In preparation for arm64 supporting ftrace built on other compiler
| options, let's have the arm64 makefiles remove the $(CC_FLAGS_FTRACE)
| flags, whatever these may be, rather than assuming '-pg'. 
|
| There should be no functional change as a result of this patch.

> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> ---
>  arch/arm64/kernel/Makefile            |    6 +++---
>  drivers/firmware/efi/libstub/Makefile |    3 ++-

This misses arch/arm64/lib/Makefile and mm/kasan/makefile.

Could we please split this into three patches, addressing:

* arm64
* efistub
* kasan

... since those have distinct maintainers. All those patches can be part
of this series, but having them as separate patches is a bit nicer for
review.

>  2 files changed, 5 insertions(+), 4 deletions(-)
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -7,9 +7,9 @@ CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(
>  AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>  CFLAGS_armv8_deprecated.o := -I$(src)
>  
> -CFLAGS_REMOVE_ftrace.o = -pg
> -CFLAGS_REMOVE_insn.o = -pg
> -CFLAGS_REMOVE_return_address.o = -pg
> +CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
>  
>  # Object file lists.
>  obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -16,7 +16,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__K
>  
>  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>  # disable the stackleak plugin
> -cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie \
> +cflags-$(CONFIG_ARM64)		:= $(filter-out $(CC_FLAGS_FTRACE)\
> +				  ,$(KBUILD_CFLAGS)) -fpie \
>  				   $(DISABLE_STACKLEAK_PLUGIN)

Why do we need to swtich to using filter-out. AFAICT, subst works just fine.

To keepthis legible, it would be nicer to split it like:

cflags-$(CONFIG_ARM64)			:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
					   -fpie $(DISABLE_STACKLEAK_PLUGIN)

>  cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
>  				   -fno-builtin -fpic \

Please clean up this instance too, at least for consistency.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

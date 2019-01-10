Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B89AC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:39:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F64214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mrEiqVLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F64214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VrvjlXDBiDJGGwVf8CMt2/+nf/nT8Cuq+uYRpUOefes=; b=mrEiqVLulZae+c
	Fhck7avOqRI5G/UgNp8IC8pVlOmvrbO/aa2f3QYUDH3R+/Vbwb2AjmgCbmjUEcs1TTQiwN4meRYx0
	jR+GPFWy9YYQgtOygtljLGagt6c3AdDn7QsoPszSBhl2Vo+N1f1UM1dVZM1xlByLkOu18CE15Owxq
	xg+PyVm7XeEK4lx/yKcKFREQ6QkFeVCpTFrdU9t8mS+dSER3LMaQMh+6NE4XC6d2xClaPh0Ofps+W
	ixW4n2MGTYNiKK4V2jy1NRyATqYkQteW8fX0OQobW6BeqWRYiThRO34oj8XABchhLxKAWa1/SICaF
	iqdZ3KOoWgWEO+sNGXTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdMW-0004RI-8C; Thu, 10 Jan 2019 16:39:20 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdMT-0004Qw-Nn
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:39:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E5D5A78;
 Thu, 10 Jan 2019 08:39:17 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27BBF3F694;
 Thu, 10 Jan 2019 08:39:11 -0800 (PST)
Date: Thu, 10 Jan 2019 16:39:08 +0000
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/15] ARM: add kexec_file_load system call number
Message-ID: <20190110163908.GC31683@fuggles.cambridge.arm.com>
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-8-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190110162435.309262-8-arnd@arndb.de>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_083917_788908_687D7F04 
X-CRM114-Status: GOOD (  17.38  )
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, heiko.carstens@de.ibm.com, linux@dominikbrodowski.net,
 linux-mips@vger.kernel.org, jcmvbkbc@gmail.com, deepa.kernel@gmail.com,
 hpa@zytor.com, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 dave@stgolabs.net, y2038@lists.linaro.org, mpe@ellerman.id.au, deller@gmx.de,
 x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 firoz.khan@linaro.org, mattst88@gmail.com, fenghua.yu@intel.com,
 linux-m68k@lists.linux-m68k.org, ink@jurassic.park.msu.ru, luto@kernel.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
 tony.luck@intel.com, linux-parisc@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, paul.burton@mips.com, ebiederm@xmission.com,
 linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 05:24:27PM +0100, Arnd Bergmann wrote:
> A couple of architectures including arm64 already implement the
> kexec_file_load system call, on many others we have assigned a system
> call number for it, but not implemented it yet.
> 
> Adding the number in arch/arm/ lets us use the system call on arm64
> systems in compat mode, and also reduces the number of differences
> between architectures. If we want to implement kexec_file_load on ARM
> in the future, the number assignment means that kexec tools can already
> be built with the now current set of kernel headers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/tools/syscall.tbl        | 1 +
>  arch/arm64/include/asm/unistd.h   | 2 +-
>  arch/arm64/include/asm/unistd32.h | 2 ++
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 86de9eb34296..20ed7e026723 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -415,3 +415,4 @@
>  398	common	rseq			sys_rseq
>  399	common	io_pgetevents		sys_io_pgetevents
>  400	common	migrate_pages		sys_migrate_pages
> +401	common	kexec_file_load		sys_kexec_file_load
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 261216c3336e..2c30e6f145ff 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -44,7 +44,7 @@
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>  
> -#define __NR_compat_syscalls		401
> +#define __NR_compat_syscalls		402
>  #endif
>  
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index 355fe2bc035b..19f3f58b6146 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -823,6 +823,8 @@ __SYSCALL(__NR_rseq, sys_rseq)
>  __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
>  #define __NR_migrate_pages 400
>  __SYSCALL(__NR_migrate_pages, sys_migrate_pages)
> +#define __NR_kexec_file_load 401
> +__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)

Hmm, I wonder if we need a compat wrapper for this, or are we assuming
that the early entry code has already zero-extended the long and pointer
arguments?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

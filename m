Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997AEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:53:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5117B20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lj/FxzJG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IM1vVjUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5117B20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=njxoZ+oVJp4qranLMuxSs3OVXtEoNCyFojFTI/jIJzQ=; b=lj/FxzJG91BzNe
	pz/47oMKHW28wSnrWRAZms+tcfZrBRRFGTH0SRawnBpRthI5Fop3Mw4p2ZDkvOlidxErDmeCj7rx7
	2zEPaalx1ljFyjIk+st+PYvTVxcLhrBkzqBoQ5RDssTbg/rLIS3p3rBv2Qi91mEpNkkbbvkmIL9CS
	nltFGLiBnjDKfB92pfytthGbOvINsHhstH3FYF0XCmcIxC89CNqMerLny9omlRdIe1tE1qU/r23ID
	R/VUPQ7AiVJQX+agYOyT1S+imYJVPZOyNmGcicHMn7sOtEpK2oMf2bfyQ4xEaPTiX8exTs+N3oKvm
	FA1fQzHEc0gOF+j5b1ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjNHs-0005OE-US; Tue, 15 Jan 2019 11:53:44 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjNHo-0005Ne-LH
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 11:53:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UtkYBYQEV0zkIFWjLE1poFjLAMViJ0i4p6XlDuJkXsA=; b=IM1vVjUkT2Gq+IQyLcV94IGss
 VtFPaeJpVR2fEyZVwujSerg4Seq6FO3zEOGQGEoLPTih8ZfkI1OgcXiVThLTXH6ywv/mCCYfQbn6s
 5LjPwUFbGDKpZOAL3FvnHuHzh6EKBskLbN1V26J3AqolhRE4flIFk6O1QcBr6gzftzQuQ=;
Received: from e5254000004ec.dyn.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:35742 helo=shell.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gjNGg-0005RZ-3L; Tue, 15 Jan 2019 11:52:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gjNGf-0004ui-4x; Tue, 15 Jan 2019 11:52:29 +0000
Date: Tue, 15 Jan 2019 11:52:29 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/15] arch: add pkey and rseq syscall numbers everywhere
Message-ID: <20190115115229.mcrmmpwdmjxf2cra@e5254000004ec.dyn.armlinux.org.uk>
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-16-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190110162435.309262-16-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_035340_986781_C1A19781 
X-CRM114-Status: GOOD (  15.06  )
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
 x86@kernel.org, mingo@redhat.com, geert@linux-m68k.org, firoz.khan@linaro.org,
 mattst88@gmail.com, fenghua.yu@intel.com, will.deacon@arm.com,
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

On Thu, Jan 10, 2019 at 05:24:35PM +0100, Arnd Bergmann wrote:
> Most architectures define system call numbers for the rseq and pkey system
> calls, even when they don't support the features, and perhaps never will.
> 
> Only a few architectures are missing these, so just define them anyway
> for consistency. If we decide to add them later to one of these, the
> system call numbers won't get out of sync then.

I was lambasted for adding the pkey syscalls for 32-bit ARM in 2016,
which will probably never support it.  Why has the attitude towards
this kind of thing now apparently become acceptable?

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/alpha/include/asm/unistd.h         | 4 ----
>  arch/alpha/kernel/syscalls/syscall.tbl  | 4 ++++
>  arch/ia64/kernel/syscalls/syscall.tbl   | 4 ++++
>  arch/m68k/kernel/syscalls/syscall.tbl   | 4 ++++
>  arch/parisc/include/asm/unistd.h        | 3 ---
>  arch/parisc/kernel/syscalls/syscall.tbl | 4 ++++
>  arch/s390/include/asm/unistd.h          | 3 ---
>  arch/s390/kernel/syscalls/syscall.tbl   | 3 +++
>  arch/sh/kernel/syscalls/syscall.tbl     | 4 ++++
>  arch/sparc/include/asm/unistd.h         | 5 -----
>  arch/sparc/kernel/syscalls/syscall.tbl  | 4 ++++
>  arch/xtensa/kernel/syscalls/syscall.tbl | 1 +
>  12 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
> index 564ba87bdc38..31ad350b58a0 100644
> --- a/arch/alpha/include/asm/unistd.h
> +++ b/arch/alpha/include/asm/unistd.h
> @@ -29,9 +29,5 @@
>  #define __IGNORE_getppid
>  #define __IGNORE_getuid
>  
> -/* Alpha doesn't have protection keys. */
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
>  
>  #endif /* _ALPHA_UNISTD_H */
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index b0e247287908..25b4a7e76943 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -452,3 +452,7 @@
>  521	common	pwritev2			sys_pwritev2
>  522	common	statx				sys_statx
>  523	common	io_pgetevents			sys_io_pgetevents
> +524	common	pkey_alloc			sys_pkey_alloc
> +525	common	pkey_free			sys_pkey_free
> +526	common	pkey_mprotect			sys_pkey_mprotect
> +527	common	rseq				sys_rseq
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index 2e93dbdcdb80..84e03de00177 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -339,3 +339,7 @@
>  327	common	io_pgetevents			sys_io_pgetevents
>  328	common	perf_event_open			sys_perf_event_open
>  329	common	seccomp				sys_seccomp
> +330	common	pkey_alloc			sys_pkey_alloc
> +331	common	pkey_free			sys_pkey_free
> +332	common	pkey_mprotect			sys_pkey_mprotect
> +333	common	rseq				sys_rseq
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index 5354ba02eed2..ae88b85d068e 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -388,6 +388,10 @@
>  378	common	pwritev2			sys_pwritev2
>  379	common	statx				sys_statx
>  380	common	seccomp				sys_seccomp
> +381	common	pkey_alloc			sys_pkey_alloc
> +382	common	pkey_free			sys_pkey_free
> +383	common	pkey_mprotect			sys_pkey_mprotect
> +384	common	rseq				sys_rseq
>  # room for arch specific calls
>  393	common	semget				sys_semget
>  394	common	semctl				sys_semctl
> diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
> index c2c2afb28941..9ec1026af877 100644
> --- a/arch/parisc/include/asm/unistd.h
> +++ b/arch/parisc/include/asm/unistd.h
> @@ -12,9 +12,6 @@
>  
>  #define __IGNORE_select			/* newselect */
>  #define __IGNORE_fadvise64		/* fadvise64_64 */
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
>  
>  #ifndef ASM_LINE_SEP
>  # define ASM_LINE_SEP ;
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 9bbd2f9f56c8..e07231de3597 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -367,3 +367,7 @@
>  348	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
>  349	common	statx			sys_statx
>  350	common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
> +351	common	pkey_alloc		sys_pkey_alloc
> +352	common	pkey_free		sys_pkey_free
> +353	common	pkey_mprotect		sys_pkey_mprotect
> +354	common	rseq			sys_rseq
> diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
> index a1fbf15d53aa..ed08f114ee91 100644
> --- a/arch/s390/include/asm/unistd.h
> +++ b/arch/s390/include/asm/unistd.h
> @@ -11,9 +11,6 @@
>  #include <asm/unistd_nr.h>
>  
>  #define __IGNORE_time
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
>  
>  #define __ARCH_WANT_NEW_STAT
>  #define __ARCH_WANT_OLD_READDIR
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 428cf512a757..f84ea364a302 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -391,6 +391,9 @@
>  381  common	kexec_file_load		sys_kexec_file_load		compat_sys_kexec_file_load
>  382  common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
>  383  common	rseq			sys_rseq			compat_sys_rseq
> +384  common	pkey_alloc		sys_pkey_alloc			sys_pkey_alloc
> +385  common	pkey_free		sys_pkey_free			sys_pkey_free
> +386  common	pkey_mprotect		sys_pkey_mprotect		sys_pkey_mprotect
>  # room for arch specific syscalls
>  392	64	semtimedop		sys_semtimedop			-
>  393  common	semget			sys_semget			sys_semget
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index 6d0b84e3ef2d..3f96ad0424e1 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -391,6 +391,10 @@
>  381	common	preadv2				sys_preadv2
>  382	common	pwritev2			sys_pwritev2
>  383	common	statx				sys_statx
> +384	common	pkey_alloc			sys_pkey_alloc
> +385	common	pkey_free			sys_pkey_free
> +386	common	pkey_mprotect			sys_pkey_mprotect
> +387	common	rseq				sys_rseq
>  # room for arch specific syscalls
>  393	common	semget				sys_semget
>  394	common	semctl				sys_semctl
> diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
> index 5194d86ef72d..08696ea5dca8 100644
> --- a/arch/sparc/include/asm/unistd.h
> +++ b/arch/sparc/include/asm/unistd.h
> @@ -59,9 +59,4 @@
>  #define __IGNORE_getresgid
>  #endif
>  
> -/* Sparc doesn't have protection keys. */
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
> -
>  #endif /* _SPARC_UNISTD_H */
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 8c9580302422..24ebef675184 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -407,6 +407,10 @@
>  359	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
>  360	common	statx			sys_statx
>  361	common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
> +362	common	pkey_alloc		sys_pkey_alloc
> +363	common	pkey_free		sys_pkey_free
> +364	common	pkey_mprotect		sys_pkey_mprotect
> +365	common	rseq			sys_rseq
>  # room for arch specific syscalls
>  392	64	semtimedop			sys_semtimedop
>  393	common	semget			sys_semget
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index f8befa11b0c4..c699e014e0dd 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -372,3 +372,4 @@
>  349	common	pkey_alloc			sys_pkey_alloc
>  350	common	pkey_free			sys_pkey_free
>  351	common	statx				sys_statx
> +352	common	rseq				sys_rseq
> -- 
> 2.20.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

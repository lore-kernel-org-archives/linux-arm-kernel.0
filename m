From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 4 Mar 2015 22:54:37 +0100
Subject: [PATCH v4 0/10] split ET_DYN ASLR from mmap ASLR
In-Reply-To: <1425503454-7531-1-git-send-email-keescook@chromium.org>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
Message-ID: <20150304215437.GA22254@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Kees Cook <keescook@chromium.org> wrote:

> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
> ASLR from mmap ASLR, as already done on s390. The architectures
> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
> and x86), have their various forms of arch_mmap_rnd() made available
> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
> arch_randomize_brk() is collapsed as well.
> 
> This is an alternative to the solutions in:
> https://lkml.org/lkml/2015/2/23/442
> 
> I've been able to test x86 and arm, and the buildbot (so far) seems
> happy with building the rest.

Ok, this looks really good - for all patches:

   Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

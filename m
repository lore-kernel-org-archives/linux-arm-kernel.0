From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 2 Mar 2015 13:26:57 -0800
Subject: [PATCH 0/5] split ET_DYN ASLR from mmap ASLR
In-Reply-To: <1425006434-3106-1-git-send-email-keescook@chromium.org>
References: <1425006434-3106-1-git-send-email-keescook@chromium.org>
Message-ID: <20150302132657.5507742399620e70dd0a3926@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Feb 2015 19:07:09 -0800 Kees Cook <keescook@chromium.org> wrote:

> This separates ET_DYN ASLR from mmap ASLR, as already done on s390. The
> various architectures that are already randomizing mmap (arm, arm64, mips,
> powerpc, s390, and x86), have their various forms of arch_mmap_rnd()
> made available via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these
> architectures, arch_randomize_brk() is collapsed as well.
> 
> This is an alternative to the solutions in:
> https://lkml.org/lkml/2015/2/23/442

"504 Gateway Time-out"

Hector's original patch had very useful descriptions of the bug, why it
occurred, how it was exploited it and how the patch fixes it.

Your changelogs contain none of this and can be summarized as "randomly
churn code around for no apparent reason".

Wanna try again?  I guess the [0/5] and [4/5] changelogs are the ones
to fix.

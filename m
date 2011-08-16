From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Aug 2011 23:21:21 +0200
Subject: [RFC,PATCH] arch/arm: compute and export NR_syscalls
In-Reply-To: <1313529267-4428-1-git-send-email-wad@chromium.org>
References: <1313529267-4428-1-git-send-email-wad@chromium.org>
Message-ID: <1629809.vjtjo6obCs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 August 2011 16:14:26 Will Drewry wrote:
> 
> asm-exports.c is added instead of reusing asm-offsets.c to avoid a
> variety of collisions (VM_EXEC, DMA_*, etc).  It is possible to use the
> same calls.S mechanism but add NR_syscalls to asm-offsets.c.  However,
> at inclusion time for generated/asm-offsets.h, conflicting defines will
> need to be #undef'd if !__ASSEMBLY__ since it appears that the purpose
> of asm-offsets.h is to safely bind C language definitions to assembly
> and not the reverse.
> 
> - Is this approach palatable?
> - Should I resend only when paired with the other ftrace-needed patches?

This seems overly complex, compared to a one-line change adding the symbol
to asm/unistd.h. The only other architecture that uses an approach
like the one you have posted is x86-64, and it's simpler there
because it can easily be done in asm-offsets.c there without the need
to create another helper.

	Arnd

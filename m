From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 27 Jan 2016 11:35:48 -0800
Subject: [PATCH v2 resend 6/6] arm64: switch to relative exception tables
In-Reply-To: <1453892123-17973-7-git-send-email-ard.biesheuvel@linaro.org>
References: <1453892123-17973-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453892123-17973-7-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160127113548.d4f2f2a7029b3b89f0e596da@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jan 2016 11:55:23 +0100 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> Instead of using absolute addresses for both the exception location
> and the fixup, use offsets relative to the exception table entry values.
> Not only does this cut the size of the exception table in half, it is
> also a prerequisite for KASLR, since absolute exception table entries
> are subject to dynamic relocation, which is incompatible with the sorting
> of the exception table that occurs at build time.
> 
> This patch also introduces the _ASM_EXTABLE preprocessor macro (which
> exists on x86 as well) and its _asm_extable assembly counterpart, as
> shorthands to emit exception table entries.

checkpatch speaketh truth:

ERROR: #define of 'ARCH_HAS_RELATIVE_EXTABLE' is wrong - use Kconfig variables or standard guards instead
#113: FILE: arch/arm64/include/asm/uaccess.h:56:

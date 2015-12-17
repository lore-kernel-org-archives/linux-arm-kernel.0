From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Dec 2015 16:34:46 +0100
Subject: [PATCH] ARM: PJ4: make coprocessor access sequences buildable in
 Thumb2 mode
In-Reply-To: <1450365912-3834-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1450365912-3834-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <3576416.qTRH9rObcr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 December 2015 16:25:12 Ard Biesheuvel wrote:
> The PJ4 inline asm sequence to write to cp15 cannot be built in Thumb-2
> mode, due to the way it performs arithmetic on the program counter, so it
> is built in ARM mode instead. However, building C files in ARM mode under
> CONFIG_THUMB2_KERNEL is problematic, since the instrumentation performed
> by subsystems like ftrace does not expect having to deal with interworking
> branches.
> 
> Since the sequence in question is simply a poor man's ISB instruction,
> let's use a straight 'isb' instead. Unlike Xscale, where this code
> originated, PJ4 is strictly ARMv7 so this should always be supported.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

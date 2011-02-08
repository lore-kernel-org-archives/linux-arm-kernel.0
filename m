From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Feb 2011 16:40:09 +0000
Subject: [PATCH] ARM: Correct WFE() in asm/spinlock.h for Thumb-2
In-Reply-To: <1297178414-20983-1-git-send-email-dave.martin@linaro.org>
References: <1297178414-20983-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20110208164009.GD27521@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 08, 2011 at 03:20:14PM +0000, Dave Martin wrote:
> The content for ALT_SMP() in the definition of WFE() expands to 6
> bytes (IT cc ; WFEcc.W), which breaks the assumptions of the fixup
> code, leading to lockups when the affected code gets run.

Why does it?  My understanding is that the .w suffix forces the assembler
to use the ARM encoding for the instruction.

Thumb2 is just far too weird to understand.  I think I'll just stick to
writing good ARM code and let people sort out the Thumb2 weirdnesses.

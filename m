From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 2 Sep 2015 15:37:09 -0400 (EDT)
Subject: [PATCH] ARM: disable GCC SRA optimization
In-Reply-To: <1441211290-11449-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1441211290-11449-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.20.1509021529500.22877@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Sep 2015, Ard Biesheuvel wrote:

> While working on the 32-bit ARM port of UEFI, I noticed a strange
> corruption in the kernel log.
[...]
> when called with len == 0, triggers an issue in the GCC SRA optimization
> pass (Scalar Replacement of Aggregates), which handles promotion of signed
> struct members incorrectly. This is a known but as yet unresolved issue.
> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65932). In this particular
> case, it is causing the second while loop to be executed erroneously a
> single time, causing the additional space characters to be printed.
> 
> So disable the optimization by passing -fno-ipa-sra.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
> 
> Needs to go to stable perhaps?

Absolutely.  You encountered a kernel log strangeness, other people 
reported kernel boot failures.  Who knows what else this bug can do.

Would be a good idea if you subscribed yourself to the bug entry so to 
put a test in the makefile for the fixed gcc version eventually.


Nicolas

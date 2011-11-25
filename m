From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 25 Nov 2011 11:32:54 +0000
Subject: [RFC PATCH] ARM: Add generic instruction opcode manipulation
 helpers
In-Reply-To: <1322220493-3251-1-git-send-email-dave.martin@linaro.org>
References: <1322220493-3251-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20111125113254.GC2098@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2011 at 11:28:13AM +0000, Dave Martin wrote:
> This patch adds some endianness-agnostic helpers to convert machine
> instructions between canonical integer form and in-memory
> representation, and also provides a transparent way to read a
> single Thumb instruction from memory, without the need to know the
> size in advance or write explicit condition checks.
> 
> A canonical integer form for representing instructions is also
> formalised here.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---

Notes:

 * We don't necessarily need everything that's in this example header

 * A generic instruction writing macro could be added, similar to the
   generic read macro, if this looks useful.

 * We could align the use of undefined instruction encodings across
   the kernel via this header: all instruction sets allow a
   guaranteed undefined instruction with up to 8 choosable bits,
   and we can also define additional generic and "NULL" encodings
   for internal use by kernel code which deals with instruction
   opcodes -- to signal special cases and error values etc.

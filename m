From: stefan@agner.ch (Stefan Agner)
Date: Tue, 09 Jun 2015 22:31:07 +0200
Subject: [PATCH v4 1/6] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <20150609200751.GC5720@breakpoint.cc>
References: <1427300909-20825-1-git-send-email-stefan@agner.ch>
 <1427300909-20825-2-git-send-email-stefan@agner.ch>
 <20150603130825.GA23991@breakpoint.cc>
 <b3b09b4b8c97cbfc88fa0d5fdc5e40cd@agner.ch>
 <20150609200751.GC5720@breakpoint.cc>
Message-ID: <16ebb290641f700f2262527f90ff1e46@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-06-09 22:07, Sebastian Andrzej Siewior wrote:
> On 2015-06-03 17:05:16 [+0200], Stefan Agner wrote:
>> As Boris guessed correctly, the reason I used the raw variant was due to
>> performance improvements due to the barrier. However, I will use
> 
> yeah, do you have any numbers by chance?

Not current ones for Linux. I added this in the U-Boot variant of the
driver.
 
>> {read|write}l_relaxed instead, which should offer endian abstraction
>> while not having the performance penalty due to extensive barriers...
> 
> well, even those
> |$ git grep readl_relaxed arch/powerpc/
> |arch/powerpc/include/asm/io.h:#define readl_relaxed(addr) readl(addr)
> 
> have the endian swap. So an abstraction like you provided earlier
> would be nice :)

What do you mean by that?

Btw, I sent v5 of the patchset which use the relaxed variants. As
expected, performance did not suffer by that change on ARM.

--
Stefan

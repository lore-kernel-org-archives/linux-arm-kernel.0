From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Feb 2017 11:34:53 +0000
Subject: [PATCH] arm64: include asm/assembler.h in entry-ftrace.S
In-Reply-To: <20170214213314.2910910-1-arnd@arndb.de>
References: <20170214213314.2910910-1-arnd@arndb.de>
Message-ID: <20170215113453.GD9630@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 10:32:58PM +0100, Arnd Bergmann wrote:
> In a randconfig build I ran into this build error:
> 
> arch/arm64/kernel/entry-ftrace.S: Assembler messages:
> arch/arm64/kernel/entry-ftrace.S:101: Error: unknown mnemonic `ldr_l' -- `ldr_l x2,ftrace_trace_function'
> 
> The macro is defined in asm/assembler.h, so we should include that file.
> 
> Fixes: 829d2bd13392 ("arm64: entry-ftrace.S: avoid open-coded {adr,ldr}_l")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I've picked this one up too.

Will

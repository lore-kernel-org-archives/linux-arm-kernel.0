From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Nov 2011 23:56:44 +0000
Subject: [PATCH] ARM: kprobes: Change testcase with unpredictable STRD
 instruction
In-Reply-To: <1322395885.2408.1.camel@computer2>
References: <1322395885.2408.1.camel@computer2>
Message-ID: <20111130235644.GY9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 27, 2011 at 12:11:25PM +0000, Tixy wrote:
> There is a kprobes testcase for the instruction "strd r2, [r3], r4".
> This has unpredictable behaviour as it uses r3 for register writeback
> addressing and also stores it to memory.
> 
> On a cortex A9, this testcase would fail because the instruction writes
> the updated value of r3 to memory, whereas the kprobes emulation code
> writes the original value.
> 
> Fix this by changing testcase to used r5 instead of r3.

Is this a -stable candidate?

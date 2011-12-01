From: tixy@yxit.co.uk (Tixy)
Date: Thu, 01 Dec 2011 07:33:22 +0000
Subject: [PATCH] ARM: kprobes: Change testcase with unpredictable STRD
 instruction
In-Reply-To: <20111130235644.GY9581@n2100.arm.linux.org.uk>
References: <1322395885.2408.1.camel@computer2>
 <20111130235644.GY9581@n2100.arm.linux.org.uk>
Message-ID: <1322724802.2352.0.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-30 at 23:56 +0000, Russell King - ARM Linux wrote:
> On Sun, Nov 27, 2011 at 12:11:25PM +0000, Tixy wrote:
> > There is a kprobes testcase for the instruction "strd r2, [r3], r4".
> > This has unpredictable behaviour as it uses r3 for register writeback
> > addressing and also stores it to memory.
> > 
> > On a cortex A9, this testcase would fail because the instruction writes
> > the updated value of r3 to memory, whereas the kprobes emulation code
> > writes the original value.
> > 
> > Fix this by changing testcase to used r5 instead of r3.
> 
> Is this a -stable candidate?

No, the test code is new in 3.2

-- 
Tixy

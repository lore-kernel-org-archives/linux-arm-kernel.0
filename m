From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 02 Jul 2014 11:24:28 +0200
Subject: [PATCH] ARM: convert all "mov.* pc, reg" to "bx reg" for ARMv6+
In-Reply-To: <E1X20Rs-00082S-KI@rmk-PC.arm.linux.org.uk>
References: <E1X20Rs-00082S-KI@rmk-PC.arm.linux.org.uk>
Message-ID: <53B3CFCC.50506@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 01/07/2014 17:58, Russell King wrote:
> ARMv6 and greater introduced a new instruction ("bx") which can be used
> to return from function calls.  Recent CPUs perform better when the
> "bx lr" instruction is used rather than the "mov pc, lr" instruction,
> and this sequence is strongly recommended to be used by the ARM
> architecture manual (section A.4.1.1).
> 
> We provide a new macro "ret" with all its variants for the condition
> code which will resolve to the appropriate instruction.
> 
> Rather than doing this piecemeal, and miss some instances, change all
> the "mov pc" instances to use the new macro, with the exception of
> the "movs" instruction and the kprobes code.  This allows us to detect
> the "mov pc, lr" case and fix it up - and also gives us the possibility
> of deploying this for other registers depending on the CPU selection.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

It booted on Armada XP, Armada 370, Armada 385 and Armada 375

Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> ---


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

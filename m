From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Nov 2011 23:56:18 +0000
Subject: [PATCH] ARM: kprobes: Restrict probing SWP instructions to
 ARMv5 and below
In-Reply-To: <1322396080.2408.5.camel@computer2>
References: <1322396080.2408.5.camel@computer2>
Message-ID: <20111130235618.GX9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 27, 2011 at 12:14:40PM +0000, Tixy wrote:
> The SWP instruction is deprecated on ARMv6 and with ARMv7 it will be
> UNDEFINED when CONFIG_SWP_EMULATE is selected. In this case, probing a
> SWP instruction will cause an oops when the kprobes emulation code
> executes an undefined instruction.
> 
> As the SWP instruction should be rare or non-existent in kernels for
> ARMv6 and later, we can simply avoid these problems by not allowing
> probing of these.

Is this something for -stable stuff?

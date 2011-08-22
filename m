From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 22 Aug 2011 14:59:52 +0100
Subject: [PATCH v2] ARM: vexpress: Use wfi macro in platform_do_lowpower.
In-Reply-To: <1314021259-31710-1-git-send-email-nbowler@elliptictech.com>
References: <CAHkRjk6Fq+1b_uM+DFACS1QVd7B6_1XhqRw-27i88U1VyvLk+Q@mail.gmail.com>
	<1314021259-31710-1-git-send-email-nbowler@elliptictech.com>
Message-ID: <20110822135952.GE2796@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 09:54:19AM -0400, Nick Bowler wrote:
> Current Versatile Express CPU hotplug code includes a hardcoded WFI
> instruction, in ARM encoding.  When the kernel is compiled in Thumb-2
> mode, this is invalid and causes the machine to hang hard when a CPU
> is offlined.
> 
> Using the wfi macro (which uses the appropriate assembler mnemonic)
> causes the correct instruction to be emitted in either case.  As a
> consequence of this change, an apparently vestigial "cc" clobber is
> dropped from the asm (the macro uses "memory" only).
> 
> Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
> ---

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

if it helps!

Jamie

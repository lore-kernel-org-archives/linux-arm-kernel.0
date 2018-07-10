From: daniel@iogearbox.net (Daniel Borkmann)
Date: Tue, 10 Jul 2018 20:30:04 +0200
Subject: [PATCH net-next 01/13] ARM: net: bpf: enumerate the JIT scratch
 stack layout
In-Reply-To: <E1fcrsG-0005UK-Un@rmk-PC.armlinux.org.uk>
References: <20180710123340.GK17271@n2100.armlinux.org.uk>
 <E1fcrsG-0005UK-Un@rmk-PC.armlinux.org.uk>
Message-ID: <41b5fc68-e15f-56f9-c55b-4f6deb61c54c@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

thanks a lot for your work on the arm32 JIT!

On 07/10/2018 02:36 PM, Russell King wrote:
> Enumerate the contents of the JIT scratch stack layout used for storing
> some of the JITs 64-bit registers, tail call counter and AX register.
> 
> XXX: what about the skb_copy_bits buffer - this appears to overlap with
> the first word of the JITs accessible stack.

Could you elaborate on that case? Unless I'm missing something there should
be no use of the skb_copy_bits buffer anymore (aka former SKB_BUFFER at
STACK_VAR(SCRATCH_SIZE) offset), but aside from that it's not supposed to
overlap either.

Thanks,
Daniel

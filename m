From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Jul 2018 22:57:23 +0100
Subject: [PATCH net-next 01/13] ARM: net: bpf: enumerate the JIT scratch
 stack layout
In-Reply-To: <41b5fc68-e15f-56f9-c55b-4f6deb61c54c@iogearbox.net>
References: <20180710123340.GK17271@n2100.armlinux.org.uk>
 <E1fcrsG-0005UK-Un@rmk-PC.armlinux.org.uk>
 <41b5fc68-e15f-56f9-c55b-4f6deb61c54c@iogearbox.net>
Message-ID: <20180710215723.GN17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 08:30:04PM +0200, Daniel Borkmann wrote:
> Hi Russell,
> 
> thanks a lot for your work on the arm32 JIT!
> 
> On 07/10/2018 02:36 PM, Russell King wrote:
> > Enumerate the contents of the JIT scratch stack layout used for storing
> > some of the JITs 64-bit registers, tail call counter and AX register.
> > 
> > XXX: what about the skb_copy_bits buffer - this appears to overlap with
> > the first word of the JITs accessible stack.
> 
> Could you elaborate on that case? Unless I'm missing something there should
> be no use of the skb_copy_bits buffer anymore (aka former SKB_BUFFER at
> STACK_VAR(SCRATCH_SIZE) offset), but aside from that it's not supposed to
> overlap either.

Probably an old comment - these were originally developed back in
January timeframe when there was the SKB_BUFFER stuff, but that was
removed during the 4.18 merge window.  I'll kill the comment.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up

From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 04 Dec 2010 00:49:43 -0500 (EST)
Subject: [PATCH 0/4] Patches to make multi-soc handling in entry-armv.S
	easier
In-Reply-To: <20101204001435.28853.29616.stgit@baageli.muru.com>
References: <20101204001435.28853.29616.stgit@baageli.muru.com>
Message-ID: <alpine.LFD.2.00.1012040040590.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Dec 2010, Tony Lindgren wrote:

> Hi all,
> 
> I've got some patches almost ready to go to merge the omap1
> configs into a single omap1_defconfig. While working on getting
> that done, I had to come up with a better solution for entry-armv.S
> macros to detect the soc we're running on.
> 
> I suggest we add asm_irq_base and asm_irq_flags as in the first
> patch in this series does. This way we can do the soc based detection
> in init_irq or similar place. This might help also the multi-arm
> work too.

Did you see Eric Miao's patch series that introduces runtime IRQ demux 
handler support?

http://www.spinics.net/linux/lists/arm-kernel/msg92836.html

That is likely to be a better solution.


Nicolas

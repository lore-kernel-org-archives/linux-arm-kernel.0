From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 2 Sep 2011 14:58:54 -0400 (EDT)
Subject: testing-board branch: rebase to RMK's devel-stable?
In-Reply-To: <alpine.LFD.2.00.1109021446300.20358@xanadu.home>
References: <87vcta7r9f.fsf@ti.com>
	<alpine.LFD.2.00.1109021446300.20358@xanadu.home>
Message-ID: <alpine.LFD.2.00.1109021448120.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Sep 2011, Nicolas Pitre wrote:

> On Fri, 2 Sep 2011, Kevin Hilman wrote:
> 
> > Hi Tony,
> > 
> > Your testing-board branch currently has a couple new boards that are
> > missing the boot_params to atag_offset conversion (patch below.)
> > 
> > There's a patch below to fix this, but maybe it's better to just rebase
> > your testing-board branch onto Russell's devel-stable branch (where he's
> > merged the seris from Nico) so any board stuff we add is sure to do it
> > correctly.
> 
> I would suggest that too.

Better yet, if your bootloader does pass the address of the ATAG list 
via r2 already (contemporary u-Boot versions do) then the 
boot_params/atag_offset entry is redundant and can simply be dropped 
upfront.


Nicolas

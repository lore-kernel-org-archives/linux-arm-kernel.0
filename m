From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 23 Oct 2012 07:44:55 +0200
Subject: [PATCH 3/5] arm: mvebu: Added IPI support via doorbells
In-Reply-To: <20121023071419.222c46d3@skate>
References: <1350925368-24243-1-git-send-email-gregory.clement@free-electrons.com>
 <1350925368-24243-4-git-send-email-gregory.clement@free-electrons.com>
 <20121022173028.GM21046@lunn.ch>
 <50859976.6080601@free-electrons.com>
 <20121022200708.GO21046@lunn.ch>
 <5085B666.1040500@free-electrons.com>
 <20121023071419.222c46d3@skate>
Message-ID: <20121023054455.GP21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 07:14:19AM +0200, Thomas Petazzoni wrote:
> 
> On Mon, 22 Oct 2012 23:11:02 +0200, Gregory CLEMENT wrote:
> 
> > The correct explanation is that the offset +21070 is a CPU virtual offset.
> > That means that depending of the CPU core which will access to this register,
> > the controller will internally change the offset automagically to point the
> > correct offset.
> > 
> > I should have added an explanation in the commit log. I will do it for V2.
> 
> Just to expand on Gr??gory's comment: there is per-CPU banking for the
> interrupt controller registers. At 0x21070, you have "virtual"
> registers that automatically map to the interrupt controller registers
> of the current CPU. At 0x21870, you have the interrupt controllers
> registers of CPU0, regardless of which CPU you are running on.
> 
> Before this patch set, there was no SMP support for Armada 370/XP, so
> accessing the interrupt controller registers at 0x21870 was OK
> (accessing them from 0x21070 would have been OK as well). With the
> introduction of SMP support, accessing them from 0x21870 no longer
> works, so we switch to the virtual registers at 0x21070.
> 
> In other words: no it is not a bug fix and it therefore doesn't need to
> go into 3.7.

Hi Thomas

Thanks for the clear reply. Does the binding documentation make this
clear? Should it be extended to indicate which address range should be
used?

  Thanks
	Andrew

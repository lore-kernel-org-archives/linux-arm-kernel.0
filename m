From: simon@sequanux.org (Simon Guinot)
Date: Wed, 20 Oct 2010 08:48:26 +0000
Subject: net{space,xbig} TCLK determination
In-Reply-To: <20101020050820.GD12979@mail.wantstofly.org>
References: <20101020050820.GD12979@mail.wantstofly.org>
Message-ID: <20101020084826.GK29120@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lennert,

On Wed, Oct 20, 2010 at 07:08:20AM +0200, Lennert Buytenhek wrote:
> Hi,
> 
> The net{space,xbig} board support files have this:
> 
> 	static void netspace_v2_timer_init(void)
> 	{
> 		kirkwood_tclk = 166666667;
> 		orion_time_init(IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
> 	}
> 
> This is a pretty ugly hack -- if kirkwood_find_tclk() is not
> determining the right TCLK on these boards, then that would be the
> real bug, and it should be fixed there, and not by putting hacks
> like these in board support files.

In the Marvell LSP, TCLK detection is based on the Sample at Reset
Register bit 21. There is no description about this bit usage in the
Kirkwood functional specification document.
The given result _seems_ to be correct for the boards on my desk, but
I have no idea how this way is reliable...

I simply don't have the needed platform knowledge to solve this issue.
So, if you want me to fix kirkwood_find_tclk(), you will have to give
more hints.

The lacie_v2_timer_init() function is maybe a ugly hack but that is
the only I found. My concern was to avoid breaking TCLK detection for
other boards.

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101020/a2471756/attachment.sig>

From: horms@verge.net.au (Simon Horman)
Date: Sun, 26 May 2013 08:22:57 +0900
Subject: [PATCH v2] ARM: shmobile: BOCK-W: add Ether support
In-Reply-To: <51A0FE23.4090206@cogentembedded.com>
References: <201305170141.59791.sergei.shtylyov@cogentembedded.com>
 <20130525053007.GA9293@verge.net.au>
 <51A0FE23.4090206@cogentembedded.com>
Message-ID: <20130525232257.GA24131@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 25, 2013 at 10:08:35PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 25-05-2013 9:30, Simon Horman wrote:
> 
> >>Register Ether device from bockw_init(), passing the platform data to it, adding
> >>only the RMII pin group to bockw_pinctrl_map[].  Although the LINK signal exists
> >>on the board, it's connected to the link/activity LED  output of the PHY, thus
> >>the link disappears and reappears after each packet. We'd be better off ignoring
> >>such signal and getting the link state from the PHY indirectly.
> 
> >>Also, Ether has pin conflict with VIN1, so the latter is not registered when the
> >>'sh_eth' driver is enabled now.
> 
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>
> >>---
> >>The patch is atop of Simon's 'renesas.git' repo, 'renesas-next-20130515v2' tag
> >>and my recent yet unapplied patches.
> 
> >>Note that it's compile and run time dependent on the current Linus' tree.
> 
> >>Changes from the original posting:
> >>- refreshed the patch.
> 
> >Thanks, would it be possible for you to rebase it on top of
> >renesas-next-20130523.
> 
>    You mean to base it on this tag without any intervening patches
> (it is now on top of my patch series)? Anyway, I'll rebase my whole
> series on this tag as I have time (I'm now working with the SATA
> driver to try to add to it NCQ support and fixing errors I encounter
> on the way).

In general I would prefer for you to post patches that are based on my tree
without any intervening patches as it makes it significantly easier for me
to apply them.

> >renesas-next-20130523 is based on v3.10-rc2, so I think it should
> >have whatever dependencies that were in Linus's tree at the time
> >that you posted this patch.
> 
>     Yes, correct.
> 
> WBR, Sergei
> 

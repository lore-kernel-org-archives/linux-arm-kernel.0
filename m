From: horms@verge.net.au (Simon Horman)
Date: Thu, 17 Oct 2013 15:06:12 +0900
Subject: [PATCH v2 4/4] ARM: shmobile: BOCK-W reference: add Ether PFC
 settings
In-Reply-To: <525F0B8A.7040703@cogentembedded.com>
References: <201309070423.30672.sergei.shtylyov@cogentembedded.com>
 <201309070431.35908.sergei.shtylyov@cogentembedded.com>
 <CANqRtoRKFoS9tehteDGaTUYJ8fSBqAYJJDiLxZmoNB9W0N+Mpg@mail.gmail.com>
 <52305EA4.1060902@cogentembedded.com>
 <20130925044720.GB24243@verge.net.au>
 <5243073C.8070402@cogentembedded.com>
 <20130926015142.GB18396@verge.net.au>
 <52449CA2.8040509@cogentembedded.com>
 <20130927043836.GB16541@verge.net.au>
 <525F0B8A.7040703@cogentembedded.com>
Message-ID: <20131017060611.GC9034@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 01:56:26AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 09/27/2013 08:38 AM, Simon Horman wrote:
> 
>    Sorry for the very late reply: I was busy with other stuff and
> then had ~2 weeks of vacations...
> 
> >>>>>>>>Add the Ether pin group to bockw_pinctrl_map[].
> 
> >>>>>>>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >>>>>>>>---
> >>>>>>>>  arch/arm/mach-shmobile/board-bockw-reference.c |    3 +++
> >>>>>>>>  1 file changed, 3 insertions(+)
> 
> >>>>>>>>Index: renesas/arch/arm/mach-shmobile/board-bockw-reference.c
> >>>>>>>>===================================================================
> >>>>>>>>--- renesas.orig/arch/arm/mach-shmobile/board-bockw-reference.c
> >>>>>>>>+++ renesas/arch/arm/mach-shmobile/board-bockw-reference.c
> >>>>>>>>@@ -29,6 +29,9 @@
> >>>>>>>>   */
> >>>>>>>>
> >>>>>>>>  static const struct pinctrl_map bockw_pinctrl_map[] = {
> >>>>>>>>+       /* Ether */
> >>>>>>>>+       PIN_MAP_MUX_GROUP_DEFAULT("fde00000.ethernet", "pfc-r8a7778",
> >>>>>>>>+                                 "ether_rmii", "ether"),
> >>>>>>>>         /* SCIF0 */
> >>>>>>>>         PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
> >>>>>>>>                                   "scif0_data_a", "scif0"),
> 
> >>>>>>>Hi Sergei,
> 
> >>>>>>>Thanks for your patches. In general I think your series looks fine. I
> >>>>>>>have a single comment, and that's about the pinctrl-related hunk
> >>>>>>>above. I can see that this patch is for DT reference for Bock-W, so I
> >>>>>>>expect the code to be in DT. Do you have any plans to use DT to
> >>>>>>>describe the pinmux bits? Perhaps you have some incremental patch
> >>>>>>>planned?
> 
> >>>>>>    No, I just repeated what I saw mechanically. Now I'm seeing some
> >>>>>>evidence that PFC driver supports the device tree, so I probably
> >>>>>>need to redo the patchset... let me study this question better.
> 
> >>>>>Ping.
> 
> >>>>    Sorry, I got distracted by other work and didn't advance much here.
> >>>>Will try to respin the patchset before my vacation (next Monday).
> >>>>Although the driver DT support patch have seemingly stalemated due
> >>>>to the most recent comments...
> 
> >>>Thanks for the update.
> 
> >>>I guess the key is to move forward on the driver side, somehow.
> 
> >>    Do you mean we should grant Stephen's requests concerning clock
> >>DT support before we add the DT support to the driver?
> 
> >That seems like the most logical way forwards to me.
> 
>    Why? Why R-Car I2C driver device tree support was accepted
> without this, although the driver uses clocks directly? Why such
> discrimination is applied only to the Ethernet driver?

That is a good point. Have you made it to Stephen.

My point was to point out where I feel the path of least resistance is
and thus a possible avenue for you to pursue. The exact path you take
to reach your goal isn't of particular interest to me. What is of interest
to me is that you get there somehow :)

> >Is the main issue that the clocks aren't accessible via DT at this time?
> 
>    In the eyes of Stephen, yes.

Thanks, to be honest I was not entirely clear about this.

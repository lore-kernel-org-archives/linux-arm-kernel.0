From: yehuday@marvell.com (Yehuda Yitschak)
Date: Tue, 8 Jan 2013 09:15:57 +0200
Subject: [PATCH V2] arm: mvebu: Improve the SMP support of the interrupt
 controller
In-Reply-To: <50EB3916.7040205@free-electrons.com>
References: <1354740203-26665-1-git-send-email-gregory.clement@free-electrons.com>
 <20130107175123.GO5075@titan.lakedaemon.net>
 <50EB348D.8000607@free-electrons.com>
 <20130107210331.GR5075@titan.lakedaemon.net>
 <50EB3916.7040205@free-electrons.com>
Message-ID: <2E2747FC8980BB40958FB06A958ED3550144C349E7C1@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Well, I also tested this patch, so...

Tested-by: Yehuda Yitschak <yehuday@marvell.com>

> -----Original Message-----
> From: Gregory CLEMENT [mailto:gregory.clement at free-electrons.com]
> Sent: Monday, January 07, 2013 11:08 PM
> To: Jason Cooper
> Cc: Thomas Petazzoni; Andrew Lunn; Yehuda Yitschak; Jani Monoses; Ike
> Pan; Tawfik Bayouk; Arnd Bergmann; Nicolas Pitre; Dan Frazier; Chris Van
> Hoof; David Marlin; Eran Ben-Avi; Nadav Haklai; Maen Suleiman; Lior
> Amsalem; Shadi Ammouri; Jon Masters; Olof Johansson; Leif Lindholm; linux-
> arm-kernel at lists.infradead.org; Sebastian Hesselbarth
> Subject: Re: [PATCH V2] arm: mvebu: Improve the SMP support of the
> interrupt controller
> 
> On 01/07/2013 10:03 PM, Jason Cooper wrote:
> > On Mon, Jan 07, 2013 at 09:48:13PM +0100, Gregory CLEMENT wrote:
> >> On 01/07/2013 06:51 PM, Jason Cooper wrote:
> >>> On Wed, Dec 05, 2012 at 09:43:23PM +0100, Gregory CLEMENT wrote:
> >>>> This patch makes the interrupt controller driver more SMP aware for
> >>>> the Armada XP SoCs. It adds the support for the per-CPU irq. It
> >>>> also adds the implementation for the set_affinity hook.
> >>>>
> >>>> Patch initialy wrote by Yehuda Yitschak and reworked by Gregory
> >>>> CLEMENT.
> >>>>
> >>>> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
> >>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-
> electrons.com>
> >>>> ---
> >>>>  arch/arm/boot/dts/armada-xp.dtsi        |    2 +-
> >>>>  arch/arm/mach-mvebu/irq-armada-370-xp.c |   52
> +++++++++++++++++++++++++++++++
> >>>>  2 files changed, 53 insertions(+), 1 deletion(-)
> >>>
> >>> Applied to mvebu/boards
> >>
> >> Hi Jason,
> >> thanks for taking this patch. Unfortunately it won't be enough.
> >> Indeed after speaking with Marvell engineers we realized that the
> >> MPIC didn't work as we expected. As it is written in the following
> >> patch: the MPIC, unlike the GIC, allows several CPUs to acknowledge
> >> the same global interrupt.
> >>
> >> I joined the patch to this email, you can apply it on top of your
> >> mvebu/boards or you can squash it with the previous patch.
> >
> > Ok, I'll let this sit for a few days and barring any comments, I'll
> > squash it in with the first patch.  If you could provide some
> > Tested-by's, that would be appreciated.
> 
> I know that Thomas used it, so we can expect his official Tested-by very soon
> :)
> 
> >
> > thx,
> >
> > Jason.
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
> 
> --
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux development, consulting,
> training and support.
> http://free-electrons.com

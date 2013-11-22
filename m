From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 22 Nov 2013 08:44:49 -0500
Subject: [PATCH 1/2] ARM: mvebu: second PCIe unit of Armada XP mv78230
 is only x1 capable
In-Reply-To: <87txf5z666.fsf@natisbad.org>
References: <cover.1383681717.git.arno@natisbad.org>
 <b5f36f547bb12ed4e5398401685523625ca50312.1383681717.git.arno@natisbad.org>
 <20131106154326.27a4cc27@skate> <877gclcsjf.fsf@natisbad.org>
 <20131106181241.GG8308@titan.lakedaemon.net>
 <87txf5z666.fsf@natisbad.org>
Message-ID: <20131122134449.GG29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 12:28:01AM +0100, Arnaud Ebalard wrote:
> Hi Jason,
> 
> Jason Cooper <jason@lakedaemon.net> writes:
> 
> > On Wed, Nov 06, 2013 at 07:08:04PM +0100, Arnaud Ebalard wrote:
> >> Hi,
> >> 
> >> Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:
> >> 
> >> > On Tue, 05 Nov 2013 21:45:48 +0100, Arnaud Ebalard wrote:
> >> >> Various Marvell datasheets advertise second PCIe unit of mv78230
> >> >> flavour of Armada XP as x4/quad x1 capable. This second unit is in
> >> >> fact only x1 capable. This patch fixes current mv78230 .dtsi to
> >> >> reflect that, i.e. makes 1.0 the second interface (instead of 2.0
> >> >> at the moment). This was successfully tested on a mv78230-based
> >> >> ReadyNAS 2120 platform with a x1 device (FL1009 XHCI controller)
> >> >> connected to this second interface.
> >> >> 
> >> >> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> >> >> ---
> >> >>  arch/arm/boot/dts/armada-xp-mv78230.dtsi | 24 ++++++++++++------------
> >> >>  1 file changed, 12 insertions(+), 12 deletions(-)
> >> >
> >> > Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >> 
> >> Thanks for the review of both patches, Thomas. And no relation, but
> >> thanks for 714086029116b6 ;-)
> >> 
> >> > This is actually a bug fix, and the problem exists since commit
> >> > 9d8f44f02d4a5f6e7b8d138ea8f8c6e30ae6e1a3, and therefore in 3.10, 3.11
> >> > and 3.12.
> >> >
> >> > However, while the PCIe DT stuff was merged in 3.10, the actual driver
> >> > itself was only merged in 3.11, so in 3.10, there is no chance to hit
> >> > the bug.
> >> >
> >> > Therefore, having this fix pushed to the stable 3.11.x and 3.12.x trees
> >> > would be good.
> >
> > oops, I forgot to reply to this.  I disagree here.  We shouldn't assume
> > that the dts file used will be from the same commit and the kernel
> > built.  Additionally, it doesn't hurt to backport the change the whole
> > way.
> >
> >> Jason, any action required on my side regarding the relay of the two
> >> patches to stable team or will you handle that once they are in your
> >> tree (or Linus one)?
> >
> > I'll take care of it.
> 
> I may have missed something but I expected those two patches to hit
> Linus tree after 3.12 to be part of 3.13-rc1. Am I just too impatient?

It is a fix, but as (iirc) Thomas mentioned, there is the risk of
breaking existing PCIe boards.  So, I was sitting on it till after
v3.13-rc1 drops.  I'd like for it to have a run in -next and get a few
more Tested-by's before pushing it.

thx,

Jason.

From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 7 Jan 2013 16:03:31 -0500
Subject: [PATCH V2] arm: mvebu: Improve the SMP support of the
 interrupt controller
In-Reply-To: <50EB348D.8000607@free-electrons.com>
References: <1354740203-26665-1-git-send-email-gregory.clement@free-electrons.com>
 <20130107175123.GO5075@titan.lakedaemon.net>
 <50EB348D.8000607@free-electrons.com>
Message-ID: <20130107210331.GR5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 09:48:13PM +0100, Gregory CLEMENT wrote:
> On 01/07/2013 06:51 PM, Jason Cooper wrote:
> > On Wed, Dec 05, 2012 at 09:43:23PM +0100, Gregory CLEMENT wrote:
> >> This patch makes the interrupt controller driver more SMP aware for
> >> the Armada XP SoCs. It adds the support for the per-CPU irq. It also
> >> adds the implementation for the set_affinity hook.
> >>
> >> Patch initialy wrote by Yehuda Yitschak and reworked by Gregory
> >> CLEMENT.
> >>
> >> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >> ---
> >>  arch/arm/boot/dts/armada-xp.dtsi        |    2 +-
> >>  arch/arm/mach-mvebu/irq-armada-370-xp.c |   52 +++++++++++++++++++++++++++++++
> >>  2 files changed, 53 insertions(+), 1 deletion(-)
> > 
> > Applied to mvebu/boards
> 
> Hi Jason,
> thanks for taking this patch. Unfortunately it won't be enough. Indeed
> after speaking with Marvell engineers we realized that the MPIC didn't
> work as we expected. As it is written in the following patch: the MPIC,
> unlike the GIC, allows several CPUs to acknowledge the same global
> interrupt.
> 
> I joined the patch to this email, you can apply it on top of your
> mvebu/boards or you can squash it with the previous patch.

Ok, I'll let this sit for a few days and barring any comments, I'll
squash it in with the first patch.  If you could provide some
Tested-by's, that would be appreciated.

thx,

Jason.

From: gores@marvell.com (Siddarth Gore)
Date: Tue, 23 Mar 2010 18:13:23 +0530
Subject: [PATCH] Kirkwood: Marvell GuruPlug support
In-Reply-To: <i13k77-9sp.ln1@chipmunk.wormnet.eu>
References: <1269250100-31824-1-git-send-email-gores@marvell.com>
	<i13k77-9sp.ln1@chipmunk.wormnet.eu>
Message-ID: <1269348203.23313.198.camel@pe-dt434>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-03-22 at 05:05 -0700, Alexander Clouter wrote:
> Siddarth Gore <gores@marvell.com> wrote:
> >
> > GuruPlug Standard: 1 Gb Ethernet, 2 USB 2.0
> > GuruPlug Plus: 2 Gb Ethernet, 2 USB 2.0, 1 eSATA, 1 uSD slot
> > 
> > References:
> > http://www.globalscaletechnologies.com/t-guruplugdetails.aspx
> > http://plugcomputer.org
> > 
> > This patch is for GuruPlug Plus, but it supports Standard version
> > as well.
> > 
> > Signed-off-by: Siddarth Gore <gores@marvell.com>
> > ---
> > arch/arm/mach-kirkwood/Kconfig          |    6 ++
> > arch/arm/mach-kirkwood/Makefile         |    1 +
> > arch/arm/mach-kirkwood/guruplug-setup.c |  131 +++++++++++++++++++++++++++++++
> > 3 files changed, 138 insertions(+), 0 deletions(-)
> > create mode 100644 arch/arm/mach-kirkwood/guruplug-setup.c
> > 
> > diff --git a/arch/arm/mach-kirkwood/guruplug-setup.c b/arch/arm/mach-kirkwood/guruplug-setup.c
> > new file mode 100644
> > index 0000000..54d07c8
> > --- /dev/null
> > +++ b/arch/arm/mach-kirkwood/guruplug-setup.c
> > @@ -0,0 +1,131 @@
> >
> Any harm in merging this into the sheevaplug-setup code, like the openrd 
> code?
> 
> http://git.marvell.com/?p=orion.git;a=commit;h=b2fdb5660fccc060e47658baad8911a963397ced
> 

No harm as such. but i think having separate setup files will be a
cleaner approach, instead of adding more if(machine_is_<>) statements.

Looks like openrd base/client are same boards with client having an
extra ethernet port. sheevaplug and guruplug are two different boards
(pcb's) having different gpio settings, peripherals, etc.

-siddarth

> Cheers
> 

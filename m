From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 23 Aug 2011 11:33:30 +0800
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <20110822100122.GA2796@pulham.picochip.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-3-git-send-email-robherring2@gmail.com>
	<20110822055534.GA15301@S2100-06.ap.freescale.net>
	<20110822100122.GA2796@pulham.picochip.com>
Message-ID: <20110823033329.GB16416@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

On Mon, Aug 22, 2011 at 11:01:22AM +0100, Jamie Iles wrote:
> Hi Shawn,
> 
> On Mon, Aug 22, 2011 at 01:55:36PM +0800, Shawn Guo wrote:
> > On Tue, Aug 16, 2011 at 03:34:54PM -0500, Rob Herring wrote:
> > > From: Rob Herring <rob.herring@calxeda.com>
> > > 
> > > This adds basic support for the Calxeda Highbank platform.
> > > 
> > > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > > ---
> > [...]
> > > diff --git a/arch/arm/mach-highbank/include/mach/entry-macro.S b/arch/arm/mach-highbank/include/mach/entry-macro.S
> > > new file mode 100644
> > > index 0000000..56be409
> > > --- /dev/null
> > > +++ b/arch/arm/mach-highbank/include/mach/entry-macro.S
> > > @@ -0,0 +1,9 @@
> > > +#include <asm/hardware/gic.h>
> > > +#include <asm/hardware/entry-macro-gic.S>
> > 
> > It seems that the second file already includes the first one.
> 
> It's preferred to use explicit includes.  From 
> Documentation/SubmitChecklist:
> 
> 	1: If you use a facility then #include the file that 
> 	   defines/declares that facility.  Don't depend on other header 
> 	   files pulling in ones that you use.
> 
We should not include it even with above point, because we do not have
anything in entry-macro.S requiring gic.h.

-- 
Regards,
Shawn

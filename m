From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jun 2018 18:09:51 +0100
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile
 machine for no-MMU
In-Reply-To: <nycvar.YSQ.7.76.1806221247210.16670@knanqh.ubzr>
References: <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
 <nycvar.YSQ.7.76.1806211212010.16670@knanqh.ubzr>
 <20180622110145.GU17671@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1806221110140.16670@knanqh.ubzr>
 <CAMuHMdWZPM3Q9fVXWiw1bMVWNRCYGoQa-XukJka-2xsP-=HmVQ@mail.gmail.com>
 <nycvar.YSQ.7.76.1806221146140.16670@knanqh.ubzr>
 <20180622161101.GW17671@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1806221218230.16670@knanqh.ubzr>
 <20180622164012.GX17671@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1806221247210.16670@knanqh.ubzr>
Message-ID: <20180622170951.GY17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 12:54:18PM -0400, Nicolas Pitre wrote:
> On Fri, 22 Jun 2018, Russell King - ARM Linux wrote:
> 
> > On Fri, Jun 22, 2018 at 12:21:33PM -0400, Nicolas Pitre wrote:
> > > On Fri, 22 Jun 2018, Russell King - ARM Linux wrote:
> > > > That is actually incorrect - you're too used to the dynamic fixup of
> > > > virt_to_phys() and friends now!
> > > > 
> > > > Given that XIP is typically used in environments where the kernel text
> > > > is very much unmodifyable, we disable CONFIG_ARM_PATCH_PHYS_VIRT.  When
> > > > disabled, we use a constant translation, based upon the build-time
> > > > CONFIG_PHYS_OFFSET and CONFIG_PAGE_OFFSET settings.
> > > > 
> > > > The early assembler relies upon these settings - which must be known
> > > > before we enable the MMU.  As such, DT parsing is not available to us
> > > > at that point (as we can't run any C code, because we won't be calling
> > > > it at the address it was linked for.)
> > > 
> > > I think you got me wrong.  I meant DT parsing at config or build time, 
> > > not at run time.
> > 
> > That seems backwards and complicated.  It seems this would end up
> > with:
> > 
> > - you configure the kernel
> > - build the dtb files
> > - reconfigure parsing a specific dtb file built in the previous step
> > - build the kernel proper
> 
> ... or just stick the right value manually when prompting for 
> XIP_PHYS_ADDR.  Really, depending on DT is a non issue that only pulls 
> the conversation away from the actual kconfig language limitation that 
> needs to be overcome.

Which is _exactly_ what we do today, so I don't see what point you're
making in this sub-thread.

I thought we were discussing about getting Kconfig to obtain settings
from dtb files.  If you have a point to make, please don't make the
discussion impossible by changing your point, it makes it a waste of
time trying to have a discussion.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

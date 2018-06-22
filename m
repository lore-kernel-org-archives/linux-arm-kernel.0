From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 22 Jun 2018 12:21:33 -0400 (EDT)
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile
 machine for no-MMU
In-Reply-To: <20180622161101.GW17671@n2100.armlinux.org.uk>
References: <20180618141905.7789-1-gerg@linux-m68k.org>
 <20180618141905.7789-5-gerg@linux-m68k.org>
 <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
 <nycvar.YSQ.7.76.1806211212010.16670@knanqh.ubzr>
 <20180622110145.GU17671@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1806221110140.16670@knanqh.ubzr>
 <CAMuHMdWZPM3Q9fVXWiw1bMVWNRCYGoQa-XukJka-2xsP-=HmVQ@mail.gmail.com>
 <nycvar.YSQ.7.76.1806221146140.16670@knanqh.ubzr>
 <20180622161101.GW17671@n2100.armlinux.org.uk>
Message-ID: <nycvar.YSQ.7.76.1806221218230.16670@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Jun 2018, Russell King - ARM Linux wrote:

> On Fri, Jun 22, 2018 at 11:57:32AM -0400, Nicolas Pitre wrote:
> > That is no longer a kernel config/build issue if you the system 
> > integrator put an XIP kernel on a target with the wrong DT.
> > 
> > The XIP kernel does require that you provide the actual memory base 
> > address as a constant to the build system but that could be extracted 
> > directly from the DT data if having a kconfig prompt for that is too 
> > unwieldy. The new kconfig macro language in mainline could even be 
> > leveraged to do that at config time.
> 
> That is actually incorrect - you're too used to the dynamic fixup of
> virt_to_phys() and friends now!
> 
> Given that XIP is typically used in environments where the kernel text
> is very much unmodifyable, we disable CONFIG_ARM_PATCH_PHYS_VIRT.  When
> disabled, we use a constant translation, based upon the build-time
> CONFIG_PHYS_OFFSET and CONFIG_PAGE_OFFSET settings.
> 
> The early assembler relies upon these settings - which must be known
> before we enable the MMU.  As such, DT parsing is not available to us
> at that point (as we can't run any C code, because we won't be calling
> it at the address it was linked for.)

I think you got me wrong.  I meant DT parsing at config or build time, 
not at run time.

Latest mainline allows kconfig files to call out to external programs 
now.


Nicolas

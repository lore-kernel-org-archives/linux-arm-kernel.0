From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Jul 2013 16:19:21 +0100
Subject: Handling ARM_ERRATA_364296 when CONFIG_SMP=y
In-Reply-To: <20130712151434.GF28271@arm.com>
References: <CAOMZO5AVpQ6DUja=usBCDzRH0NyNqbXsHNNOJSAY=8OvgHHTmA@mail.gmail.com>
 <20130712151434.GF28271@arm.com>
Message-ID: <20130712151921.GF24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 04:14:35PM +0100, Catalin Marinas wrote:
> On Mon, Jul 08, 2013 at 07:16:34PM +0100, Fabio Estevam wrote:
> > On commit 145e10e1 (ARM: 7015/1: ARM errata: Possible cache data
> > corruption with hit-under-miss enabled) you added support for
> > ARM_ERRATA_364296 option:
> > 
> > +config ARM_ERRATA_364296
> > +       bool "ARM errata: Possible cache data corruption with
> > hit-under-miss enabled"
> > +       depends on CPU_V6 && !SMP
> > +       help
> > 
> > As this erratum affects mx31/mx35, I would like to enable it, but I am
> > not allowed to do it because mx31/mx35 share the same config file as
> > mx6 (imx_v6_v7_defconfig), which has SMP turned on.
> > 
> > What would be the correct approach for applying this erratum?
> > 
> > Is it safe to do "depends on CPU_V6" only or should this erratum be
> > handled in the bootloader?
> 
> I think you can just remove the !SMP case. The workaround (setting an
> undocumented bit) already checks for the right CPU Id. The only problem
> issue is that oldconfig will ask whether to enable it or not.

Good thing you don't disagree, because it's already on its way to Linus
as of this morning.

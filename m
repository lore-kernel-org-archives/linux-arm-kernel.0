From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Feb 2011 08:15:28 -0800
Subject: [RFC 4/5] ARM: P2V: introduce phys_to_virt/virt_to_phys
	runtime patching
In-Reply-To: <20110105000810.GG24935@n2100.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDPa-00023l-CR@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1101041614090.22191@xanadu.home>
	<20110105000810.GG24935@n2100.arm.linux.org.uk>
Message-ID: <20110207161527.GH20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110104 16:12]:
> On Tue, Jan 04, 2011 at 04:27:37PM -0500, Nicolas Pitre wrote:
> > On Tue, 4 Jan 2011, Russell King - ARM Linux wrote:
> > > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > > index f67e682..7c5499d 100644
> > > --- a/arch/arm/kernel/setup.c
> > > +++ b/arch/arm/kernel/setup.c
> > > @@ -804,7 +804,7 @@ void __init setup_arch(char **cmdline_p)
> > >  	struct machine_desc *mdesc;
> > >  	char *from = default_command_line;
> > >  
> > > -	tags->mem.start = PHYS_OFFSET;
> > > +	init_tags.mem.start = PHYS_OFFSET;
> > 
> > Doesn't this belong in 2/5 instead?
> 
> It's actually the result of using interdiff with the original patch...
> It'll get killed shortly.

For the version in p2v branch:

Tested-by: Tony Lindgren <tony@atomide.com>

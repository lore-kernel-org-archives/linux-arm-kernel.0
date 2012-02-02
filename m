From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 2 Feb 2012 09:32:12 -0800
Subject: [PATCH v1 3/8] ARM: tegra: rework Tegra secondary CPU core bringup
In-Reply-To: <20120127081802.GU29914@tbergstrom-lnx.Nvidia.com>
References: <1327597641-7519-1-git-send-email-pdeschrijver@nvidia.com>
 <1327597641-7519-4-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178CB8246B@HQMAIL01.nvidia.com>
 <20120127081802.GU29914@tbergstrom-lnx.Nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178E124A8B@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Friday, January 27, 2012 1:18 AM:
> On Thu, Jan 26, 2012 at 09:25:53PM +0100, Stephen Warren wrote:
> > Peter De Schrijver wrote at Thursday, January 26, 2012 10:07 AM:
> > > Prepare the Tegra secondary CPU core bringup code for other Tegra variants.
> > > The reset handler is also generalized to allow for future introduction of
> > > powersaving modes which turn off the CPU cores.
> >
> > > diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
> >
> > >  ENTRY(tegra_secondary_startup)
> > ...
> > > +	enable_coresight r0
> >
> > > +ENTRY(__tegra_cpu_reset_handler)
> > > +
> > > +#if DEBUG_CPU_RESET_HANDLER
> > > +	enable_coresight r0
> > > +	b	.
> > > +#endif
> >
> > I'm not sure why the macro call enable_coresight is ifdef'd in one place
> > but not the other... Should just the instruction "b ." be inside the
> > ifdef?
> 
> This code path will also be used by LP2 and LP1 resume in the future, I'm not
> sure we should unconditionally enable Coresight in that case.

What I'm unclear on is why it's a good idea to unconditionally enable
coresight in tegra_secondary_startup if it's not a good idea to
unconditionally enable it in __tegra_cpu_reset_handler.

-- 
nvpublic

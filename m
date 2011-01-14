From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 14 Jan 2011 10:40:12 -0800
Subject: ARM: CPU hotplug: fix hard-coded control register constants
In-Reply-To: <20110114120437.GB15996@n2100.arm.linux.org.uk>
References: <4D303758.4060608@st.com> <4D30386B.7020200@st.com>
	<20110114120437.GB15996@n2100.arm.linux.org.uk>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF03105686C6@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> Sent: Friday, January 14, 2011 5:05 AM
> 
> On Fri, Jan 14, 2011 at 05:20:03PM +0530, viresh kumar wrote:
> ...
> In any case, this code is probably doing the wrong thing - if s5pv310
> is not an ARMv6 MPCore the its fiddling with the auxillary control
> register is already broken.
> 
> > > diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
> > > index 17faf77..a5cb1ce 100644
> > > --- a/arch/arm/mach-tegra/hotplug.c
> > > +++ b/arch/arm/mach-tegra/hotplug.c
> > > @@ -26,13 +26,13 @@ static inline void cpu_enter_lowpower(void)
> > >  	 * Turn off coherency
> > >  	 */
> > >  	"	mrc	p15, 0, %0, c1, c0, 1\n"
> > > -	"	bic	%0, %0, #0x20\n"
> > > +	"	bic	%0, %0, %2\n"
> >
> > here also.
> 
> Same comment.

Just as an FYI, in various downstream trees, that file (for mach-tegra) has
been removed and replaced with completely different code. However, the
replacement isn't in the process of being upstreamed right yet. Specifically:

git://android.git.kernel.org/kernel/tegra.git

linux-tegra-2.6.37

cb8e70bd4fa41ea7ac66f01f7425943db99ac7d3
ARM: tegra: Add suspend and hotplug support

Hope this helps.

-- 
nvpublic

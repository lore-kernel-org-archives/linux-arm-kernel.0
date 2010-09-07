From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Sep 2010 21:56:39 +0100
Subject: [PATCH 07/74] ST SPEAr13XX: Added compilation support in arch/arm/
In-Reply-To: <4C862377.1080507@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<b2e8b6b95ceff7d90032be8cd614787519b5c57c.1283161023.git.viresh.kumar@st.com>
	<20100902162744.GC28968@game.jcrosoft.org>
	<4C862377.1080507@st.com>
Message-ID: <20100907205639.GA22176@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 07, 2010 at 05:05:19PM +0530, viresh kumar wrote:
> On 9/2/2010 9:57 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> > index 9295110..950c045 100644
> >> > --- a/arch/arm/Kconfig
> >> > +++ b/arch/arm/Kconfig
> >> > @@ -1144,11 +1144,13 @@ config SMP
> >> >  	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
> >> >  	depends on EXPERIMENTAL && (REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP ||\
> >> >  		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 ||\
> >> > -		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4)
> >> > +		 ARCH_S5PV310 || ARCH_SPEAR13XX || ARCH_TEGRA || ARCH_U8500 ||\
> >> > +		 ARCH_VEXPRESS_CA9X4)
> > can we get rid of such long list by introducing a HAVE somthing
> > etc....
> 
> 
> I tried to do this, but have some doubts. With this change architectures
> can not disable features selected using select statement.
> So, if i want image without SMP for SPEAr13xx now, i can't do it.
> 
> 
> Please correct me if this is not the right way of doing it.
> 
> regards,
> viresh.
> --------------------------------------
> 
> [PATCH] arch/arm/Kconfig: removing arch/machine dependencies from SMP, LOCAL_TIMERS, HAVE_ARM_SCU AND HAVE_ARM_TWD
> 
> Individual architectures/machines should select SMP, LOCAL_TIMERS, HAVE_ARM_SCU
> AND HAVE_ARM_TWD from there config options

I've already killed most of this off.

From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 1 Mar 2012 12:36:58 -0800
Subject: [PATCH 6/8] ARM: tegra: USB_ULPI needs USB
In-Reply-To: <201203012025.53560.arnd@arndb.de>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <1330630010-11241-7-git-send-email-alan@signal11.us>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE86172C@HQMAIL01.nvidia.com>
 <201203012025.53560.arnd@arndb.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE861741@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote at Thursday, March 01, 2012 1:26 PM:
> On Thursday 01 March 2012, Stephen Warren wrote:
> > Alan Ott wrote at Thursday, March 01, 2012 12:27 PM:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > The USB_ULPI driver is selected by tegra, but can only be
> > > built if at least one of USB or USB_GADGET is enabled.
> > > The kernel fails to link if both are off.
> >
> > > diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> > ...
> > > @@ -10,6 +10,7 @@ config ARCH_TEGRA_2x_SOC
> > ...
> > > +	select USB_GADGET if USB_SUPPORT && !USB
> >
> > I don't believe the Tegra USB driver supports gadget mode at present.
> 
> ok.
> 
> > Would the above be better written as:
> >
> >     select USB if USB_SUPPORT
> 
> That does not look correct either. There is no reason why USB
> can't be disabled with USB_SUPPORT enabled on other platforms.
> 
> Maybe it's better to change the 'select USB_ULPI if USB_SUPPORT'
> into 'select USB_ULPI if USB' instead?

That sounds reasonable.

> Or maybe just don't select
> USB_ULPI to start with and put it into the defconfig instead.

Perhaps USB_EHCI_TEGRA should depend on USB, and select USB_EHCI?

-- 
nvpublic

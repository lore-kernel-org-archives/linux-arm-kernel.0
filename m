From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 20:42:51 +0000
Subject: [PATCH 6/8] ARM: tegra: USB_ULPI needs USB
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BE861741@HQMAIL01.nvidia.com>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <201203012025.53560.arnd@arndb.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE861741@HQMAIL01.nvidia.com>
Message-ID: <201203012042.51936.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Stephen Warren wrote:
> > Or maybe just don't select
> > USB_ULPI to start with and put it into the defconfig instead.
> 
> Perhaps USB_EHCI_TEGRA should depend on USB, and select USB_EHCI?

I think it should, but that is a different issue. All EHCI bus
glues currently depend on USB_EHCI_HCD instead of selecting it.

Changing that would likely break a number of other things that
have come to depend on the current behavior.

	Arnd

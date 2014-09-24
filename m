From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Wed, 24 Sep 2014 18:26:31 +0200
Subject: [PATCH 5/6] arm64, defconfig: Enable PCI
In-Reply-To: <7901403.qjKNmO519a@wuerfel>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
 <1411573068-12952-6-git-send-email-rric@kernel.org>
 <7901403.qjKNmO519a@wuerfel>
Message-ID: <20140924162631.GI31556@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.09.14 18:14:11, Arnd Bergmann wrote:
> On Wednesday 24 September 2014 17:37:47 Robert Richter wrote:
> >  config PCI
> >         bool "PCI support"
> > +       default y
> >         help
> >           This feature enables support for PCIe bus system. If you say Y
> >           here, the kernel will include drivers and infrastructure code
> >           to support PCIe bus devices.
> >  
> > +config PCI_MSI
> > +       def_bool PCI
> > +
> >  config PCI_DOMAINS
> >         def_bool PCI
> 
> There is already a PCI_MSI symbol in drivers/pci/Kconfig. Just select that
> from the PCI symbol above rather than defining a second one.

The intention is not to have a second definition, instead this should
enable the default value just for arm64. Thus I put it to
arch/arm64/Kconfig. Otherwise it would be enabled per default on all
archs.

We could have used select in config ARM64, but I tried to avoid using
select due to the dependency issue and instead implement this with
default-y/depends-on. Doing so it can be manually disabled too.

-Robert

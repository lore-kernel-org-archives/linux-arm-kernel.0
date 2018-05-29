From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 May 2018 18:33:14 +0100
Subject: [RFC 12/13] ARM: dts: ti: add dra71-evm FIT description file
In-Reply-To: <16a6017f-96c8-42d8-38bc-5cdd36d6793f@gmail.com>
References: <1523956215-28154-1-git-send-email-t-kristo@ti.com>
 <1523956215-28154-13-git-send-email-t-kristo@ti.com>
 <20180417092924.GB20335@flint.armlinux.org.uk>
 <ad5ef67d-d566-0034-a7cd-09a549cbd6d7@ti.com>
 <20180417144913.GD5669@atomide.com>
 <43ff3894-a287-1558-687c-40f50712735c@ti.com>
 <20180522200100.GA23937@rob-hp-laptop>
 <16a6017f-96c8-42d8-38bc-5cdd36d6793f@gmail.com>
Message-ID: <20180529173314.GN17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 10:05:37AM -0700, Frank Rowand wrote:
> On 05/22/18 13:01, Rob Herring wrote:
> > I'll tell you up front, I'm not a fan of FIT image (nor uImage, 
> > Android boot image, $bootloader image). If you want a collection of 
> > files and some configuration data, use a filesystem and a text file.

Me neither.

> My gut feel is that using a filesystem and a text file is the easier way
> to create the boot info.  But that also makes applying the overlay(s)
> during early Linux boot (at the point of FDT unflattening) impractical
> (can't access the file system without a driver, the driver depends on
> the devicetree, the devicetree depends upon the overlay).

Why do you want to apply overlays during the kernel boot?  The boot
loader should be providing the kernel with the merged DT to describe
the system that the kernel is running on - it's not the kernel's
job to put that together.

The whole point of DT is to make the kernel _less_ tied to the hardware
and more generic.  If we're going to introduce an entirely new set of
drivers into the kernel to "probe" the hardware to determine which
overlays are required, then that's really defeating the purpose of DT.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

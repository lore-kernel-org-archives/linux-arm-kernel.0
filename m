From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 4 Mar 2013 11:16:01 +0200
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <20130304063436.GB27241@tbergstrom-lnx.Nvidia.com>
References: <512BF81A.3080700@wwwdotorg.org> <201302261023.26939.arnd@arndb.de>
 <20130226113538.GS17833@n2100.arm.linux.org.uk>
 <512CF87A.4090404@wwwdotorg.org>
 <20130226181114.GU17833@n2100.arm.linux.org.uk>
 <5130E757.6090500@wwwdotorg.org>
 <20130304063436.GB27241@tbergstrom-lnx.Nvidia.com>
Message-ID: <20130304091600.GC27241@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 04, 2013 at 07:34:36AM +0100, Peter De Schrijver wrote:
> On Fri, Mar 01, 2013 at 06:37:27PM +0100, Stephen Warren wrote:
> 
> ...
> 
> > Since some of the bits that enable WARs are banked per CPU, the WAR
> > needs to be enabled by code running on each individual CPU, each time
> > it's powered on. When a secure monitor exists, the CPU will boot through
> > it (at least on Tegra, there is a single register that defines the boot
> > vector for all CPUs; I don't know if that fact is ARM-architectural or
> > not), so the secure monitor can apply the WAR if needed. However, when
> > there is no secure monitor and the kernel runs in secure world, the
> > kernel would have to apply those WARs, since the only code that runs is
> > in the kernel.
> > 
> 
> The boot vector register is Tegra specific. At least on OMAP all cores boot
> from ROM afaik.

Nicolas Pitre suggested a slightly different solution to me:

1) Handle CPU0 errata WARs in the bootloader
2) Indicate in device tree if linux is booting in secude mode or non-secure
   mode.
3) Use this information in the kernel to decide how to apply the WARs for
   secondary core bringup and after powerungating.

Cheers,

Peter.

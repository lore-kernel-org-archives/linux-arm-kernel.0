From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Oct 2015 10:35:43 +0100
Subject: All OMAP platforms: MMC is broken
In-Reply-To: <20151008084020.GY23801@atomide.com>
References: <20151006094425.GM23801@atomide.com>
 <20151006150009.GF21626@n2100.arm.linux.org.uk>
 <20151006153710.GS23801@atomide.com>
 <20151007124551.GI21626@n2100.arm.linux.org.uk>
 <20151007132642.GV23801@atomide.com>
 <CAPDyKFoBPEnHuNR_bsrPU6X=q5pHa8cDR7_Ng9xLnLsudymvOg@mail.gmail.com>
 <20151007155206.GX23801@atomide.com>
 <CAPDyKFp5e_pizFSCzeYSM8sXGx6Jewgs2PRB-RQ1iWMM6WMOww@mail.gmail.com>
 <5615A723.6090907@ti.com> <20151008084020.GY23801@atomide.com>
Message-ID: <20151008093543.GA32536@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 01:40:21AM -0700, Tony Lindgren wrote:
> Well the way distros deal with issues like this is have everything
> possible as loadable modules. We should get the regulator_pbiaa
> loaded automatically in that case as long as it's in the dts.. And
> as long as we have the MODULE_DEVICE_TABLE entries right.

Assuming you have a rootfs which doesn't depend on one of those modules,
or an initramfs, and a way to get the built modules into that initial
filesystem.  Automated test boot systems do not have that luxury: the
generation of initramfs is distro specific, and would be very large if
it were to include all possible modules.

Some distros need their initramfs statically configured between "mount
a local rootfs" and "mount a nfs rootfs" and can't be changed once
generated.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

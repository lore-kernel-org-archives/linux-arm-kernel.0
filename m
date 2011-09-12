From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Sep 2011 11:22:49 +0100
Subject: OMAP3503, SMC911x: mac address issue
In-Reply-To: <201109121154.17796.embedded@gmx.net>
References: <201109121154.17796.embedded@gmx.net>
Message-ID: <20110912102249.GB7007@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 11:54:17AM +0200, A.Schallenberg wrote:
> The kernel boot parameters are:
> [    0.000000] Kernel command line: console=ttyO2,115200n8 
> video=omapfb:vram:2M,vram:4M,mode:1024x768 at 60,vxres=1024,vyres=768 
> ip=10.100.100.28:10.100.10.69:10.100.0.1:255.255.0.0:3flex:eth0:none 
> ethaddr=00:E0:18:1B:21:55 root=/dev/nfs rootfstype=nfs

There is no such kernel parameter called 'ethaddr='.  That sounds like
a vendor specific hack somewhere along the lines.

> [    1.958099] eth0: Invalid ethernet MAC address ff:ff:ff:ff:ff:ff. Please
set using ifconfig.

Normally, the MAC address is available either from the device registers,
which the device will load from the attached EEPROM.  It sounds like you
don't have an EEPROM attached, and nothing is programming the registers.
This isn't a combination supported by the driver.

Hence the driver is telling you in the above message how to fix it in
userspace.

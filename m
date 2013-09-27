From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Sep 2013 16:49:31 +0100
Subject: device tree binding documentation outdated
In-Reply-To: <20130927151900.GA12758@n2100.arm.linux.org.uk>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <20130926205906.GT12758@n2100.arm.linux.org.uk>
 <CAOMZO5Dj7o3qBH2hzPFWjepgpt5XR5qKmQorKS6jH_7=gnY5cg@mail.gmail.com>
 <20130927121357.GY12758@n2100.arm.linux.org.uk>
 <20130927132601.GL25146@S2101-09.ap.freescale.net>
 <20130927151900.GA12758@n2100.arm.linux.org.uk>
Message-ID: <20130927154931.GB12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 04:19:00PM +0100, Russell King - ARM Linux wrote:
> brd: module loaded
> loop: module loaded
> imx6dl-pinctrl 20e0000.iomuxc: maps: function enet group enetgrp-4 num 19
> ar8035_phy_fixup()
> libphy: fec_enet_mii_bus: probed
> fec 2188000.ethernet eth0: registered PHC device 0
> 
> So where is the pinctrl settings applied - or more to the point, why
> aren't they being applied?  This would probably explain why ethernet
> doesn't work - I mean, if the pinctrl settings are never written to
> the registers...

I found that.  A typo in the DT file.  pintctrl-names.  Clearly beer
is required.

(And that's also a good argument why we need a schema language to
verify DT bindings against.)

From: simon@sequanux.org (Simon Guinot)
Date: Sat, 11 Sep 2010 14:07:17 +0000
Subject: mv643xx_eth and MDIO bus PM resume
Message-ID: <20100911140717.GA21622@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am trying to get some PM support for Kirkwood machines and I have to
deal with the MDIO bus driver which trigger a kernel crash at resume.

The Kirkwood SoC Ethernet driver is mv643xx_eth and don't use the PAL
machine state. The PHY is handled by calling manually PHY functions.

The problem is that the current mdio_bus_resume() implementation
_always_ start at resume the PAL state machine even if the driver can't
handle that. That's the mv643xx_eth case, which don't provide the
adjust_link() method.

Any hint to fix this issue is welcome.

Thanks in advance.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100911/275adc68/attachment.sig>

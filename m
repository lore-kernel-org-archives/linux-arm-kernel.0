From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Mar 2016 17:39:52 +0000
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <20160322173546.40d24cc2@free-electrons.com>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
Message-ID: <20160322173952.GF2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 05:35:46PM +0100, Thomas Petazzoni wrote:

> Has there been any discussion on whether dynamically adding the MBus
> window is a good idea, as opposed to statically defining it in the
> board .dts ?

> So far, the only driver that was using dynamically allocated MBus is
> the PCIe controller driver, because there is no way in advanced to know
> the number and memory window requirements of the PCIe devices that will
> be connected to the system.

> For all other windows (BootROM, crypto SRAM and more recently network
> related SRAM), we are using statically allocated windows.

Is this a case where we used to use static assignment because we didn't
have a mechanism for dynamic assignment but now have a mechanism for
dynamic assignment?  In other words is there any advantage to doing the
assignments statically given that we can do them dynamically?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160322/340bc518/attachment-0001.sig>

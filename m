From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 29 Mar 2018 16:12:28 +0200
Subject: [PATCH v4 2/6] PCI: aardvark: Fix logic in
 advk_pcie_valid_device()
In-Reply-To: <20180329083946.25970-3-thomas.petazzoni@bootlin.com> (Thomas
 Petazzoni's message of "Thu, 29 Mar 2018 10:39:42 +0200")
References: <20180329083946.25970-1-thomas.petazzoni@bootlin.com>
 <20180329083946.25970-3-thomas.petazzoni@bootlin.com>
Message-ID: <87605ft1gz.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On jeu., mars 29 2018, Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:

> From: Victor Gu <xigu@marvell.com>
>
> The PCI configuration space read/write functions were special casing
                                                                causing?
else I don't get it

> the situation where PCI_SLOT(devfn) != 0, and returned
> PCIBIOS_DEVICE_NOT_FOUND in this case.
>
> However, while this is what is intended for the root bus, it is not
> intended for the child busses, as it prevents discovering devices with
                         buses

> PCI_SLOT(x) != 0. Therefore, we return PCIBIOS_DEVICE_NOT_FOUND only
> if we're on the root bus.
>
Gregory

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Jun 2016 14:34:14 +0200
Subject: [PATCH 1/3] dt-bindings: add DT binding for the Aardvark PCIe
 controller
In-Reply-To: <20160602122405.GG17343@lunn.ch>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160602122405.GG17343@lunn.ch>
Message-ID: <8313817.cgODJZVrao@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 2, 2016 2:24:05 PM CEST Andrew Lunn wrote:
> 
> It is possible to list PCIe devices on the bus here as child
> nodes. I've done this when i needed a phandle to an intel ethernet
> controller on the PCIe bus, which i know is soldered onto the board.
> 
> I think your current implementation simply uses the first child
> node. It would be good to document that ordering is important. It must
> be the first child node, and any pcie devices children must come
> afterwards.

I think some other PCI hosts just move the interrupt-controller
and #interrupt-cells properties into the PCI host node itself,
which avoids the ambiguity here.

	Arnd

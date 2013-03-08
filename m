From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Mar 2013 22:54:29 +0000
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130308194755.GB29435@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130308164804.GR23237@titan.lakedaemon.net>
 <20130308194755.GB29435@obsidianresearch.com>
Message-ID: <201303082254.29762.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 March 2013, Jason Gunthorpe wrote:
> Future patches could support fully dyanmic window address assignment,
> but I'm honestly having a hard time seeing a use case for this..

The main advantage I can see for going fully dynamic is that we can use
a larger aperture and more windows for PCIe on systems that don't use
all of the other windows from the ${SOC}.dtsi file. If we don't have
a NAND chip connected, the ${BOARD}.dts file can easily mark the nand
controller node as status="disabled" and we don't have to give it a
physical address.

It's not a strong reason, but I think it's nice and clean to assign
the windows automatically and exactly for the hardware that we are
going to use.

	Arnd

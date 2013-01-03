From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 Jan 2013 15:56:31 +0000
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
Message-ID: <201301031556.31618.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 January 2013, Thierry Reding wrote:
> Stephen proposed drivers/pci/host on IRC and I second that.

Agreed, I like that, too. There is a little problem with cross-platform
PCI hosts still because some portion of the interface is still arch
specific, but I don't see this as a show-stopper for moving drivers
there. The ARM specific drivers can still use the ARM interfaces
for now, until everything is made generic. If they are going to
be shared with other architectures, those can use the same interfaces
that ARM has. I think Microblaze, ARC and Metag are strong candidates
for doing this.

	Arnd

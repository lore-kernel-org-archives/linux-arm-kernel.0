From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Feb 2013 18:03:12 +0000
Subject: [PATCH 06/32] arm: pci: add a align_resource hook
In-Reply-To: <1360686546-24277-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201302121803.12660.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 February 2013, Thomas Petazzoni wrote:
> The PCI specifications says that an I/O region must be aligned on a 4
> KB boundary, and a memory region aligned on a 1 MB boundary.
> 
> However, the Marvell PCIe interfaces rely on address decoding windows
> (which allow to associate a range of physical addresses with a given
> device), and those have special requirements compared to the standard
> PCI-to-PCI bridge specifications.

I'm not convince that we should add this complexity yet, until everyone
agrees on the basic approach taken.

	Arnd

From: will.deacon@arm.com (Will Deacon)
Date: Tue, 14 Jul 2015 12:00:39 +0100
Subject: [PATCH] arm64: Define HAVE_ARCH_PIO_SIZE and related symbols.
In-Reply-To: <1436823096-24059-1-git-send-email-ddaney.cavm@gmail.com>
References: <1436823096-24059-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20150714110039.GC16213@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 10:31:36PM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Needed to make pci_iomap() work.

Care to elaborate?

AFAICT, mapping an IO bar on arm64 just gives you back a VA into our
PCI_IOBASE region and the ioreadX accessors will just call the readX
macros, so there should be no need for further port adjustment.

Will

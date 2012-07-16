From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Jul 2012 09:17:09 +0000
Subject: [PATCH v2 00/15] PCI io.h clean-up
In-Reply-To: <20120716075214.GA2489@lunn.ch>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <20120716075214.GA2489@lunn.ch>
Message-ID: <201207160917.09875.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 July 2012, Andrew Lunn wrote:
> The changes you made for Orion decreased the window to 64K. However, i
> see here that PCI0 only gets 60K, where as PCI1 gets the full 64K.
> 
> Is this asymmetry correct?
> 
> I see this for both orion5x and kirkwood.

The range from 0x0-0xfff is used for ISA-style devices, including those
behind a PCI bridge or emulating one like a VGA text console or an
IDE controller. We set PCIBIOS_MIN_IO to 0x1000 to avoid conflicts
between those and dynamically probed PCI devices that we might otherwise
put in the same range.

	Arnd

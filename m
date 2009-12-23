From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Dec 2009 16:50:09 +0000
Subject: Amba device porting
In-Reply-To: <20091223101902.GA15537@nokia.com>
References: <20091223101902.GA15537@nokia.com>
Message-ID: <20091223165009.GA13900@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2009 at 12:19:02PM +0200, Roman wrote:
> Hi,
> 
> I planned to port the omap3 SDTI (Serial Debug Trace Interface) driver to amba based interface.
> 
> SDTI memory map is two parts composed:
> 0x54500000 0x5450FFFF 4KB       SDTI module (configuration) - coresight based format.
> 0x54510000 0x545FFFFF 1984KB    Reserved
> 0x54600000 0x546FFFFF 1MB       SDTI module (window)
> 
> But amba interface seems to support only one memory region resource.

The 'amba' interface is more a primecell interface.  Is SDTI a primecell
peripheral?  If not, then it shouldn't be using the AMBA "primecell" bus
support.

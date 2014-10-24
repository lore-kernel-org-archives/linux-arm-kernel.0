From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Oct 2014 15:58:51 +0200
Subject: [PATCH v4] dma: Add Xilinx AXI Direct Memory Access Engine driver
 support
In-Reply-To: <7dc11ef7ccec49bcb052c30b9aa916c3@BL2FFO11FD044.protection.gbl>
References: <1413374436-14410-1-git-send-email-sthokal@xilinx.com>
 <3236720.MHeqOodrCV@wuerfel>
 <7dc11ef7ccec49bcb052c30b9aa916c3@BL2FFO11FD044.protection.gbl>
Message-ID: <1967130.oYyZRWCcEF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 October 2014 12:08:26 Appana Durga Kedareswara Rao wrote:
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> > On Tuesday 21 October 2014 09:06:13 Appana Durga Kedareswara Rao wrote:
> > > The above mentioned API's  and structures will be used by the dma test
> > > client driver's to set hardware configuration information. The dma
> > > client drivers are not mainlined  yet and it is Internally used by
> > > our git-tree  to test the DMA functionality in loopback .
> > 
> > I would suggest you add the test driver into the main dmaengine driver
> > file directly then, so you don't need to export the symbols. If there are
> > important reasons to keep that as separate files, just move the header to
> > the drivers/dma/ directory and add the test driver there.
> 
> Sorry I forgot to mention the below things in the mail .The Config API's and
> structures not only used by the dmaengine driver's but also used by
> the  various IP's  (Ex: Ethernet driver and SRIO driver these drivers are
> under development).For example the Ethernet driver is resides under
> drivers/net/ethernet but it needs to set some specific configuration
> parameters of the dma that's why created a separate header file for the h/w
> configurable parameters.

That is a bug in the ethernet driver, and we should not merge such code.

Please fix those drivers before submitting them, so they don't rely on
additional interfaces beyond what the DMA engine API provides.

If you need something that the common interface is missing, you can
send a patch to extend the dmaengine core driver, but more likely it
already does what you need and you are just not using it right.

	Arnd

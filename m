From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Oct 2014 11:14:55 +0200
Subject: [PATCH v4] dma: Add Xilinx AXI Direct Memory Access Engine driver
 support
In-Reply-To: <ff137744d6474640aab09e5d6f62921a@BN1AFFO11FD019.protection.gbl>
References: <1413374436-14410-1-git-send-email-sthokal@xilinx.com>
 <4301925.4pMHXMXqA4@wuerfel>
 <ff137744d6474640aab09e5d6f62921a@BN1AFFO11FD019.protection.gbl>
Message-ID: <3236720.MHeqOodrCV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 October 2014 09:06:13 Appana Durga Kedareswara Rao wrote:
> The above mentioned API's  and structures will be used by the dma test
> client driver's to set hardware configuration information. The dma
> client drivers are not mainlined  yet and it is
> Internally used by  our git-tree  to test the DMA functionality in loopback .

I would suggest you add the test driver into the main dmaengine driver
file directly then, so you don't need to export the symbols. If there
are important reasons to keep that as separate files, just move the
header to the drivers/dma/ directory and add the test driver there.

	Arnd 

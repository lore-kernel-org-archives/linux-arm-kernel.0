From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 5 Mar 2015 09:34:23 +0000
Subject: [PATCH] dma: xilinx-dma: move header file to common location
In-Reply-To: <20150304120250.GO2613@intel.com>
References: <4c3e2425e14646cb86c20d6aebdcfe22@BY2FFO11FD004.protection.gbl>
 <2793259.VbbYy9Imif@wuerfel> <20150304120250.GO2613@intel.com>
Message-ID: <76fe9f98ad784580abb1dcda93356a7e@BL2FFO11FD011.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Wednesday, March 04, 2015 5:33 PM
> To: Arnd Bergmann
> Cc: linux-arm-kernel at lists.infradead.org; Appana Durga Kedareswara Rao;
> dan.j.williams at intel.com; Michal Simek; Soren Brinkmann; Srikanth Vemula;
> linux-kernel at vger.kernel.org; Anirudha Sarangi;
> dmaengine at vger.kernel.org; Appana Durga Kedareswara Rao
> Subject: Re: [PATCH] dma: xilinx-dma: move header file to common location
>
> On Mon, Mar 02, 2015 at 08:28:01PM +0100, Arnd Bergmann wrote:
> > On Monday 02 March 2015 23:24:24 Kedareswara rao Appana wrote:
> > > This patch moves the xilinx_dma.h header file to the
> > > include/linux/dma.
> > >
> > > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> >
> > Please move this header file to drivers/dma/xilinx/ directly to make
> > it inaccessible by other driver. No driver should pass extra data
> > structures to a dmaengine driver.
> Actually that is not true. Few of the drivers need some additional parameters
> to be set which are not covered by the common set, hence an additional API
> is exposed by this driver to do so...
>
> If ever we could get rid of these...


As I said earlier in the below thread.
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317705.html

Some DMA IP's have a specific features which is not supported by the DMA engine framework.
For those DMA IP's as suggested by Lars (http://www.spinics.net/lists/dmaengine/msg00010.html )
We are exporting that functionality and that functionality may needed by some other IP's that's why the header file should be in common location.

Please let me know if my explanation is not clear to you.

@Vinod: Thanks for the comment. Any functional comments for this patch?

Regards
Kedar.

>
> --
> ~Vinod



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

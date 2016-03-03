From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 3 Mar 2016 16:28:01 +0000
Subject: [PATCH v3 1/4] dmaengine: xilinx_vdma: Improve SG engine handling
In-Reply-To: <20160303153323.GN11154@localhost>
References: <1456495434-11722-1-git-send-email-appanad@xilinx.com>
 <20160303153323.GN11154@localhost>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5679A7@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Thursday, March 03, 2016 9:03 PM
> To: Appana Durga Kedareswara Rao
> Cc: dan.j.williams at intel.com; Michal Simek; Soren Brinkmann; Appana Durga
> Kedareswara Rao; moritz.fischer at ettus.com;
> laurent.pinchart at ideasonboard.com; luis at debethencourt.com; Anirudha
> Sarangi; dmaengine at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v3 1/4] dmaengine: xilinx_vdma: Improve SG engine
> handling
> 
> On Fri, Feb 26, 2016 at 07:33:51PM +0530, Kedareswara rao Appana wrote:
> > The current driver allows user to queue up multiple segments on to a
> > single transaction descriptor. User will submit this single desc and
> > in the issue_pending() we decode multiple segments and submit to SG HW
> engine.
> > We free up the allocated_desc when it is submitted to the HW.
> >
> > Existing code prevents the user to prepare multiple trasactions at
> > same time as we are overwrite with the allocated_desc.
> >
> > The best utilization of HW SG engine would happen if we collate the
> > pending list when we start dma this patch updates the same.
> 
> Applied all. It is usually advisable to do cover letter using --cover-letter for multi
> patch series

Thanks ... Will fix next time onwards...

Regards,
Kedar.

> 
> --
> ~Vinod

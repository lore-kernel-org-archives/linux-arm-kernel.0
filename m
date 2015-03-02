From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 2 Mar 2015 09:04:37 +0000
Subject: [PATCH v4] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <54E70F97.30908@xilinx.com>
References: <1413374436-14410-1-git-send-email-sthokal@xilinx.com>
 <3236720.MHeqOodrCV@wuerfel>
 <7dc11ef7ccec49bcb052c30b9aa916c3@BL2FFO11FD044.protection.gbl>
 <1967130.oYyZRWCcEF@wuerfel>
 <add9a23928b44aa48965e993bb17f53b@BL2FFO11FD027.protection.gbl>
 <20150212093445.GM21387@intel.com>
 <ed439c7a25d0465d9dbf4c06987d42a1@BY2FFO11FD018.protection.gbl>
 <20150220062934.GX21387@intel.com> <54E70F97.30908@xilinx.com>
Message-ID: <d7c0fad223754d6ebb3779312459915a@BL2FFO11FD010.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping !

> -----Original Message-----
> From: Michal Simek [mailto:michal.simek at xilinx.com]
> Sent: Friday, February 20, 2015 4:13 PM
> To: Vinod Koul; Appana Durga Kedareswara Rao
> Cc: Arnd Bergmann; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; Srikanth Vemula; linux-
> kernel at vger.kernel.org; Srikanth Thokala; dmaengine at vger.kernel.org;
> robh+dt at kernel.org; Anirudha Sarangi; grant.likely at linaro.org;
> dan.j.williams at intel.com
> Subject: Re: [PATCH v4] dma: Add Xilinx AXI Direct Memory Access Engine
> driver support
>
> Hi Vinod,
>
> On 02/20/2015 07:29 AM, Vinod Koul wrote:
> > On Sat, Feb 14, 2015 at 02:21:52PM +0000, Appana Durga Kedareswara Rao
> wrote:
> >> Hi Vinod,
> >>
> >>
> >>> -----Original Message-----
> >>> From: Vinod Koul [mailto:vinod.koul at intel.com]
> >>> Sent: Thursday, February 12, 2015 3:05 PM
> >>> To: Appana Durga Kedareswara Rao
> >>> Cc: Arnd Bergmann; linux-arm-kernel at lists.infradead.org;
> >>> devicetree at vger.kernel.org; Srikanth Vemula; linux-
> >>> kernel at vger.kernel.org; Srikanth Thokala; dmaengine at vger.kernel.org;
> >>> robh+dt at kernel.org; Michal Simek; Anirudha Sarangi;
> >>> grant.likely at linaro.org; dan.j.williams at intel.com
> >>> Subject: Re: [PATCH v4] dma: Add Xilinx AXI Direct Memory Access
> >>> Engine driver support
> >>>
> >>> On Thu, Jan 29, 2015 at 11:24:41AM +0000, Appana Durga Kedareswara
> >>> Rao
> >>> wrote:
> >>>>>  Earlier in the driver we are embedding dma_slave_config into
> >>>>> custom structs But Lars suggested to modify it. please refer to
> >>>>> the below thread for more details.
> >>>>>  http://www.spinics.net/lists/dmaengine/msg00010.html
> >>>>>
> >>>>>  And later we thought of creating a separate private member in
> >>>>> dma_slave_config for sharing additional configuration between
> >>>>> slave device and dma engine Or a new dma_ctrl_cmd like
> >>>>>
> >>>
> FSLDMA_EXTERNAL_START(http://www.kernelhub.org/?msg=405535&p=2 )
> >>>>>
> >>>>>  Finally Vinod was ok with the existing suggestion so we dropped
> >>>>> the above thought.
> >>>>>
> >>>>>  @Vinod : Could you please comment on this.
> >>> FSLDMA_EXTERNAL_START has been removed, and you cna use the
> removal
> >>> as a guidance of how to solve your issue
> >>>
> >>
> > Please limit you mailer to set wrap at 80 chars, otherwise it becomes
> > unreadable
> >
> >> The current VDMA driver that got merged in the open source and the
> >> current patch (dma: xilinx dma v4) Srikanth T submitted both contains
> >> the Similar implementation that you pointed as above(I mean similar
> >> to the free scale dma driver).
> >>
> >> The discussion starts here is why we need the header
> >> file(Xilinx_dma.h) in the include/linux/amba/Xilinx_dma.h  folder.
> >>
> >> Like for FSL DMA it is got defined (fsl_dma_external_start) as a
> >> function prototype in include/linux/fsldma.h And it is being getting
> >> used in the drivers/misc/carma/carma-fpga-program.c
> >>
> >> Similarly in the Xilinx VDMA driver(xilinx_vdma_channel_set_config )
> >> defined as a function prototype in the
> >> include/linux/amba/xilinx_dma.h And is being used by Xilinx videos
> >> drivers.  Those video driver need to use the
> >> (xilinx_vdma_channel_set_config) which requires this global header file.
> >>
> >> Could you please suggest us whether that header file (Xilinx_dma.h)
> >> should be there  in include/linux/amba or we should move it to
> include/linux?
> >> And any functional comments for this v4 patch?
> > Let me ask you a question, what is the relation of xilinx_dma with amba?
> >
> > If none then only include/linux/ seems to be the right choice. If not
> > then amba maybe okay but you need to provide justfication why it should
> be in amba?
>
> I see your point. I think there is real reason to have this header in amba.
> The reason for that was that xilinx_dma.h was added there.
>
> Anyway there is include/linux/dma/ folder. Is it ok to move xilinx_dma.h
> there too? The same with this dma one.
>
> Thanks,
> Michal
>



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

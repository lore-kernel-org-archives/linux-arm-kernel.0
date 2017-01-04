From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 4 Jan 2017 06:57:05 +0000
Subject: [PATCH v2 2/3] dmaeninge: xilinx_dma: Fix bug in multiple frame
 stores scenario in vdma
In-Reply-To: <a8f5c216-cac0-daf9-a880-3820ae9b5e13@synopsys.com>
References: <1482483135-14767-1-git-send-email-appanad@xilinx.com>
 <1482483135-14767-3-git-send-email-appanad@xilinx.com>
 <a269409d-103e-1650-5df6-cc8743ed62cf@synopsys.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A65FFE9@XAP-PVEXMBX01.xlnx.xilinx.com>
 <45807619-bf6a-0174-c102-12c03aeb575c@synopsys.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A66012C@XAP-PVEXMBX01.xlnx.xilinx.com>
 <a8f5c216-cac0-daf9-a880-3820ae9b5e13@synopsys.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A660647@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jose Miguel Abreu,

	Thanks for the review...

> >> If so then there is no race condition, but the HW image that I have
> >> does not have this register enabled so I was getting this result
> >> (memory corruption because not all framebuffers had addresses set).
> > Thanks for the explanation.
> > Agree the issue that you mentioned won't come when
> > XILINX_DMA_REG_FRMSTORE
> > (C_ENABLE_DEBUG_INFO_5 and C_ENABLE_DEBUG_INFO_13) Register is
> enabled in the IP.
> > But this register won't get enabled with the default IP configuration
> (C_ENABLE_DEBUG_INFO_5 and C_ENABLE_DEBUG_INFO_13).
> >
> > When user is not enabled XILINX_DMA_REG_FRMSTORE in the h/w and
> submits frames less than h/w capable.
> > The solution that I am thinking is to throw an error in the driver
> > saying that either enable the num frame store feature in the IP or submit the
> frames up to h/w capable what do you think???
> 
> Sounds fine by me.

Thanks posted the v3 series please review when you have some time...

Regards,
Kedar.

> 
> Best regards,
> Jose Miguel Abreu
> 
> >
> > Regards,
> > Kedar.
> >
> >> Best regards,
> >> Jose Miguel Abreu
> >>
> >>> Regards,
> >>> Kedar.
> >>>
> >>>> Best regards,
> >>>> Jose Miguel Abreu
> >>>>

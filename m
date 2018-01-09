From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 9 Jan 2018 10:34:50 +0530
Subject: [PATCH v2 1/4] dmaengine: xilinx_dma: populate dma caps properly
In-Reply-To: <CY1PR02MB1692292DE4B4F346B92BD4EBDC100@CY1PR02MB1692.namprd02.prod.outlook.com>
References: <1514961731-1916-1-git-send-email-appanad@xilinx.com>
 <1514961731-1916-2-git-send-email-appanad@xilinx.com>
 <20180108103845.GE18649@localhost>
 <CY1PR02MB1692EB7A4E66BA30A8E0DB45DC130@CY1PR02MB1692.namprd02.prod.outlook.com>
 <20180108170655.GJ18649@localhost>
 <CY1PR02MB16922B2D20C958D8214F7A23DC130@CY1PR02MB1692.namprd02.prod.outlook.com>
 <20180109044858.GN18649@localhost>
 <CY1PR02MB1692292DE4B4F346B92BD4EBDC100@CY1PR02MB1692.namprd02.prod.outlook.com>
Message-ID: <20180109050449.GO18649@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 04:48:10AM +0000, Appana Durga Kedareswara Rao wrote:
> Hi,
> 
> >On Mon, Jan 08, 2018 at 05:25:01PM +0000, Appana Durga Kedareswara Rao
> >wrote:
> >> Hi,
> >>
> >> <Snip>
> >> >> >> +	xdev->common.dst_addr_widths = BIT(addr_width / 8);
> >> >> >> +	xdev->common.src_addr_widths = BIT(addr_width / 8);
> >> >> >
> >> >> >Do you not support trf of 1byte, 2 bytes, or 4 bytes wide transfers?
> >> >> >What is value of addr_width here typically? Usually controllers
> >> >> >can support different widths and this is a surprise that you
> >> >> >support only one value
> >> >>
> >> >> Controller supports address width of 32 and 64.
> >> >
> >> >Then this should have both 32 and 64 values here
> >>
> >> Address width is configurable parameter at the h/w level.
> >> Since this IP is a soft IP user can create a design with either 32-bit
> >> or 64-bit address configuration.
> >
> >and not both right?
> 
> Yes not both at the same time... 
> Axi dma controller can be configured for either 32-bit or 64-bit address...

So my suspicion was correct.  I would suggest you to read up on the
documentation again. The src/dst_addr_widths has _nothing_ to do with 32/64
bit addresses used.

It is the capability of the dma controller to do transfers with data width as
8bits, 16 bits, so on. iKey is "data width" and not address type.
This typically translates to DMA FIFO configuration of the controller!

-- 
~Vinod

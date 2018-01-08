From: appanad@xilinx.com (Appana Durga Kedareswara Rao)
Date: Mon, 8 Jan 2018 17:25:01 +0000
Subject: [PATCH v2 1/4] dmaengine: xilinx_dma: populate dma caps properly
In-Reply-To: <20180108170655.GJ18649@localhost>
References: <1514961731-1916-1-git-send-email-appanad@xilinx.com>
 <1514961731-1916-2-git-send-email-appanad@xilinx.com>
 <20180108103845.GE18649@localhost>
 <CY1PR02MB1692EB7A4E66BA30A8E0DB45DC130@CY1PR02MB1692.namprd02.prod.outlook.com>
 <20180108170655.GJ18649@localhost>
Message-ID: <CY1PR02MB16922B2D20C958D8214F7A23DC130@CY1PR02MB1692.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

<Snip>
>> >> +	xdev->common.dst_addr_widths = BIT(addr_width / 8);
>> >> +	xdev->common.src_addr_widths = BIT(addr_width / 8);
>> >
>> >Do you not support trf of 1byte, 2 bytes, or 4 bytes wide transfers?
>> >What is value of addr_width here typically? Usually controllers can
>> >support different widths and this is a surprise that you support only
>> >one value
>>
>> Controller supports address width of 32 and 64.
>
>Then this should have both 32 and 64 values here

Address width is configurable parameter at the h/w level.
Since this IP is a soft IP user can create a design with either 
32-bit or 64-bit address configuration. 
Currently we are reading this configuration through device-tree (xlnx, addr-width property) 
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git/tree/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt#n19
Based on the h/w configuration setting the dst_addr_widths/src_addr_widths variables in this patch.
Please let me know if you are still not clear with my explanation will explain in detail... 

Regards,
Kedar.

>
>> addr_width typical values are 32-bit or 64-bit .
>> Here addr_width is device-tree parameter...
>> my understanding of src_addr_widths/dst_addr_widths is, it is a bit
>> mask of the address with in bytes that DMA supports, please correct if my
>understanding is wrong.
>>
>> Regards,
>> Kedar.
>>
>> >
>> >--
>> >~Vinod
>
>--
>~Vinod

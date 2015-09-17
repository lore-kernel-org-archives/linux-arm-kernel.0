From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Thu, 17 Sep 2015 10:17:46 -0700
Subject: [PATCH 6/6] dmaengine: xilinx: Fix module autoload for OF
 platform driver
In-Reply-To: <2273902.ke3oao0baF@avalon>
References: <20150916210017.GA5933@goodgumbo.baconseed.org>
 <2273902.ke3oao0baF@avalon>
Message-ID: <CAAtXAHeRxP+HLCVaLO9Eg8V_CHBBPLb71qi2HeWP1yUiOx2iYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 11:14 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 16 September 2015 23:00:17 Luis de Bethencourt wrote:
>> This platform driver has a OF device ID table but the OF module
>> alias information is not created so module autoloading won't work.
>>
>> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
>
>> ---
>>  drivers/dma/xilinx/xilinx_vdma.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_vdma.c
>> b/drivers/dma/xilinx/xilinx_vdma.c index d8434d4..6f4b501 100644
>> --- a/drivers/dma/xilinx/xilinx_vdma.c
>> +++ b/drivers/dma/xilinx/xilinx_vdma.c
>> @@ -1349,6 +1349,7 @@ static const struct of_device_id xilinx_vdma_of_ids[]
>> = { { .compatible = "xlnx,axi-vdma-1.00.a",},
>>       {}
>>  };
>> +MODULE_DEVICE_TABLE(of, xilinx_vdma_of_ids);
>>
>>  static struct platform_driver xilinx_vdma_driver = {
>>       .driver = {
>
> --
> Regards,
>
> Laurent Pinchart
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Cheers,

Moritz

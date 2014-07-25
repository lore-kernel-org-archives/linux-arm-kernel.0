From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 25 Jul 2014 10:46:59 +0200
Subject: [PATCH v2 07/11] Documentation: devicetree: Fix Xilinx VDMA
 specification
In-Reply-To: <53D20C19.5000306@monstr.eu>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-8-git-send-email-afaerber@suse.de>
 <53D20C19.5000306@monstr.eu>
Message-ID: <53D21983.8060901@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

Am 25.07.2014 09:49, schrieb Michal Simek:
> On 07/25/2014 01:00 AM, Andreas F?rber wrote:
>> The specification requires xlnx,data-width, but example and driver use
>> xlnx,datawidth. Change the specification to match the implementation.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  v2: New
>>  
>>  Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
>> index 1405ed0..e4c4d47 100644
>> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
>> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
>> @@ -25,7 +25,7 @@ Required child node properties:
>>  - compatible: It should be either "xlnx,axi-vdma-mm2s-channel" or
>>  	"xlnx,axi-vdma-s2mm-channel".
>>  - interrupts: Should contain per channel VDMA interrupts.
>> -- xlnx,data-width: Should contain the stream data width, take values
>> +- xlnx,datawidth: Should contain the stream data width, take values
>>  	{32,64...1024}.

BTW I just notice that this values specification is ambiguous as to
whether 96 is a valid value or only powers of 2 like 128. Maybe you want
to clarify that in a follow-up patch?

Cheers,
Andreas

>>  
>>  Optional child node properties:
>>
> 
> Can you please take this patch through your tree?
> 
> Reviewed-by: Michal Simek <michal.simek@xilinx.com>
> 
> Thanks,
> Michal

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/ece09d6f/attachment.sig>

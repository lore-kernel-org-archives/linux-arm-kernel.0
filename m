From: srikanth.thokala@xilinx.com (Srikanth Thokala)
Date: Fri, 25 Jul 2014 12:51:41 +0000
Subject: [PATCH v2 07/11] Documentation: devicetree: Fix Xilinx VDMA
 specification
In-Reply-To: <53D225F2.4070504@xilinx.com>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-8-git-send-email-afaerber@suse.de>
 <53D20C19.5000306@monstr.eu> <53D21983.8060901@suse.de>
 <53D225F2.4070504@xilinx.com>
Message-ID: <32b0ee01-c15a-47eb-94c5-a60ca5016b85@BY2FFO11FD024.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

> -----Original Message-----
> From: Michal Simek [mailto:michal.simek at xilinx.com]
> Sent: Friday, July 25, 2014 3:10 PM
> To: Andreas F?rber; monstr at monstr.eu; Srikanth Thokala
> Cc: Vinod Koul; Michal Simek; Andreas Olofsson; Matteo Vit; Sean Rickerd;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell;
> Kumar Gala
> Subject: Re: [PATCH v2 07/11] Documentation: devicetree: Fix Xilinx VDMA
> specification
>
> Hi Andreas,
>
> On 07/25/2014 10:46 AM, Andreas F?rber wrote:
> > Hi Michal,
> >
> > Am 25.07.2014 09:49, schrieb Michal Simek:
> >> On 07/25/2014 01:00 AM, Andreas F?rber wrote:
> >>> The specification requires xlnx,data-width, but example and driver
> >>> use xlnx,datawidth. Change the specification to match the implementation.
> >>>
> >>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> >>> ---
> >>>  v2: New
> >>>
> >>>  Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> >>> b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> >>> index 1405ed0..e4c4d47 100644
> >>> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> >>> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> >>> @@ -25,7 +25,7 @@ Required child node properties:
> >>>  - compatible: It should be either "xlnx,axi-vdma-mm2s-channel" or
> >>>   "xlnx,axi-vdma-s2mm-channel".
> >>>  - interrupts: Should contain per channel VDMA interrupts.
> >>> -- xlnx,data-width: Should contain the stream data width, take
> >>> values
> >>> +- xlnx,datawidth: Should contain the stream data width, take values
> >>>   {32,64...1024}.
> >
> > BTW I just notice that this values specification is ambiguous as to
> > whether 96 is a valid value or only powers of 2 like 128. Maybe you
> > want to clarify that in a follow-up patch?
>
> really appreciate your help for improving this.
> Srikanth T: Can you please look at it?

It should be only power of 2.  I could send a patch, but it is design-specific and
the design will not allow to take the intermediate values and so the device-tree
script.  So, I feel it should be fine to keep this way.

Thanks for this patch.

Srikanth

>
> Thanks,
> Michal
>
>



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

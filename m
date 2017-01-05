From: balbi@kernel.org (Felipe Balbi)
Date: Thu, 05 Jan 2017 11:20:30 +0200
Subject: [RFC PATCH] usb: dwc3: add support for OTG driver compilation
In-Reply-To: <B2EF86ADE403CA4A85AF1BE1D3A22A06DB2CED@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1483536181-22356-1-git-send-email-mnarani@xilinx.com>
 <1483536181-22356-2-git-send-email-mnarani@xilinx.com>
 <87r34jvtn5.fsf@linux.intel.com>
 <B2EF86ADE403CA4A85AF1BE1D3A22A06DB2CED@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <87bmvlx3q9.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Manish Narani <manish.narani@xilinx.com> writes:
> Hi Felipe,
>
>
>> From: Felipe Balbi [mailto:balbi at kernel.org]
>> Sent: Wednesday, January 04, 2017 7:01 PM
>> Hi,
>>
>> Manish Narani <manish.narani@xilinx.com> writes:
>> > This patch adds support for OTG driver compilation and object file
>> > creation
>> >
>> > Signed-off-by: Manish Narani <mnarani@xilinx.com>
>> > ---
>> >  drivers/usb/dwc3/Makefile | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
>> > index ffca340..2d269ad 100644
>> > --- a/drivers/usb/dwc3/Makefile
>> > +++ b/drivers/usb/dwc3/Makefile
>> > @@ -17,6 +17,10 @@ ifneq ($(filter y,$(CONFIG_USB_DWC3_GADGET)
>> $(CONFIG_USB_DWC3_DUAL_ROLE)),)
>> >     dwc3-y                          += gadget.o ep0.o
>> >  endif
>> >
>> > +ifneq ($(CONFIG_USB_DWC3_DUAL_ROLE),)
>> > +   dwc3-y                          += otg.o
>> > +endif
>>
>> you just broke compilation
>
> Should I add new USB_DWC3_OTG macro in Kconfig?

No, no. Reset your tree to this commit and try to compile it. Problem
should be clear.

> This email and any attachments are intended for the sole use of the
> named recipient(s) and contain(s) confidential information that may be
> proprietary, privileged or copyrighted under applicable law. If you
> are not the intended recipient, do not read, copy, or forward this
> email message or any attachments. Delete this email message and any
> attachments immediately.

you should make sure these notes aren't sent to public mailing
lists. I'll delete this email of yours and stop reading them until this
is sorted out.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170105/2f209b19/attachment.sig>

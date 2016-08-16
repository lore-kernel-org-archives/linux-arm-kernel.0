From: eric@anholt.net (Eric Anholt)
Date: Tue, 16 Aug 2016 09:22:56 -0700
Subject: [PATCH V2 RFC 1/6] usb: dwc2: core: Avoid nonsense error in
 gadget mode
In-Reply-To: <92280b0f-4dd3-bcf5-57ed-277a9f91653d@synopsys.com>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
 <1469559213-16160-2-git-send-email-stefan.wahren@i2se.com>
 <92280b0f-4dd3-bcf5-57ed-277a9f91653d@synopsys.com>
Message-ID: <874m6kel9b.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

John Youn <John.Youn@synopsys.com> writes:

> On 7/26/2016 11:54 AM, Stefan Wahren wrote:
>> In gadget mode On bcm2835 platform the host tx fifo size could be zero.
>> So add zero to range and avoid such nonsense errors:
>> 
>> dwc2 20980000.usb: 0 invalid for host_nperio_tx_fifo_size.
>> dwc2 20980000.usb: Setting host_nperio_tx_fifo_size to 0
>> dwc2 20980000.usb: 0 invalid for host_perio_tx_fifo_size.
>> dwc2 20980000.usb: Setting host_perio_tx_fifo_size to 0
>
> Hi Stefan,
>
> Are those the power on reset values of GNPTXFSIZ and HPTXFSIZ?
>
> If these values can be 0, I think the patch is ok. But I'm not sure
> about that. I can check with some hardware engineers to see under what
> conditions this is possible.

FWIW, I don't see the firmware software doing any conditional setting of
these registers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160816/1c385e8e/attachment-0001.sig>

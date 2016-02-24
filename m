From: dianders@chromium.org (Doug Anderson)
Date: Wed, 24 Feb 2016 11:01:31 -0800
Subject: [PATCH 0/2] usb: dwc2: Remove host and gadget only code from core
In-Reply-To: <87mvqqjkfj.fsf@ti.com>
References: <cover.1456213319.git.johnyoun@synopsys.com>
 <56CC26ED.50004@synopsys.com> <87mvqqjkfj.fsf@ti.com>
Message-ID: <CAD=FV=WsBM-50gnDWq7AsXnSQPOu3ELabtbDRYjejAbN4h8b1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

On Wed, Feb 24, 2016 at 5:40 AM, Felipe Balbi <balbi@kernel.org> wrote:
>
> Hi,
>
> John Youn <John.Youn@synopsys.com> writes:
>> On 2/23/2016 12:35 AM, John Youn wrote:
>>> This series moves the host/gadget-specific code from core.c to hcd.c
>>> and gadget.c so that they will be compiled only when their respective
>>> configurations are selected, or in DRD.
>>>
>>> This is mostly just a straight move of the code. I have also added
>>> some comments to group related functions together.
>>>
>>> Compiled and tested in all three modes.
>>>
>>> This should also solve the issue reported here:
>>> http://marc.info/?l=linux-usb&m=145591813410106&w=2
>>>
>>> Although I wasn't able to test it... couldn't figure out how to
>>> disable CONFIG_USB and enable DWC2 in gadget mode.
>>>
>>> Felipe,
>>>
>>> This should be applied after Doug's series on your testing/next
>>> branch.
>>>
>>>
>>
>> Hi Felipe,
>>
>> Patch 2/2 is triggering our corporate mail filters however I try to
>> send it. I'll look into this with IT tomorrow, maybe have to send it
>> from another account.
>
> okay, I don't have patch 2/2. 1/2 is now in testing/next

Perhaps John's solution for working around his company's mail filters
somehow sent it to your SPAM folder?  I saw his repost of v1 at on
patchwork.  GMail put them in my inbox but marked them slightly
different, saying they were from "John Youn via messagingengine.com"

8396481 New          [RESEND,1/2] usb: dwc2: Move register save and
restore functions
8396491 New          [RESEND,2/2] usb: dwc2: Move host-specific core
functions into hcd.c

...I reviewed both 1/2 and 2/2.  For 1/2 I added my reviewed-by /
tested-by.  For 2/2 I requested some nitfixes.  John posted v2 at:

8398461 New          [v2,1/2] usb: dwc2: Move register save and
restore functions
8398471 New          [v2,2/2] usb: dwc2: Move host-specific core
functions into hcd.c

v2 of 2/2 looks good to me.  All patches can be found at
<https://patchwork.kernel.org/patch/<PATCHNUM>/>, like:

https://patchwork.kernel.org/patch/8398461/
https://patchwork.kernel.org/patch/8398471/


-Doug

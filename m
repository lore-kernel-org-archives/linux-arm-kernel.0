From: binmlist@gmail.com (Bin Liu)
Date: Mon, 14 Oct 2013 21:00:33 -0500
Subject: [PATCH v2 1/3] usb: musb: Handle nullpointer
In-Reply-To: <CADYTM3Y7JTLDA-tdig09hBDdXABgFExYpYzMj1wOn4r0tQzgzA@mail.gmail.com>
References: <1381758639-30300-1-git-send-email-mpa@pengutronix.de>
 <1381758639-30300-2-git-send-email-mpa@pengutronix.de>
 <20131014224923.GB7446@radagast>
 <CADYTM3Y7JTLDA-tdig09hBDdXABgFExYpYzMj1wOn4r0tQzgzA@mail.gmail.com>
Message-ID: <CADYTM3Y22roDOAu3Lo=mdD3JRa2zTLx9HaCGyAfgc+T8yK9vHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 8:56 PM, Bin Liu <binmlist@gmail.com> wrote:
> On Mon, Oct 14, 2013 at 5:49 PM, Felipe Balbi <balbi@ti.com> wrote:
>> On Mon, Oct 14, 2013 at 03:50:37PM +0200, Markus Pargmann wrote:
>>> When the device is connected to a host without a gadget driver,
>>> otg->gadget is NULL.
>>>
>>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>>> ---
>>>  drivers/usb/musb/musb_core.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>>> index 18e877f..baa4f6a 100644
>>> --- a/drivers/usb/musb/musb_core.c
>>> +++ b/drivers/usb/musb/musb_core.c
>>> @@ -654,7 +654,8 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
>>>                               break;
>>>               case OTG_STATE_B_PERIPHERAL:
>>
>> why would we be in B peripheral if we're host only ? Bug seems to be
>> else where.
>
> We are not host, we are in device mode.
>
> But I would think the proper fix should be not setting
> DEVCTL[SOFTCONN] until a gadget driver is loaded. Then the host will
> not see the device which does not have a gadget driver.

Sorry, I meant POWER[SOFTCONN] bit.

>
> Regards,
> -Bin.
>
>>
>> --
>> balbi

From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 11 Mar 2013 16:12:46 +0100
Subject: [PATCH 1/3] can: at91_can: add dt support
In-Reply-To: <20130311091722.GA2572@ludovic.desroches@atmel.com>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
 <1362763842-14924-2-git-send-email-ludovic.desroches@atmel.com>
 <513A2365.5050803@pengutronix.de>
 <20130311091722.GA2572@ludovic.desroches@atmel.com>
Message-ID: <513DF46E.7000903@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2013 10:17 AM, Ludovic Desroches wrote:
> On Fri, Mar 08, 2013 at 06:44:05PM +0100, Marc Kleine-Budde wrote:
>> On 03/08/2013 06:30 PM, ludovic.desroches at atmel.com wrote:
>>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>
>>> Add device tree support.
>>>
>>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>>> ---
>>>  .../devicetree/bindings/net/can/atmel-can.txt      | 14 ++++
>>>  drivers/net/can/at91_can.c                         | 75 ++++++++++++++++------
>>>  2 files changed, 70 insertions(+), 19 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/net/can/atmel-can.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/can/atmel-can.txt b/Documentation/devicetree/bindings/net/can/atmel-can.txt
>>> new file mode 100644
>>> index 0000000..69381db
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/can/atmel-can.txt
>>> @@ -0,0 +1,14 @@
>>> +* AT91 CAN *
>>> +
>>> +Required properties:
>>> +  - compatible: Should be "atmel,at91sam9263-can" or "atmel,at91sam9x5-can"
>>
>> On imx we use the oldest SoC with that IP available. Which strategy are
>> you following on at91?
>>
> 
> We are using the same strategy.

But "atmel,at91sam9x5-can" isn't a specific SoC, probably a SoC family.
Or are you using "atmel,at91sam9x5-can" for the other devices in the DT,
too.

I picked at91sam9x5-can for the non devicetree driver out of the blue,
as there was no scheme established, yet. I'm not hanging on that name,
I'd rather appreciate to follow the common at91 DT rules.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130311/66c8e834/attachment.sig>

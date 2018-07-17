From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue, 17 Jul 2018 07:45:22 +0200
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: add mu binding doc
In-Reply-To: <AM0PR04MB4211E30E85E830AA31F998A1805C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180716114209.25242-1-o.rempel@pengutronix.de>
 <20180716114209.25242-2-o.rempel@pengutronix.de>
 <AM0PR04MB4211E30E85E830AA31F998A1805C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <7f96a775-661b-86e5-95eb-07017dcec3c5@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17.07.2018 07:00, A.s. Dong wrote:
>> -----Original Message-----
>> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
>> Sent: Monday, July 16, 2018 7:42 PM
>> To: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
>> <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
>> Rutland <mark.rutland@arm.com>; A.s. Dong <aisheng.dong@nxp.com>
>> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel at pengutronix.de;
>> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; dl-linux-
>> imx <linux-imx@nxp.com>
>> Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: add mu binding doc
>>
>> The Messaging Unit module enables two processors within the SoC to
>> communicate and coordinate by passing messages (e.g. data, status and
>> control) through the MU interface.
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>>  .../devicetree/bindings/mailbox/fsl,mu.txt    | 32 +++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/mailbox/fsl,mu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
>> b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
>> new file mode 100644
>> index 000000000000..5d48dd75b98d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
>> @@ -0,0 +1,32 @@
>> +NXP i.MX Messaging Unit (MU)
>> +--------------------------------------------------------------------
>> +
>> +Required properties:
>> +-------------------
>> +- compatible :	should be "fsl,<chip>-mu", the supported chips include:
>> +		imx6sx	- i.MX 6SoloX
>> +		imx7d	- i.MX 7Dual
>> +		imx7s	- i.MX 7Solo
>> +		imx7ulp	- i.MX 7ULP
>> +		imx8qm	- i.MX 8QM
>> +		imx8qxp	- i.MX 8QXP
>> +- reg :		Should contain the registers location and length
>> +- interrupts :	Interrupt number. The interrupt specifier format depends
>> +		on the interrupt controller parent.
>> +- #mbox-cells:  Must be:
>> +		0 - for single channel mode. i.MX8* SCU protocol specific.
>> +		1 - for multichannel (generic) mode.
>> +
>> +Optional properties:
>> +-------------------
>> +- clocks :	phandle to the input clock.
>> +- fsl,mu-side-a : Should be set for side A MU.
> 
> For this property, how about doing like:
> fsl,mu-side: An Integer represents the MU side.

All this SoCs have MUs with only two sides. Why do we need explicit
annotation for both parts?

> If missing this property, it's default to Side A

So, why do we need optional integer, which is set by default as side A?
This is why I made it bool.

> 	       which is mostly used by A core.

And you will need to explicit set side=B for SCU. Correct?

> 	       0: MU Side A
> 	       1: MU Side B


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/37429afd/attachment.sig>

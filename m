From: info@lategoodbye.de (Stefan Wahren)
Date: Tue, 09 Sep 2014 20:48:40 +0200
Subject: [PATCH RFC 1/3] DT: add binding for MXS regulator
In-Reply-To: <20140909175940.GF3896@leverpostej>
References: <1410089869-6611-1-git-send-email-info@lategoodbye.de>
 <1410089869-6611-2-git-send-email-info@lategoodbye.de>
 <20140909175940.GF3896@leverpostej>
Message-ID: <540F4B88.5080108@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Am 09.09.2014 19:59, schrieb Mark Rutland:
> On Sun, Sep 07, 2014 at 12:37:47PM +0100, Stefan Wahren wrote:
>> This patch adds the Device tree bindings for the Freescale MXS on-chip
>> regulators.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>   .../bindings/regulator/mxs-regulator.txt           | 38 ++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/mxs-regulator.txt
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/mxs-regulator.txt b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
>> new file mode 100644
>> index 0000000..c3226cc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
>> @@ -0,0 +1,38 @@
>> +MXS regulators
>> +
>> +Required node properties:
>> +- compatible: Should be "fsl,<soc>-power", where soc is "imx23" or "imx28"
>> +- reg: Offset and length of the register set for the device
>
> We require #address-cells and #size-cells if the child nodes have reg
> entries.

okay.

>
>> +
>> +Required regulator properties:
>> +- compatible: Must be "fsl,mxs-regulator"
>> +- reg: Offset of the register set for the regulator
>
> Is this the offset or the absolute physical address?
>
> The example seems to be absolute.

You are right, the description is wrong.

>
>> +- mxs-max-reg-val: Maximum value of this register
>
> What does this even mean? What's the format?
>
> Is this not implied by standard properties like regulator-max-microvolt?

Unfortunately not as long the step size in microvolt isn't defined. The 
parameter defines the register value in hex corresponding to 
regulator-max-microvolt.

step size = (regulator-max-microvolt - regulator-min-microvolt) / 
mxs-max-reg-val

May be i missed or understand something wrong?

>
>> +Optional regulator properties:
>> +- mxs-default-microvolt: initial voltage of the regulator
>
> Why is this necessary?

The original driver from Freescale set the MX28 regulator vddio to 3.38 
V during registering. I think that is ugly to implement in the driver 
part, so i add a more general property in the devicetree binding.

>
> Mark.

Stefan

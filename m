From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 06 Aug 2015 20:34:07 +0100
Subject: [PATCH 1/3] nvmem: Add i.MX6 OCOTP device tree binding
 documentation
In-Reply-To: <1438878835.3223.14.camel@pengutronix.de>
References: <1438693342-605-1-git-send-email-p.zabel@pengutronix.de>	
 <55C38752.3040406@linaro.org> <1438878835.3223.14.camel@pengutronix.de>
Message-ID: <55C3B6AF.4050107@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/08/15 17:33, Philipp Zabel wrote:
> Am Donnerstag, den 06.08.2015, 17:12 +0100 schrieb Srinivas Kandagatla:
>>
>> On 04/08/15 14:02, Philipp Zabel wrote:
>>> This patch documents the i.MX6 OCOTP device tree binding.
>>>
>>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>>> ---
>>>    .../devicetree/bindings/nvmem/imx-ocotp.txt          | 20 ++++++++++++++++++++
>>>    1 file changed, 20 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
>>> new file mode 100644
>>> index 0000000..7d9a3fc
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
>>> @@ -0,0 +1,20 @@
>>> +Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
>>> +
>>> +This binding represents the on-chip eFuse OTP controller found on
>>> +i.MX6Q/D, i.MX6DL/S, i.MX6SL, and i.MX6SX SoCs.
>>> +
>>> +Required properties:
>>> +- compatible: should be one of
>>> +	"fsl,imx6q-ocotp" (i.MX6Q/D/DL/S),
>>> +        "fsl,imx6sl-ocotp" (i.MX6SL), or
>>> +	"fsl,imx6sx-ocotp" (i.MX6SX), followed by "syscon".
>>> +- reg: Should contain the register base and length.
>>> +- clocks: Should contain a phandle pointing to the gated peripheral clock.
>>> +
>>> +Example:
>>> +
>>> +	ocotp: ocotp at 021bc000 {
>>> +		compatible = "fsl,imx6q-ocotp", "syscon";
>> Do you still need syscon?
>
> Currently the imx_tempmon driver still accesses ocotp via syscon. I'd
> like to change that and drop "syscon" after the nvmem framework lands in
> mainline.

Makes sense.

>
>>> +		reg = <0x021bc000 0x4000>;
>> Can't we just have a register range specific to the OTP device?
>
> In the i.MX device trees it is common to specify the register range from
> the memory map. In any case, we have to support old device trees where
> this is already set.
ok.

--srini
>
> regards
> Philipp
>

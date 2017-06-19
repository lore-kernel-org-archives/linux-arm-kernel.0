From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 19 Jun 2017 12:58:51 +0200
Subject: [PATCH v5 1/3] nvmem: dt: document SNVS LPGPR binding
In-Reply-To: <20170619060629.du3qmihhkkyym44h@pengutronix.de>
References: <20170609125730.25502-1-o.rempel@pengutronix.de>
 <20170609125730.25502-2-o.rempel@pengutronix.de>
 <8e50ff3d-d1f0-2795-5dc9-302979ca9694@i2se.com>
 <20170619060629.du3qmihhkkyym44h@pengutronix.de>
Message-ID: <b8d7d65c-93c8-8b62-abb4-09d60c32bf84@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Am 19.06.2017 um 08:06 schrieb Oleksij Rempel:
> On Fri, Jun 09, 2017 at 04:59:00PM +0200, Stefan Wahren wrote:
> Hi Stefan,
>
>> Hi Oleksij,
>>
>> Am 09.06.2017 um 14:57 schrieb Oleksij Rempel:
>>> Documentation bindings for the Low Power General Purpose Register
>>> available on i.MX6 SoCs in the Secure Non-Volatile Storage.
>>>
>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>> ---
>>>  .../devicetree/bindings/nvmem/snvs-lpgpr.txt          | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt b/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
>>> new file mode 100644
>>> index 000000000000..21910fb3159f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
>>> @@ -0,0 +1,19 @@
>>> +Device tree bindings for Low Power General Purpose Register found in i.MX6Q/D
>>> +Secure Non-Volatile Storage.
>>> +
>>> +This DT node should be represented as a sub-node of a "syscon",
>>> +"simple-mfd" node.
>>> +
>>> +Required properties:
>>> +- compatible: should be:
>>> +	"fsl,imx6q-snvs-lpgpr" for Freescale i.MX6Q/D/DL/S
>>> +
>>> +Example:
>>> +snvs: snvs at 020cc000 {
>>> +	compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
>>> +	reg = <0x020cc000 0x4000>;
>>> +
>>> +	snvs_lpgpr: snvs-lpgpr {
>>> +		compatible = "fsl,imx6q-snvs-lpgpr";
>> according to the reference manual at least the clock "lp_ipg_clk_s" is
>> required for register R/W access.
>> So it should be added to the binding and enabled by the driver.
> Hm...
> Non of current SNVS drives use, set or defines *_ipg_clk_s. I can't find
> in the docs how can I control this clocks.
> lp_ipg_clk_s and hp_ipg_clk_s depend on ipg_clk_root, which seems to be
> not gated. So, it is always on. Or do I miss something.
>
do you know how the clock "lp_ipg_clk_s" should be handled?

Thanks
Stefan

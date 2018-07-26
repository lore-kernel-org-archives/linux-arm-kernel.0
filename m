From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 26 Jul 2018 13:37:41 +0200
Subject: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
In-Reply-To: <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-2-o.rempel@pengutronix.de>
 <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
Message-ID: <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26.07.2018 11:51, Robin Gong wrote:
> 
> 
>> -----Original Message-----
>> From: Oleksij Rempel [mailto:o.rempel at pengutronix.de]
>> Sent: 2018?7?26? 17:22
>> To: Shawn Guo <shawnguo@kernel.org>; Mark Brown <broonie@kernel.org>;
>> Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel at pengutronix.de;
>> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> linux-clk at vger.kernel.org; linux-kernel at vger.kernel.org; Andrew Morton
>> <akpm@linux-foundation.org>; Liam Girdwood <lgirdwood@gmail.com>;
>> Leonard Crestez <leonard.crestez@nxp.com>; Rob Herring
>> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Michael
>> Turquette <mturquette@baylibre.com>; Stephen Boyd
>> <sboyd@codeaurora.org>; Fabio Estevam <fabio.estevam@nxp.com>; Russell
>> King <linux@armlinux.org.uk>; dl-linux-imx <linux-imx@nxp.com>; Robin Gong
>> <yibin.gong@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
>> Subject: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
>> fsl,pmic-stby-poweroff property
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>  Documentation/devicetree/bindings/clock/imx6q-clock.txt | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>> b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>> index a45ca67a9d5f..e1308346e00d 100644
>> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>> @@ -6,6 +6,14 @@ Required properties:
>>  - interrupts: Should contain CCM interrupt
>>  - #clock-cells: Should be <1>
>>
>> +Optional properties:
>> +- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ signal
>> +  on power off.
>> +  Use this property if the SoC should be powered off by external power
>> +  management IC (PMIC) triggered via PMIC_STBY_REQ signal.
> PMIC_ON_REQ didn't connect to any pin of PMIC in your case?

No. First, it was only one customer specific issue. After some research
I found even publicly available boards (for example RioTboard) which has
same/similar design. After seeing this in imx6 documentation as valid
power off way, I have no doubts - there should be even more devices doin
this in the wild.

> Don't understand
> why not follow normal board design guide to power off pmic by PMIC_ON_REQ.
> How to power on board again then?

Power cycle. Without this patch, power of is not real power off. So,
power cycle, is expected behavior for user interaction. On usual PC,
reset button will not enable PC as well.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180726/6ad7dea8/attachment.sig>

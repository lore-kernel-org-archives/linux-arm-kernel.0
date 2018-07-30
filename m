From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Mon, 30 Jul 2018 09:58:32 +0200
Subject: [PATCH v8 6/6] ARM: dts: imx6: RIoTboard provide standby on power
 off option
In-Reply-To: <DB6PR04MB3223FA7B91D0D43B2EC1EE2A892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-7-o.rempel@pengutronix.de>
 <DB6PR04MB3223FA7B91D0D43B2EC1EE2A892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
Message-ID: <afe757dd-d2e7-8bf5-dca0-17a69a36f7c3@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27.07.2018 11:33, Robin Gong wrote:
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
>> Subject: [PATCH v8 6/6] ARM: dts: imx6: RIoTboard provide standby on power
>> off option
>>
>> This board, as well as some other boards with i.MX6 and a PMIC, uses a
>> "PMIC_STBY_REQ" line to notify the PMIC about a state change.
>> The PMIC is programmed for a specific state change before triggering the line.
>> In this case, PMIC_STBY_REQ can be used for stand by, sleep and power off
>> modes.
>>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>>  arch/arm/boot/dts/imx6dl-riotboard.dts | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts
>> b/arch/arm/boot/dts/imx6dl-riotboard.dts
>> index 2e98c92adff7..a0e9753ee767 100644
>> --- a/arch/arm/boot/dts/imx6dl-riotboard.dts
>> +++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
>> @@ -90,6 +90,10 @@
>>  	status = "okay";
>>  };
>>
>> +&clks {
>> +	fsl,pmic-stby-poweroff;
>> +};
> It's better remove the default "syscon-poweroff" power off node.

ok

>>  &fec {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_enet>;
>> @@ -170,6 +174,7 @@
>>  		reg = <0x08>;
>>  		interrupt-parent = <&gpio5>;
>>  		interrupts = <16 8>;
>> +		fsl,pmic-stby-poweroff;
>>
>>  		regulators {
>>  			reg_vddcore: sw1ab {				/* VDDARM_IN */
>> --
>> 2.18.0
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180730/bb08d822/attachment.sig>

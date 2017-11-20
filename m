From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Mon, 20 Nov 2017 06:29:46 +0100
Subject: [PATCH v4 4/5] DTS: gta04: add serdev node for w2sg00x4
In-Reply-To: <20171117170857.GO28152@atomide.com>
References: <cover.1510781875.git.hns@goldelico.com>
 <02dde546157359316eebe8e90f5f1de7177bbffa.1510781876.git.hns@goldelico.com>
 <20171117170857.GO28152@atomide.com>
Message-ID: <DB98ED72-7151-4230-934D-B4FFEC7A397F@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

> Am 17.11.2017 um 18:08 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [171115 21:41]:
>> GTA04 has a W2SG0004/84 connected to UART2 of the OMAP3
>> processor. A GPIO can pulse the on/off toggle switch.
>> 
>> The VSIM regulator is used to power on/off the LNA of an external
>> active GPS antenna so that a driver can turn the LNA off if GPS is
>> not needed to save battery energy.
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap3-gta04.dtsi | 6 ++++++
>> 1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
>> index 4504908c23fe..e967d738aaaf 100644
>> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
>> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
>> @@ -477,6 +477,12 @@
>> &uart2 {
>> 	pinctrl-names = "default";
>> 	pinctrl-0 = <&uart2_pins>;
>> +
>> +	gps: gps {
>> +		compatible = "wi2wi,w2sg0004";
>> +		lna-supply = <&vsim>;   /* LNA regulator */
>> +		enable-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;    /* GPIO_145: trigger for turning on/off w2sg0004 */
>> +	};
>> };
> 
> How about move the comment above the node to avoid long lines?
> Or just change it to gpio_145 for the comment as the property
> is already enable-gpios?
> 
> Regards,
> 
> Tony

Done so that it will be included in next version.

BR and thanks,
Nikolaus

From: stefan@agner.ch (Stefan Agner)
Date: Tue, 24 Nov 2015 19:08:27 -0800
Subject: VF610 broken by pinctrl: freescale: imx: allow mux_reg offset zero
In-Reply-To: <20151125021034.GB11384@lunn.ch>
References: <20151115024409.GB2194@lunn.ch> <20151123132838.GM13744@tiger>
 <20151125021034.GB11384@lunn.ch>
Message-ID: <6cbc0a2992d1753ce65ecf2ccc636936@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-11-24 18:10, Andrew Lunn wrote:
>> Can you please try the following change to see if it fixes your problem?
>>
>> Shawn
>>
>> diff --git a/drivers/pinctrl/freescale/pinctrl-vf610.c b/drivers/pinctrl/freescale/pinctrl-vf610.c
>> index 37a037543d29..587d1ff6210e 100644
>> --- a/drivers/pinctrl/freescale/pinctrl-vf610.c
>> +++ b/drivers/pinctrl/freescale/pinctrl-vf610.c
>> @@ -299,7 +299,7 @@ static const struct pinctrl_pin_desc vf610_pinctrl_pads[] = {
>>  static struct imx_pinctrl_soc_info vf610_pinctrl_info = {
>>         .pins = vf610_pinctrl_pads,
>>         .npins = ARRAY_SIZE(vf610_pinctrl_pads),
>> -       .flags = SHARE_MUX_CONF_REG,
>> +       .flags = SHARE_MUX_CONF_REG | ZERO_OFFSET_VALID,
>>  };
>>
>>  static const struct of_device_id vf610_pinctrl_of_match[] = {
> 
> Hi Shawn
> 
> I tested it, and it does work.

Thanks for bringing this up and testing this. FWIW:

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan

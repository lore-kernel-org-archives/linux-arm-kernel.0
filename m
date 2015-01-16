From: rjui@broadcom.com (Ray Jui)
Date: Fri, 16 Jan 2015 11:24:09 -0800
Subject: [PATCH v4 3/3] ARM: dts: add I2C device nodes for Broadcom Cygnus
In-Reply-To: <20150115084456.GO22880@pengutronix.de>
References: <rjui@broadcom.com>
 <1421274213-3544-1-git-send-email-rjui@broadcom.com>
 <1421274213-3544-4-git-send-email-rjui@broadcom.com>
 <20150115084456.GO22880@pengutronix.de>
Message-ID: <54B96559.1010007@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/15/2015 12:44 AM, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Wed, Jan 14, 2015 at 02:23:33PM -0800, Ray Jui wrote:
>> Add I2C device nodes and its properties in bcm-cygnus.dtsi but keep
>> them disabled there. Individual I2C devices can be enabled in board
>> specific dts file when I2C slave devices are enabled in the future
> s/$/./
> 
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> ---
>>  arch/arm/boot/dts/bcm-cygnus.dtsi |   20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> index 5126f9e..f7d6c1d 100644
>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> @@ -70,6 +70,26 @@
>>  		};
>>  	};
>>  
>> +	i2c0: i2c at 18008000 {
>> +		compatible = "brcm,iproc-i2c";
> in patch 2 you wrote the driver is for a family of SoCs, right? Then I'd
> make this:
> 
> 	compatible = "brcm,$mysoc-iproc-i2c", "brcm,iproc-i2c";
> 
Sorry could you please help to explain the intention here? Note the
iProc I2C IP can be found in various iProc family of SoCs, but to my
best knowledge, there hasn't been any changes of the IP in any of those
SoCs.

Is the compatible ID "brcm,$mysoc-iproc-i2c" only to clarify that it's
for a specific SoC? If so, what should the compatible ID array look
like? Should it be changed to the following?

static const struct of_device_id bcm_iproc_i2c_of_match[] = {
	{ .compatible = "brcm,iproc-i2c" },
	{ .compatible = "brcm,$mysoc-iproc-i2c" },
	{},
};


> (or maybe s/$mysoc-iproc-i2c/$mysoc-i2c/).
> 
> Best regards
> Uwe
> 

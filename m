From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 15 Dec 2017 11:39:54 +0530
Subject: [PATCH 04/14] ARM: dts: dra76x: Create a common file with MMC/SD
 IOdelay data
In-Reply-To: <20171214151531.GI14441@atomide.com>
References: <20171214134054.7749-1-kishon@ti.com>
 <20171214134054.7749-5-kishon@ti.com> <20171214151531.GI14441@atomide.com>
Message-ID: <be4d8cfd-bdd3-aedf-9d9c-156de39d2621@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thursday 14 December 2017 08:45 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [171214 13:44]:
>> +&dra7_pmx_core {
>> +	mmc1_pins_default: mmc1_pins_default {
>> +		pinctrl-single,pins = <
>> +			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_clk.clk */
>> +			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
>> +			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
>> +			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
>> +			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
>> +			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
>> +		>;
>> +	};
>> +
>> +	mmc1_pins_sdr12: mmc1_pins_sdr12 {
>> +		pinctrl-single,pins = <
>> +			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_clk.clk */
>> +			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_cmd.cmd */
>> +			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat0.dat0 */
>> +			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat1.dat1 */
>> +			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat2.dat2 */
>> +			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_dat3.dat3 */
>> +		>;
>> +	};
> 
> Can't you just do:
> 
> pinctrl-0 = <&mmc1_pins_default>;
> pinctrl-1 = <&mmc1_pins_default>;
> pinctrl-2 = <&mmc1_pins_hs>;
> pinctrl-names = "default", "sdr12", "sdr25";

just wanted to make sure every mode has it's own pinctrl group so that it's
easy to review. Initially we were thinking something like
mmc1_pins_default_sdr12_sdr25.

But if you'd prefer we just use mmc1_pins_default for all modes that uses
default pinmux configuration, I can change it that way too.

Thanks
Kishon

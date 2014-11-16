From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 16 Nov 2014 14:17:07 +0100
Subject: [PATCHv1 3/3] arm: mvebu: add .dts file for Synology DS414
In-Reply-To: <20141116021521.GD15870@lunn.ch> (Andrew Lunn's message of "Sun,
 16 Nov 2014 03:15:21 +0100")
References: <cover.1416095841.git.arno@natisbad.org>
 <909a6be242eeafa2cb5f096f3f2fc244f1b0880a.1416095841.git.arno@natisbad.org>
 <20141116021521.GD15870@lunn.ch>
Message-ID: <878ujbb7zg.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Andrew Lunn <andrew@lunn.ch> writes:

>> +		internal-regs {
>> +
>> +			pinctrl {
>> +				pmx_ge0: pmx-ge0 {
>> +					marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
>> +						       "mpp4", "mpp5", "mpp6", "mpp7",
>> +						       "mpp8", "mpp9", "mpp10", "mpp11";
>> +					marvell,function = "ge0";
>> +				};
>> +
>> +				pmx_ge1: pmx-ge1 {
>> +					marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15",
>> +						       "mpp16", "mpp17", "mpp18", "mpp19",
>> +						       "mpp20", "mpp21", "mpp22", "mpp23";
>> +					marvell,function = "ge1";
>> +				};
>> +
>> +				pmx_spi: pmx-spi {
>> +					marvell,pins = "mpp36", "mpp37",
>> +						       "mpp38", "mpp39";
>> +					marvell,function = "spi";
>> +				};
>
> It would be good to move these to armada-xp-mv78230.dtsi. I would
> suggest following the naming convention used by the 370.

Will do.


>> +			spi0: spi at 10600 {
>> +				status = "okay";
>> +				pinctrl-0 = <&pmx_spi>;
>> +				pinctrl-names = "default";
>> +
>> +				spi-flash at 0 {
>> +					#address-cells = <1>;
>> +					#size-cells = <1>;
>> +					compatible = "micron,n25q064";
>> +					reg = <0>; /* Chip select 0 */
>> +					spi-max-frequency = <20000000>;
>> +
>> +					/*
>> +					 * Warning!
>> +					 *
>> +					 * Synology u-boot uses its compiled-in environment
>> +					 * and it seems Synology did not care to change u-boot
>> +					 * default configuration in order to allow saving a
>> +					 * modified environment at a sensible location. So,
>> +					 * if you do a 'saveenv' under u-boot, your modified
>> +					 * environment be saved will at 1MB after the start
>> +					 * of the flash, i.e. in the middle of the uImage.
>> +					 * For that reason, it is strongly advised not to
>> +					 * change default environment, unless you know what
>> +					 * you are doing.
>> +					 */
>
> Seems to be a cut/paste of the 370 text. So same comments.

Will correct typos.


>> +			i2c at 11000 {
>> +				clock-frequency = <400000>;
>> +				status = "okay";
>> +
>> +				s35390a: s35390a at 30 {
>> +					 compatible = "ssi,s35390a";
>
> sii
>
> Ah! It is also wrong in kirkwood-synology.dtsi

Good catch anyway ;-)

Cheers,

a+

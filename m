From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 09 Nov 2013 22:26:12 +0100
Subject: [PATCH] ARM: mvebu: Add Netgear ReadyNAS 2120 board
In-Reply-To: <20131109210836.GK14890@lunn.ch> (Andrew Lunn's message of "Sat,
 9 Nov 2013 22:08:36 +0100")
References: <87bo1tmibv.fsf@natisbad.org> <20131109210836.GK14890@lunn.ch>
Message-ID: <871u2pmfm3.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Andrew Lunn <andrew@lunn.ch> writes:

> On Sat, Nov 09, 2013 at 09:27:32PM +0100, Arnaud Ebalard wrote:
>> 
>> All hardware parts of the (mv78230 Armada XP based) NETGEAR ReadyNAS
>> 2120 are supported by mainline kernel (USB 3.0 and eSATA rear ports,
>> USB 2.0 front port, Gigabit controller and PHYs for the two rear ports,
>> serial port, LEDs, Buttons, 88SE9170 SATA controllers, three G762 fan
>> controllers, G751 temperature sensor) except for:
>
>> +			i2c at 11000 {
>> +				compatible = "marvell,mv64xxx-i2c";
>> +				clock-frequency = <400000>;
>> +				status = "okay";
>> +
>> +				/* Rear fan #1 of 3 (Protechnic MGT4012XB-O20,
>> +				 * 8000RPM) near eSATA port */
>> +				g762_fan1: g762 at 3e {
>> +					compatible = "gmt,g762";
>> +					reg = <0x3e>;
>> +					clocks = <&g762_clk>; /* input clock */
>> +					fan_gear_mode = <0>;
>> +					fan_startv = <1>;
>> +					pwm_polarity = <0>;
>> +				};
>> +
>> +				/* Rear fan #2 of 3 at the center */
>> +				g762_fan2: g762 at 48 {
>> +					compatible = "gmt,g762";
>> +					reg = <0x48>;
>> +					clocks = <&g762_clk>; /* input clock */
>> +					fan_gear_mode = <0>;
>> +					fan_startv = <1>;
>> +					pwm_polarity = <0>;
>> +				};
>> +
>> +				/* Rear fan #3 of 3 */
>> +				g762_fan3: g762 at 49 {
>> +					compatible = "gmt,g762";
>> +					reg = <0x49>;
>> +					clocks = <&g762_clk>; /* input clock */
>> +					fan_gear_mode = <0>;
>> +					fan_startv = <1>;
>> +					pwm_polarity = <0>;
>> +				};
>> +
>> +				g751: g751 at 4c {
>> +					compatible = "gmt,g751";
>> +					reg = <0x4c>;
>> +				};
>
> Hi Arnaud
>
> Looks good to me. However, if for some reason you need to respin, it
> would be nice to add a comment about what the g751 is. All the other
> i2c devices you say what they are. No need to respin just because of
> this.

I'll keep that in mind. Thanks.

GMT G751 is an I2C temperature sensor and thermal watchdog chip. It is
basically a clone of National Semiconductor LM75 chip:

root at thin:/sys# sensors
g762-i2c-0-3e
Adapter: mv64xxx_i2c adapter
fan1:        5461 RPM  (div = 1)

g762-i2c-0-48
Adapter: mv64xxx_i2c adapter
fan1:        5461 RPM  (div = 1)

g762-i2c-0-49
Adapter: mv64xxx_i2c adapter
fan1:        5461 RPM  (div = 1)

g751-i2c-0-4c
Adapter: mv64xxx_i2c adapter
temp1:        +30.5?C  (high = +80.0?C, hyst = +75.0?C)

armada_thermal-virtual-0
Adapter: Virtual device
temp1:        +34.2?C

Cheers,

a+

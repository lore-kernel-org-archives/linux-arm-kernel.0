From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 26 Nov 2014 19:05:31 +0200
Subject: [PATCH v2 5/5] i2c: davinci: use ICPFUNC to toggle I2C as gpio
 for bus recovery
In-Reply-To: <20141126160407.GN4431@pengutronix.de>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
 <1417010393-30598-6-git-send-email-grygorii.strashko@ti.com>
 <20141126160407.GN4431@pengutronix.de>
Message-ID: <5476085B.40009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2014 06:04 PM, Uwe Kleine-K?nig wrote:
> On Wed, Nov 26, 2014 at 03:59:53PM +0200, Grygorii Strashko wrote:
>> Having a board where the I2C bus locks up occasionally made it clear
>> that the bus recovery in the i2c-davinci driver will only work on
>> some boards, because on regular boards, this will only toggle GPIO
>> lines that aren't muxed to the actual pins.
>>
>> The I2C controller on SoCs like da850 (and da830), Keystone 2 has the
>> built-in capability to bit-bang its lines by using the ICPFUNC registers
>> of the i2c controller.
>> Implement the suggested procedure by toggling SCL and checking SDA using
>> the ICPFUNC registers of the I2C controller when present. Allow platforms
>> to indicate the presence of the ICPFUNC registers with a has_pfunc platform
>> data flag and add optional DT property "ti,has-pfunc" to indicate
>> the same in DT.
> On what does it depend if this pfunc stuff works or not? Only the SoC,
> or also on some board specific properties?

SoC / set of SoCs. Also, similar feature is supported by OMAP and AM335x/AM437x SoCs
using I2C_SYSTEST register.

> Given the former using the
> compatible string to detect its availability would be better. (In this
> case also sorry, didn't consider this case when requesting the property
> in the last round.)
> 
> The patch looks ok.

regards,
-grygorii

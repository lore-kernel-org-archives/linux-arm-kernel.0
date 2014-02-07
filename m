From: klightspeed@killerwolves.net (Ben Peddell)
Date: Fri, 07 Feb 2014 17:44:08 +1000
Subject: [PATCH 4/4] ARM: Kirkwood: Add support for many Synology NAS
 devices
In-Reply-To: <20140206160126.GH29860@lunn.ch>
References: <1391634309-3123-1-git-send-email-andrew@lunn.ch>
 <1391634309-3123-5-git-send-email-andrew@lunn.ch>
 <20140206153939.GD8533@titan.lakedaemon.net> <20140206160126.GH29860@lunn.ch>
Message-ID: <52F48EC8.9020306@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/02/2014 2:01 AM, Andrew Lunn wrote:
> On Thu, Feb 06, 2014 at 10:39:39AM -0500, Jason Cooper wrote:
>>
>> + devicetree ML, DT maintainers
>>
>> On Wed, Feb 05, 2014 at 10:05:09PM +0100, Andrew Lunn wrote:
>>> Add device tree fragments and files to support many of the kirkwood
>>> based Synology NAS devices. This is a translation of the board setup
>>> file maintained by Ben Peddell <klightspeed@killerwolves.net>
>>>
>>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>>> Tested by Ben Peddell <klightspeed@killerwolves.net>
>>> cc: Ben Peddell <klightspeed@killerwolves.net>
>>> ---
>>>
>>> v2:
>>> Fix gpio's which should be gpo.
>>> Rebase onto v3-14-rc1
>>> Update RTC nodes with vendor name.
>>> Update SPI flash node with vendor name.
>>> ---
>>>  arch/arm/boot/dts/Makefile                     |   15 ++++
>>>  arch/arm/boot/dts/kirkwood-ds109.dts           |   33 +++++++
>>>  arch/arm/boot/dts/kirkwood-ds110jv10.dts       |   33 +++++++
>>>  arch/arm/boot/dts/kirkwood-ds111.dts           |   33 +++++++
>>>  arch/arm/boot/dts/kirkwood-ds112.dts           |   34 +++++++
>>>  arch/arm/boot/dts/kirkwood-ds209.dts           |   33 +++++++
>>>  arch/arm/boot/dts/kirkwood-ds210.dts           |   35 ++++++++
>>>  arch/arm/boot/dts/kirkwood-ds212.dts           |   37 ++++++++
>>>  arch/arm/boot/dts/kirkwood-ds212j.dts          |   34 +++++++
>>>  arch/arm/boot/dts/kirkwood-ds409.dts           |   34 +++++++
>>>  arch/arm/boot/dts/kirkwood-ds409slim.dts       |   32 +++++++
>>>  arch/arm/boot/dts/kirkwood-ds411.dts           |   35 ++++++++
>>>  arch/arm/boot/dts/kirkwood-ds411j.dts          |   34 +++++++
>>>  arch/arm/boot/dts/kirkwood-ds411slim.dts       |   34 +++++++
>>>  arch/arm/boot/dts/kirkwood-rs212.dts           |   34 +++++++
>>>  arch/arm/boot/dts/kirkwood-rs409.dts           |   33 +++++++
>>>  arch/arm/boot/dts/kirkwood-rs411.dts           |   34 +++++++
>>>  arch/arm/boot/dts/synology/alarm-led-12.dtsi   |   28 ++++++
>>>  arch/arm/boot/dts/synology/common.dtsi         |  112 ++++++++++++++++++++++++
>>>  arch/arm/boot/dts/synology/ethernet-1.dtsi     |   15 ++++
>>>  arch/arm/boot/dts/synology/fan-alarm-18.dtsi   |   22 +++++
>>>  arch/arm/boot/dts/synology/fan-alarm-35-1.dtsi |   22 +++++
>>>  arch/arm/boot/dts/synology/fan-alarm-35-3.dtsi |   32 +++++++
>>>  arch/arm/boot/dts/synology/fan-gpios-15.dtsi   |   34 +++++++
>>>  arch/arm/boot/dts/synology/fan-gpios-32.dtsi   |   34 +++++++
>>>  arch/arm/boot/dts/synology/fan-speed-100.dtsi  |   20 +++++
>>>  arch/arm/boot/dts/synology/fan-speed-120.dtsi  |   20 +++++
>>>  arch/arm/boot/dts/synology/fan-speed-150.dtsi  |   20 +++++
>>>  arch/arm/boot/dts/synology/hdd-leds-20.dtsi    |   90 +++++++++++++++++++
>>>  arch/arm/boot/dts/synology/hdd-leds-21-1.dtsi  |   36 ++++++++
>>>  arch/arm/boot/dts/synology/hdd-leds-21-2.dtsi  |   52 +++++++++++
>>>  arch/arm/boot/dts/synology/hdd-leds-36.dtsi    |  103 ++++++++++++++++++++++
>>>  arch/arm/boot/dts/synology/hdd-leds-38.dtsi    |   52 +++++++++++
>>>  arch/arm/boot/dts/synology/hdd-power-29.dtsi   |   56 ++++++++++++
>>>  arch/arm/boot/dts/synology/hdd-power-30-1.dtsi |   40 +++++++++
>>>  arch/arm/boot/dts/synology/hdd-power-30-2.dtsi |   56 ++++++++++++
>>>  arch/arm/boot/dts/synology/hdd-power-30-4.dtsi |   89 +++++++++++++++++++
>>>  arch/arm/boot/dts/synology/hdd-power-31.dtsi   |   40 +++++++++
>>>  arch/arm/boot/dts/synology/hdd-power-34.dtsi   |   73 +++++++++++++++
>>>  arch/arm/boot/dts/synology/i2c-rtc-ricoh.dtsi  |   18 ++++
>>>  arch/arm/boot/dts/synology/i2c-rtc-seiko.dtsi  |   18 ++++
>>>  arch/arm/boot/dts/synology/pcie-2.dtsi         |   19 ++++
>>>  42 files changed, 1658 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-ds109.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-ds110jv10.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-ds111.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-ds112.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-ds209.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-ds210.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-ds212.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-ds212j.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-ds409.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-ds409slim.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-ds411.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-ds411j.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-ds411slim.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-rs212.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-rs409.dts
>>>  create mode 100644 arch/arm/boot/dts/kirkwood-rs411.dts
>>>  create mode 100644 arch/arm/boot/dts/synology/alarm-led-12.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/common.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/ethernet-1.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/fan-alarm-18.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/fan-alarm-35-1.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/fan-alarm-35-3.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/fan-gpios-15.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/fan-gpios-32.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/fan-speed-100.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/fan-speed-120.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/fan-speed-150.dtsi

If we're not worried about the non-linearity of the 150R+120R+100R and
182R+150R+100R fan controllers (vs the 150R/100R/33R ones), these fan
speed blocks could be collapsed into common.dtsi.

>>>  create mode 100644 arch/arm/boot/dts/synology/hdd-leds-20.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/hdd-leds-21-1.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/hdd-leds-21-2.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/hdd-leds-36.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/hdd-leds-38.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/hdd-power-29.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/hdd-power-30-1.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/hdd-power-30-2.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/hdd-power-30-4.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/hdd-power-31.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/hdd-power-34.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/i2c-rtc-ricoh.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/i2c-rtc-seiko.dtsi
>>>  create mode 100644 arch/arm/boot/dts/synology/pcie-2.dtsi
>>
>> Holy sh*t!  I know we're adding 15 boards
> 
> More than 15 actually. Most .dts files support multiple devices. So
> there should be about 30 devices supported by these .dts files.
> 
>> , but this is, imho,
>> over-fragmenting.  I'm sure there's a reason you chose this path, but
>> you haven't explained why in your commit log. So I'm left guessing...
> 
> Synology seem to build there devices like lego. They have two
> different RTC blocks. They have three different fan alarm blocks, four
> different led blocks, etc. And to build a product, the just select a
> group of blocks and put them together.

The Ricoh RTC seems to be only used in the pre-2010 units.  Everything
else uses the Seiko RTC.

Most of the 1-bay and 2-bay units use the GPIOs that are multiplexed
with the built-in SATA interface activity/presence pins on mpp 20-23,
while the 4-bay units use ge01 and a PCIe SATA controller, and put the
software controlled HDD leds on mpp 36-43.

Most of the 6281 units with HDD power controls use mpp 29 and 31, while
most of the 6282 units with HDD power controls use mpp 30, 34, 44 and 45
and provide a model ID on mpp 28, 29, 46 and 47.  Pre-2012 units and
4-bay units didn't have a separate power control for HDD1.  These power
controls are presumably to limit startup current from the 12V brick
power supply.

From
http://forum.synology.com/wiki/index.php/What_kind_of_CPU_does_my_NAS_have,
it doesn't look like there are any new 6281 or 6282 models for 2014.

> 
> The board setup code which Ben Peddell wrote has a somewhat similar
> structure:
> 
> http://klightspeed.killerwolves.net/synology/linux-3.4-synology-0.1.patch

A more up-to-date version is at:
http://klightspeed.killerwolves.net/synology/linux-3.7-synology-0.2.patch

> 
> It has a set of functions which add platform devices. And a table
> driven piece of code which based on the product name calls these
> functions to add the needed platform devices. Take a look at the table
> to get a better idea of the re-use factor of the blocks.
> 
> In this DT version, i have a dtsi file for each function, and a dti
> file for each table entry.
> 
> I will add to the changelog in the next version.



-- 
Ben Peddell
IT Support Bowen, Collinsville and Proserpine Catholic schools
http://klightspeed.killerwolves.net/

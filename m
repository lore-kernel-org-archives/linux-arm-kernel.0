From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 6 Feb 2014 17:01:26 +0100
Subject: [PATCH 4/4] ARM: Kirkwood: Add support for many Synology NAS
 devices
In-Reply-To: <20140206153939.GD8533@titan.lakedaemon.net>
References: <1391634309-3123-1-git-send-email-andrew@lunn.ch>
 <1391634309-3123-5-git-send-email-andrew@lunn.ch>
 <20140206153939.GD8533@titan.lakedaemon.net>
Message-ID: <20140206160126.GH29860@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 10:39:39AM -0500, Jason Cooper wrote:
> 
> + devicetree ML, DT maintainers
> 
> On Wed, Feb 05, 2014 at 10:05:09PM +0100, Andrew Lunn wrote:
> > Add device tree fragments and files to support many of the kirkwood
> > based Synology NAS devices. This is a translation of the board setup
> > file maintained by Ben Peddell <klightspeed@killerwolves.net>
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Tested by Ben Peddell <klightspeed@killerwolves.net>
> > cc: Ben Peddell <klightspeed@killerwolves.net>
> > ---
> > 
> > v2:
> > Fix gpio's which should be gpo.
> > Rebase onto v3-14-rc1
> > Update RTC nodes with vendor name.
> > Update SPI flash node with vendor name.
> > ---
> >  arch/arm/boot/dts/Makefile                     |   15 ++++
> >  arch/arm/boot/dts/kirkwood-ds109.dts           |   33 +++++++
> >  arch/arm/boot/dts/kirkwood-ds110jv10.dts       |   33 +++++++
> >  arch/arm/boot/dts/kirkwood-ds111.dts           |   33 +++++++
> >  arch/arm/boot/dts/kirkwood-ds112.dts           |   34 +++++++
> >  arch/arm/boot/dts/kirkwood-ds209.dts           |   33 +++++++
> >  arch/arm/boot/dts/kirkwood-ds210.dts           |   35 ++++++++
> >  arch/arm/boot/dts/kirkwood-ds212.dts           |   37 ++++++++
> >  arch/arm/boot/dts/kirkwood-ds212j.dts          |   34 +++++++
> >  arch/arm/boot/dts/kirkwood-ds409.dts           |   34 +++++++
> >  arch/arm/boot/dts/kirkwood-ds409slim.dts       |   32 +++++++
> >  arch/arm/boot/dts/kirkwood-ds411.dts           |   35 ++++++++
> >  arch/arm/boot/dts/kirkwood-ds411j.dts          |   34 +++++++
> >  arch/arm/boot/dts/kirkwood-ds411slim.dts       |   34 +++++++
> >  arch/arm/boot/dts/kirkwood-rs212.dts           |   34 +++++++
> >  arch/arm/boot/dts/kirkwood-rs409.dts           |   33 +++++++
> >  arch/arm/boot/dts/kirkwood-rs411.dts           |   34 +++++++
> >  arch/arm/boot/dts/synology/alarm-led-12.dtsi   |   28 ++++++
> >  arch/arm/boot/dts/synology/common.dtsi         |  112 ++++++++++++++++++++++++
> >  arch/arm/boot/dts/synology/ethernet-1.dtsi     |   15 ++++
> >  arch/arm/boot/dts/synology/fan-alarm-18.dtsi   |   22 +++++
> >  arch/arm/boot/dts/synology/fan-alarm-35-1.dtsi |   22 +++++
> >  arch/arm/boot/dts/synology/fan-alarm-35-3.dtsi |   32 +++++++
> >  arch/arm/boot/dts/synology/fan-gpios-15.dtsi   |   34 +++++++
> >  arch/arm/boot/dts/synology/fan-gpios-32.dtsi   |   34 +++++++
> >  arch/arm/boot/dts/synology/fan-speed-100.dtsi  |   20 +++++
> >  arch/arm/boot/dts/synology/fan-speed-120.dtsi  |   20 +++++
> >  arch/arm/boot/dts/synology/fan-speed-150.dtsi  |   20 +++++
> >  arch/arm/boot/dts/synology/hdd-leds-20.dtsi    |   90 +++++++++++++++++++
> >  arch/arm/boot/dts/synology/hdd-leds-21-1.dtsi  |   36 ++++++++
> >  arch/arm/boot/dts/synology/hdd-leds-21-2.dtsi  |   52 +++++++++++
> >  arch/arm/boot/dts/synology/hdd-leds-36.dtsi    |  103 ++++++++++++++++++++++
> >  arch/arm/boot/dts/synology/hdd-leds-38.dtsi    |   52 +++++++++++
> >  arch/arm/boot/dts/synology/hdd-power-29.dtsi   |   56 ++++++++++++
> >  arch/arm/boot/dts/synology/hdd-power-30-1.dtsi |   40 +++++++++
> >  arch/arm/boot/dts/synology/hdd-power-30-2.dtsi |   56 ++++++++++++
> >  arch/arm/boot/dts/synology/hdd-power-30-4.dtsi |   89 +++++++++++++++++++
> >  arch/arm/boot/dts/synology/hdd-power-31.dtsi   |   40 +++++++++
> >  arch/arm/boot/dts/synology/hdd-power-34.dtsi   |   73 +++++++++++++++
> >  arch/arm/boot/dts/synology/i2c-rtc-ricoh.dtsi  |   18 ++++
> >  arch/arm/boot/dts/synology/i2c-rtc-seiko.dtsi  |   18 ++++
> >  arch/arm/boot/dts/synology/pcie-2.dtsi         |   19 ++++
> >  42 files changed, 1658 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ds109.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ds110jv10.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ds111.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ds112.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ds209.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ds210.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ds212.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ds212j.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ds409.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ds409slim.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ds411.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ds411j.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ds411slim.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-rs212.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-rs409.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-rs411.dts
> >  create mode 100644 arch/arm/boot/dts/synology/alarm-led-12.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/common.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/ethernet-1.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/fan-alarm-18.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/fan-alarm-35-1.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/fan-alarm-35-3.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/fan-gpios-15.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/fan-gpios-32.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/fan-speed-100.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/fan-speed-120.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/fan-speed-150.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/hdd-leds-20.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/hdd-leds-21-1.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/hdd-leds-21-2.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/hdd-leds-36.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/hdd-leds-38.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/hdd-power-29.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/hdd-power-30-1.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/hdd-power-30-2.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/hdd-power-30-4.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/hdd-power-31.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/hdd-power-34.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/i2c-rtc-ricoh.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/i2c-rtc-seiko.dtsi
> >  create mode 100644 arch/arm/boot/dts/synology/pcie-2.dtsi
> 
> Holy sh*t!  I know we're adding 15 boards

More than 15 actually. Most .dts files support multiple devices. So
there should be about 30 devices supported by these .dts files.

, but this is, imho,
> over-fragmenting.  I'm sure there's a reason you chose this path, but
> you haven't explained why in your commit log. So I'm left guessing...

Synology seem to build there devices like lego. They have two
different RTC blocks. They have three different fan alarm blocks, four
different led blocks, etc. And to build a product, the just select a
group of blocks and put them together.

The board setup code which Ben Peddell wrote has a somewhat similar
structure:

http://klightspeed.killerwolves.net/synology/linux-3.4-synology-0.1.patch

It has a set of functions which add platform devices. And a table
driven piece of code which based on the product name calls these
functions to add the needed platform devices. Take a look at the table
to get a better idea of the re-use factor of the blocks.

In this DT version, i have a dtsi file for each function, and a dti
file for each table entry.

I will add to the changelog in the next version.

  Andrew

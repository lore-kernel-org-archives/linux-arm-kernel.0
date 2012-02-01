From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 01 Feb 2012 14:20:13 +0400
Subject: [RFC PATCH 7/7] ARM: davinci: add support for the am1808 based
 enbw_cmc board
In-Reply-To: <4F27E6E0.1050608@denx.de>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-8-git-send-email-hs@denx.de>
 <20120130203252.GX28397@ponder.secretlab.ca> <4F27E6E0.1050608@denx.de>
Message-ID: <4F2911DD.6010405@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 31-01-2012 17:04, Heiko Schocher wrote:

>> On Mon, Jan 23, 2012 at 09:56:07AM +0100, Heiko Schocher wrote:
>>> - AM1808 based board
>>> - 64 MiB DDR ram
>>> - 2 MiB Nor flash
>>> - 128 MiB NAND flash
>>> - use internal RTC
>>> - I2C support
>>> - hwmon lm75 support
>>> - UBI/UBIFS support
>>> - MMC support
>>> - USB OTG support

>>> Signed-off-by: Heiko Schocher<hs@denx.de>
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: devicetree-discuss at lists.ozlabs.org
>>> Cc: davinci-linux-open-source at linux.davincidsp.com
>>> Cc: linux-mtd at lists.infradead.org
>>> Cc: linux-i2c at vger.kernel.org
>>> Cc: netdev at vger.kernel.org
>>> Cc: David Woodhouse<dwmw2@infradead.org>
>>> Cc: Ben Dooks<ben-linux@fluff.org>
>>> Cc: Wolfram Sang<w.sang@pengutronix.de>
>>> Cc: Sekhar Nori<nsekhar@ti.com>
>>> Cc: Kevin Hilman<khilman@ti.com>
>>> Cc: Wolfgang Denk<wd@denx.de>

>>> ---
>>> - post this board support with USB support, even though
>>>    USB is only working with the 10 ms "workaround", posted here:
>>>    http://comments.gmane.org/gmane.linux.usb.general/54505
>>>    I see this issue also on the AM1808 TMDXEXP1808L evalboard.
>>> - MMC and USB are not using OF support yet, ideas how to port
>>>    this are welcome. I need for USB and MMC boards board
>>>    specific callbacks, how to solve this with OF support?

[...]

>>> diff --git a/arch/arm/boot/dts/enbw_cmc.dts b/arch/arm/boot/dts/enbw_cmc.dts
>>> new file mode 100644
>>> index 0000000..e5995ce
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/enbw_cmc.dts
[...]

>>> +			compatible = "ns16550a";

>> Should include a string for the specific device.  Something like:

>> 	compatible = "ti,da800", "ns16550a";

> added.

    Note that there's no DA800 chip, only DA828, DA830, and DA850 AFAIK.

WBR, Sergei

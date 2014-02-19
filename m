From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 19 Feb 2014 14:23:32 -0500
Subject: [PATCH v6 3/4] DT: i2c: Trivial: Add sii, s35390a, fix ricoh
 vendor prefix
In-Reply-To: <1392836354-28886-4-git-send-email-klightspeed@killerwolves.net>
References: <1392836354-28886-1-git-send-email-klightspeed@killerwolves.net>
 <1392836354-28886-4-git-send-email-klightspeed@killerwolves.net>
Message-ID: <20140219192332.GS7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 04:59:13AM +1000, klightspeed at killerwolves.net wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Add the Seiko Instruments Inc S35390a to the list of trivial i2c
> devices. At the same time, correct the vendor prefix for ricoh, which
> should be the ticker symbol ricoy.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 1a1ac2e..5f37191 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -56,8 +56,9 @@ ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI an
>  pericom,pt7c4338	Real-time Clock Module
>  plx,pex8648		48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
>  ramtron,24c64		i2c serial eeprom  (24cxx)
> -ricoh,rs5c372a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
> +ricoy,rs5c372a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC

Sorry, I should've caught this before.  'ricoh,' has been is use by two
dts files since at least v3.10.  See:

  f236f5aabe8eb ARM: kirkwood: Add support for NETGEAR ReadyNAS Duo v2 using DT

So same as qnap, let's stick with what is already there.

thx,

Jason.

>  samsung,24ad0xd1	S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
> +sii,s35390a		2-wire CMOS real-time clock
>  st-micro,24c256		i2c serial eeprom  (24cxx)
>  stm,m41t00		Serial Access TIMEKEEPER
>  stm,m41t62		Serial real-time clock (RTC) with alarm
> -- 
> 1.8.3.2
> 

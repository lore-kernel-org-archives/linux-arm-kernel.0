From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 09 Sep 2010 14:48:26 +1200
Subject: Voltage/current/sensor monitoring interface and Wiegand
In-Reply-To: <20100909000245.GK14056@atomos.longlandclan.yi.org>
References: <20100909000245.GK14056@atomos.longlandclan.yi.org>
Message-ID: <4C884AFA.20604@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2010 12:02 PM, Stuart Longland wrote:
> Hi all,
> 
> I'm currently writing a driver for an in-house developed sensor
> controller device.  This device communicates via I?C, and functions as a
> multi-function device incorporating:
> 
> - Touchscreen controller
> - Keypad/Button controller
> - LED driver
> - Voltage/current monitor
> - Temperature sensor monitor
> - Light sensor monitor
> - PIR (motion) detection monitor
> - Communications interface (for slow serial links like Wiegand)

> How are voltage *monitors* normally written?  (note, not voltage
> *regulators*... this thing does not alter the voltage rails.)  I tried
> to make sense of lm-sensors, but that seems very ad-hoc (maybe I missed
> some document that explains it) to me.  It's hard to be clear on what is
> the *right* way to report a voltage or current reading to userspace.

Depending on your particular application it might make sense to use the
power supply class (see Documentation/power/power_supply_class.txt) for
the voltage/current monitoring. If the temperature sensor is related to
a power supply monitor, then it could also go there.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934

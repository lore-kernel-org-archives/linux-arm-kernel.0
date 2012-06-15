From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 15 Jun 2012 23:34:07 +0800
Subject: [Patch v5 08/13] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <201206131800.38622.marex@denx.de>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <4FD8AD42.6010702@gmail.com>
 <20120613152841.GA23590@richard-laptop>
 <201206131800.38622.marex@denx.de>
Message-ID: <20120615153404.GM31565@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 06:00:38PM +0200, Marek Vasut wrote:
> Write a driver that does the GPIO setup in some generic way? Wasn't there 
> something about this stuff going on? Shawn, you had some comments /wrt the M28 
> DTS. This might be what you meant?
> 
No.  What Richard is looking for is a way to set/clear gpio, while
what I was commenting on M28 DTS is the way to configure a pin into
gpio mode.  In this series, Richard chose to use "hog" feature to
configure the pin into gpio mode, which means defining a pinctrl state
for pin controller node itself, then at pinctrl subsystem init time,
pinctrl core will configure these "hog" pins properly.

The "hog" method makes some sense for Richard's case, where the pin
has no clear device/driver owner, and when gpio_request call can not
configure the requested pin into gpio mode automatically yet.

-- 
Regards,
Shawn

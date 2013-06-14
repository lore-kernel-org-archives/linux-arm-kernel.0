From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 14 Jun 2013 17:42:21 +0200
Subject: [PATCH 1/5] pinctrl: update the documentation for some pinconfig
 params
In-Reply-To: <201306141741.46077.heiko@sntech.de>
References: <201306141741.46077.heiko@sntech.de>
Message-ID: <201306141742.21808.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BIAS_DISABLE and BIAS_HIGH_IMPEDANCE generic pinconfig options were
missing information about their argument - which should be ignored.

Also the BIAS_PULL_* options may have the pull strength as argument
when they are activated, while simpler hardware can use any
non-0 value for it.

Update the kerneldoc to reflect this.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/linux/pinctrl/pinconf-generic.h |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index d414a77..d1868bc 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -23,27 +23,31 @@
  * @PIN_CONFIG_BIAS_DISABLE: disable any pin bias on the pin, a
  *	transition from say pull-up to pull-down implies that you disable
  *	pull-up in the process, this setting disables all biasing.
+ *	The argument is ignored.
  * @PIN_CONFIG_BIAS_HIGH_IMPEDANCE: the pin will be set to a high impedance
  *	mode, also know as "third-state" (tristate) or "high-Z" or "floating".
  *	On output pins this effectively disconnects the pin, which is useful
  *	if for example some other pin is going to drive the signal connected
  *	to it for a while. Pins used for input are usually always high
- *	impedance.
+ *	impedance. The argument is ignored.
  * @PIN_CONFIG_BIAS_BUS_HOLD: the pin will be set to weakly latch so that it
  *	weakly drives the last value on a tristate bus, also known as a "bus
  *	holder", "bus keeper" or "repeater". This allows another device on the
  *	bus to change the value by driving the bus high or low and switching to
  *	tristate. The argument is ignored.
  * @PIN_CONFIG_BIAS_PULL_UP: the pin will be pulled up (usually with high
- *	impedance to VDD). If the argument is != 0 pull-up is enabled,
- *	if it is 0, pull-up is disabled.
+ *	impedance to VDD). If the argument is != 0 pull-up is enabled. On
+ *	hardware supporting this, the argument should contain the strength of
+ *	the pull in Ohm. If it is 0, pull-up is disabled.
  * @PIN_CONFIG_BIAS_PULL_DOWN: the pin will be pulled down (usually with high
- *	impedance to GROUND). If the argument is != 0 pull-down is enabled,
- *	if it is 0, pull-down is disabled.
+ *	impedance to GROUND). If the argument is != 0 pull-down is enabled. On
+ *	hardware supporting this, the argument should contain the strength of
+ *	the pull in Ohm. If it is 0, pull-down is disabled.
  * @PIN_CONFIG_BIAS_PULL_PIN_DEFAULT: the pin will be pulled up or down based
  *	on embedded knowledge of the controller, like current mux function.
- *	If the argument is != 0 pull up/down is enabled, if it is 0,
- *	the pull is disabled.
+ *	If the argument is != 0 pull up/down is enabled. On hardware supporting
+ *	this, the argument should contain the strength of the pull in Ohm.
+ *	If it is 0, pull is disabled.
  * @PIN_CONFIG_DRIVE_PUSH_PULL: the pin will be driven actively high and
  *	low, this is the most typical case and is typically achieved with two
  *	active transistors on the output. Setting this config will enable
-- 
1.7.10.4

From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 11 Apr 2013 17:28:27 +0100
Subject: [PATCH v4 04/14] mfd: Add Samsung PWM/timer master driver
In-Reply-To: <201304110035.47776.arnd@arndb.de>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
 <2359597.ofbj7Kvioz@flatron> <5357756.gKmBOZlWcd@flatron>
 <201304110035.47776.arnd@arndb.de>
Message-ID: <20130411162826.GG9243@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 12:35:47AM +0200, Arnd Bergmann wrote:

> Sorry for not replying earlier. My idea for the register level interface
> was to create a platform_device for each PWM, e.g. using the mfd_cell
> infrastructure. You can then pass a "struct regmap" as the platform
> data for each child of the timer node, and all the DT handling code
> can stay in the parent driver.

Dunno if it helps or not but there's also dev_get_regmap() if you're
passing the struct device around or can fish one out of thhe parent.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130411/f538ba40/attachment.sig>

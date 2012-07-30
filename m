From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Jul 2012 17:01:35 +0800
Subject: [PATCH 2/2] ARM: dts: imx6q: Invert the GPIO controller order
In-Reply-To: <8E7BE7398BB9294F8B826ADE09B18EBE6CC2FF7EE1@SI-MBX20.de.bosch.com>
References: <1343219864-3040-1-git-send-email-dirk.behme@de.bosch.com>
 <1343219864-3040-2-git-send-email-dirk.behme@de.bosch.com>
 <20120728134114.GH2128@S2101-09.ap.freescale.net>
 <8E7BE7398BB9294F8B826ADE09B18EBE6CC2FF7EE1@SI-MBX20.de.bosch.com>
Message-ID: <20120730090133.GF31509@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 09:28:21AM +0200, Thomae Matthias (CM-AI/PJ-CF31) wrote:
> I care about the global number because it is used to access GPIOs
> from userspace via the Sysfs interface (see Documentation/gpio.txt).
> 
Understood.  But proposed the solution does not look right.

I think we can define alias for gpio ports in device tree and have
gpio driver identify the port via alias, and then we specify the
numbers rather than having them dynamically allocated by gpio core.

-- 
Regards,
Shawn

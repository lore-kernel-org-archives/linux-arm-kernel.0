From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 8 Apr 2015 10:42:40 -0300
Subject: imx6: PCIe imx6_pcie_assert_core_reset() hangs after watchdog
 reset
In-Reply-To: <1428500226.2809.28.camel@pengutronix.de>
References: <55128016.3030903@denx.de>
 <CAOMZO5CDOJXp3Hbe8a9dPh=krWhw-i5i8Zoa5Hb+2XGAdou7ew@mail.gmail.com>
 <1428500226.2809.28.camel@pengutronix.de>
Message-ID: <CAOMZO5CS3hW5CCOWf4J-dUP-eAn-JYDCb=5DPMs_+x9gWyu2bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 8, 2015 at 10:37 AM, Lucas Stach <l.stach@pengutronix.de> wrote:

> The problem appears when a watchdog reset happens, so the kernel has no
> chance to clean things up before rebooting. This isn't a problem if you
> do a full system reset via the watchdog out line to the PMIC, but gets
> ugly if only the i.MX6 is reset (which apparently doesn't clear the GPR
> bits).

Got it. Yes, in imx6q-sabresd I see U-boot reporting 'Reset cause:
POR' after the 'reboot' command, and this is in fact due to full
system reset via PMIC as you explained.

Regards,

Fabio Estevam

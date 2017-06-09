From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 9 Jun 2017 09:18:35 -0300
Subject: [PATCH 2/2] ARM: dts: imx6ul: Add imx6ul-tempmon
In-Reply-To: <1497005895.28352.88.camel@nxp.com>
References: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
 <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
 <CAOMZO5BP4fPyzDmSg+DFLRYh3QMf-8T0gqvnZn6mEMt-QqSgfw@mail.gmail.com>
 <1497005895.28352.88.camel@nxp.com>
Message-ID: <CAOMZO5B95Gh5ufc0TUpqEvC4jwTww+AkcMPfdMG-Cj3Vv4Necg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 9, 2017 at 7:58 AM, Leonard Crestez <leonard.crestez@nxp.com> wrote:

> Yes, as far as I can tell the tempmon block uses the 480 Mhz PLL3 clock
> directly. This is similar to other imx6 SOCs. This PLL is used for
> stuff like USB but not only that. My understanding is the _USB_OTG
> suffix is descriptive, similar to PLL4_AUDIO and PLL6_ENET. Other non-
> usb components use PLL3 (like UART) but through other gates/dividers.

Yes, PLL3 can be a parent for the UART clock, but UART has its own clock gate.

> Setting this to IMX6UL_CLK_DUMMY will cause temperature reads to fail.
> Even if PLL3 usually ends up being constantly enabled because of uarts
> this is not true at imx_thermal_probe time (or uarts can be disabled).

Ok, thanks for confirming. It was not obvious from reading the
reference manual that the PLL3 clock is the gate for tempmon.

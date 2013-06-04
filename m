From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 04 Jun 2013 12:34:42 +0200
Subject: DT version of kirkwood_ge0x_init()
In-Reply-To: <51ADBEE0.5040500@keymile.com>
References: <51ADBEE0.5040500@keymile.com>
Message-ID: <51ADC2C2.6010106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/13 12:18, Gerlando Falauto wrote:
> I noticed how most of the DT-aware board-setup files only have a single
> <board>_init() function, calling kirkwood_ge00_init() with a struct
> mv643xx_eth_platform_data as a single argument.
>
> I was wondering -- is there a reason why we cannot remove all this
> board-specific code and move all this to the DT?

Gerlando,

DT for mv643xx_eth is on the way (https://lkml.org/lkml/2013/5/29/527).
We wait for the driver to surface to relax branch dependencies and then
move all DT Orion SoCs to it.

 > I would really love to have all our boards under a single
 > CONFIG_<FAMILY>_DT and a single compatible string, with all the
 > differences within the DTs itself -- no more #ifdef CONFIG_<BOARD>,
 > no more of_machine_is_compatible("boardXXX").

All those will happen if there is DT support for mv643xx_eth which
is the only driver left without DT and board dependencies. But there
will be no CONFIG_LACIE_DT or whatever, but just CONFIG_KIRKWOOD_DT
and board dependent stuff described in the corresponding dts.

Sebastian

From: romain.perier@gmail.com (PERIER Romain)
Date: Thu, 4 Sep 2014 10:45:35 +0200
Subject: [PATCH v5 1/4] ethernet: arc: Add support for Rockchip SoC layer
 device tree bindings
In-Reply-To: <20140903211220.GA16962@gmail.com>
References: <1409763165-16461-1-git-send-email-romain.perier@gmail.com>
 <20140903211220.GA16962@gmail.com>
Message-ID: <CABgxDoLWqqwGUUt9hWuJdHT_VF0c6-7xeAwgfeH7TwJmu1BN9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beniamino,

I will investigate. Could you please :

- Load the module
- Show me the output of lsmod
- Use your ethernet a bit
- Try to unload the module
- If your board did not freeze or if your kernel did not panic , show
me your dmesg (if it is impossible show me the dmesg before unloading
the module)

Perhaps, we could continue this discussion in private (by email or
IRC). What do you think ?

I will investigate this evening and tomorrow. Thanks for your feedbacks .


2014-09-03 23:12 GMT+02:00 Beniamino Galvani <b.galvani@gmail.com>:
> On Wed, Sep 03, 2014 at 04:52:42PM +0000, Romain Perier wrote:
>> This patch defines a platform glue layer for Rockchip SoCs which
>> support arc-emac driver. It ensures that regulator for the rmii is on
>> before trying to connect to the ethernet controller. It applies right
>> speed and mode changes to the grf when ethernet settings change.
>
> Hi Romain,
>
> on a Radxa Rock when I try to remove the emac_rockchip module the
> board locks up when calling clk_disable_unprepare(priv->refclk). The
> tree is a net-next + your series, I don't know if I need some other
> patches.
>
> There is also the following build warning due to the emac dependency
> on REGULATOR which in principle seems correct, but looking at other
> drivers I wonder why they use the regulator APIs but don't have the
> same dependency.
>
> drivers/regulator/Kconfig:1:error: recursive dependency detected!
> drivers/regulator/Kconfig:1:       symbol REGULATOR is selected by MDIO_SUN4I
> drivers/net/phy/Kconfig:159:       symbol MDIO_SUN4I depends on PHYLIB
> drivers/net/phy/Kconfig:5:         symbol PHYLIB is selected by ARC_EMAC_CORE
> drivers/net/ethernet/arc/Kconfig:20:      symbol ARC_EMAC_CORE is selected by EMAC_ROCKCHIP
> drivers/net/ethernet/arc/Kconfig:35:      symbol EMAC_ROCKCHIP depends on REGULATOR
>
> Regards,
> Beniamino

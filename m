From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 23 Oct 2014 18:46:27 -0200
Subject: [BISECT] v3.18-rc1 doesn't boot on nitrogen6x i.MX6 board
In-Reply-To: <20141023203034.GR12732@glaurung.lavos.net>
References: <20141023203034.GR12732@glaurung.lavos.net>
Message-ID: <CAOMZO5CaWzfqjj2orX4nh8Vjk2o8bS_sQ7vPA_SwwfdFpFwXDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Thu, Oct 23, 2014 at 6:30 PM, Brian Downing <bdowning@lavos.net> wrote:
> Hi all; apologies for not posting to the linux-arm-kernel mailing list,
> but lists.infradead.org seems, well, dead:
>
> $ host lists.infradead.org
> Host lists.infradead.org not found: 3(NXDOMAIN)
>
> v3.18-rc1 doesn't boot on my Boundary Devices nitrogen6x board.
> (Specifically, imx6q-nitrogen6x.dtb).  It fails before any console output.
> I bisected it down to this commit:
>
> commit 3fce0e882f61513c45c67e15bd0fde03341b58a5
> Author: Tim Harvey <tharvey@gateworks.com>
> Date:   Thu Aug 7 23:36:40 2014 -0700
>
>     PCI: imx6: Delay enabling reference clock for SS until it stabilizes
>
>     According to the IMX6 reference manuals, REF_SSP_EN (Reference clock enable
>     for SS function) must remain deasserted until the reference clock is
>     running at the appropriate frequency.
>
>     Delay enabling the reference clock for the SS function until it has
>     stabilized.  This prevents a high link failure rate (>5%) on certain IMX6
>     boards at various temperatures.
>
>     [bhelgaas: reword changelog slightly]
>     Tested-by: Fabio Estevam <festevam@gmail.com>
>     Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Acked-by: Marek Vasut <marex@denx.de>
>     Acked-by: Lucas Stach <l.stach@pengutronix.de>
>
> With that one commit reverted v3.18-rc1 fires up just fine for me.
>
> I really haven't looked into what might be wrong, I just wanted to let
> you know that this fix apparently breaks some boards.

Adding Eric and Troy in case they could comment. I don't know why this
commit would cause failure on nitrogen board.

Regards,

Fabio Estevam

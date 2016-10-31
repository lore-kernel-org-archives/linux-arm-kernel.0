From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 31 Oct 2016 21:29:06 -0200
Subject: [GIT PULL] i.MX fixes for 4.9
In-Reply-To: <CAOesGMhSHqs_WfxkdUn7yrT_9g1CO1cqXGzQ2Y1Y-+-tY1KNmw@mail.gmail.com>
References: <20161024140622.GM30578@tiger>
 <CAOesGMhSHqs_WfxkdUn7yrT_9g1CO1cqXGzQ2Y1Y-+-tY1KNmw@mail.gmail.com>
Message-ID: <CAOMZO5D9uBBwWV8UJOLj-2iwWO6sReB5BAtzdi1q6OqbtvcSOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Mon, Oct 31, 2016 at 8:39 PM, Olof Johansson <olof@lixom.net> wrote:
> Fabio,
>
> I've got multi_v7 booting now, but imx_v6_v7 is still broken on both
> hummingboard and wandboard.
>
> Hummingboard doesn't even output anything on serial during boot, bug
> with DEBUG_LL I got some more info
>
> (No output boot at
> http://arm-soc.lixom.net/bootlogs/mainline/v4.9-rc3/hummingboard-arm-imx_v6_v7_defconfig.html,
> not very useful).
>
> This one seems to be due to CONFIG_PCI_IMX6, which is off on
> multi_v7_defconfig. Hard hang(?), last output is:
>
> [    0.490643] OF: PCI: host bridge /soc/pcie at 0x01000000 ranges:
> [    0.496540] OF: PCI:   No bus range found for /soc/pcie at 0x01000000,
> using [bus 00-ff]
> [    0.504512] OF: PCI:    IO 0x01f80000..0x01f8ffff -> 0x00000000
> [    0.510559] OF: PCI:   MEM 0x01000000..0x01efffff -> 0x01000000
>

I think this will be fixed with this pcie-designware patch:
http://www.spinics.net/lists/linux-pci/msg55244.html

> Wandboard, has a peculiar MMC error. First I thought it was just the
> card going bad, but now I'm not so sure since multi_v7 boots just fine
> on the same hardware:

Yes, I have been noticing this mmc error reported in your autobooter
and I also thought it was some kind of a bad SD card.

This particular error I have never been able to reproduce. Also
checked kernelci and do not see this mmc error there.

Interesting that it happens only with imx_v6_v7_defconfig and not with
multi_v7_defconfig.

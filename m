From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 17 Oct 2013 22:04:57 -0700
Subject: [PATCH 5/6] PCI: imx6: Force Gen1 operation
In-Reply-To: <1381853200-5534-6-git-send-email-marex@denx.de>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
 <1381853200-5534-6-git-send-email-marex@denx.de>
Message-ID: <CAJ+vNU2_=qVP4mvzwcjBRMxo88Qa+8OQqqwo1f9SqVxSNyavgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 9:06 AM, Marek Vasut <marex@denx.de> wrote:
> Without forcing the PCIe core into Gen1 operation, the PCIe switch
> attached directly to the PCIe port is not recognised at all. The
> PCIe switch is Gen2 capable to make this issue even more puzzling.
>
[...]
>
>         while (!dw_pcie_link_up(pp)) {
>                 usleep_range(100, 1000);
>                 count++;
> -               if (count >= 10) {
> +               if (count >= 200) {
>                         dev_err(pp->dev, "phy link never came up\n");
>                         dev_dbg(pp->dev,
>                                 "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
> --
> 1.8.4.rc3
>

Marek,

Can you split this patch out?  I found that with the PLX PEX860x PCIe
switches I have on the i.MX6 RC I needed this longer wait for link as
well, but I don't think this is related to gen1/gen2.

Thanks,

Tim

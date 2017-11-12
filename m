From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 12 Nov 2017 10:14:23 -0200
Subject: [PATCH] ARM: dts: imx6: Remove unneeded address-cells/size-cells
In-Reply-To: <62f3cb01-ff85-0fe0-2afa-0fe4732a7421@rwth-aachen.de>
References: <1510348378-18150-1-git-send-email-festevam@gmail.com>
 <62f3cb01-ff85-0fe0-2afa-0fe4732a7421@rwth-aachen.de>
Message-ID: <CAOMZO5CEVdWgKRQT8-42GOEyFgB8cvCtJZK780BK1t3zHkX62w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On Sat, Nov 11, 2017 at 12:24 PM, Christopher Spinrath
<christopher.spinrath@rwth-aachen.de> wrote:

> This results in a regression for those devices where U-Boot is supposed
> to inject the partition sub-nodes. For example, this is the case for
> cm-fx6 module based devices like the Utilite Pro.
>
> Linux fails to parse the partitions and reports:
> [    9.330881] spi0.0: error parsing ofpart partition
> /soc/aips-bus at 2000000/spba-bus at 2000000/ecspi at 2008000/m25p80 at 0/partition at 0
> (/soc/aips-bus at 2000000/spba-bus at 2000000/ecspi at 2008000/m25p80 at 0)
> [    9.330887] mtd: failed to find partitions; one or more parsers
> reports errors (-22)
>
> Also, the documentation does not forbid the #address-cells/size-cells if
> no partitions are present.
>
> So, please, drop this patch (or exclude at least the cm-fx6 related change).

Good point! I will resend the patch and will only change the NXP boards.

Thanks

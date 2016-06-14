From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 14 Jun 2016 08:24:21 +0800
Subject: [PATCH 0/3] Allwinner MMC Fifo register
In-Reply-To: <1465850226-37420-1-git-send-email-manu@freebsd.org>
References: <1465850226-37420-1-git-send-email-manu@freebsd.org>
Message-ID: <CAGb2v65fcarCzzboRonVrpRFzOCzXhHJHB6feq7vXRrQSHm9CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 14, 2016 at 4:37 AM, Emmanuel Vadot <manu@freebsd.org> wrote:
> Hi everyone,
>
> The mmc fifo register in A31 and later is at address 0x200 (0x100 for A10 and A20).
> Therefore the compatible string shouldn't be the same.

You should explain this in the commit logs of the patches.

I understand you're coming from FreeBSD, but there's a different process
for the Linux kernel. The commit subject should follow the format you can
find in the git history, such as "ARM: dts: sunXi: ..." or "mmc: sunxi: ...".

You should send the patches to the respective maintainers and CC the relevant
maintainers. Use "scripts/get_maintainer.pl" for this.

Regards
ChenYu

> Emmanuel Vadot (3):
>   Change compatible string to "allwinner,sun6i-a31-mmc" for A31, A23-A33
>     and H3.
>   Add "allwinner,sun6i-a31-mmc" compatible string in the Documentation.
>   Add "allwinner,sun6i-a31-mmc" support in the driver.
>
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 3 ++-
>  arch/arm/boot/dts/sun6i-a31.dtsi                    | 8 ++++----
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi                | 6 +++---
>  arch/arm/boot/dts/sun8i-h3.dtsi                     | 6 +++---
>  drivers/mmc/host/sunxi-mmc.c                        | 1 +
>  5 files changed, 13 insertions(+), 11 deletions(-)
>
> --
> 2.8.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

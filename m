From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 5 Jul 2017 19:13:38 +0300
Subject: [PATCH v2 2/2] ARM: shmobile: defconfig: Enable Ethernet AVB
In-Reply-To: <1499270189-29945-3-git-send-email-biju.das@bp.renesas.com>
References: <afcd181c-c805-8f3c-955f-652d001a03d4@cogentembedded.com>
 <1499270189-29945-1-git-send-email-biju.das@bp.renesas.com>
 <1499270189-29945-3-git-send-email-biju.das@bp.renesas.com>
Message-ID: <12c32eee-8e4d-457e-97d7-625a5c63ad59@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 07/05/2017 06:56 PM, Biju Das wrote:

> The iWave RZ/G1M Q7 SOM supports Gigabit Ethernet Phy (Micrel KSZ9031MNX).
> Gigabit Ethernet support is available in Renesas AVB driver.
> To increase hardware support enable the driver in the shmobile_defconfig
> multiplatform configuration.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/configs/shmobile_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index 3c66a42..d992911 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -83,6 +83,7 @@ CONFIG_NETDEVICES=y
>  # CONFIG_NET_VENDOR_MICREL is not set
>  # CONFIG_NET_VENDOR_NATSEMI is not set
>  CONFIG_SH_ETH=y
> +CONFIG_RAVB=y

    Hm, I would enable it only as a module, given it's not easy to make use of 
AVB on the 32-bit boards.

[...]

MBR Sergei

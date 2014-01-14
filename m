From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 14 Jan 2014 09:30:39 +0100
Subject: [PATCH] ARM: shmobile: koelsch: Enable DEVTMPFS_MOUNT in defconfig
In-Reply-To: <20140114003627.GB18217@verge.net.au>
References: <1389525349-3722-1-git-send-email-geert@linux-m68k.org>
 <20140113003811.GI15296@verge.net.au>
 <CAMuHMdWu80dtY_uKtd-t4eYQw3c4Vu=AqbTZ1CnDtc6yeyXiYQ@mail.gmail.com>
 <20140113084920.GE29308@verge.net.au>
 <20140114003627.GB18217@verge.net.au>
Message-ID: <CAMuHMdXksaGazq2e9hNw49SsKf3u4K5VLt5eY-PX6P=VPBEhRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 1:36 AM, Simon Horman <horms@verge.net.au> wrote:
> In the mean time I will queue this up. In doing so I had to resolve
> a minor conflict. The result is as follows. Please check it.
>
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>
> ARM: shmobile: koelsch: Enable DEVTMPFS_MOUNT in defconfig
>
> Without this, a Debian jessie nfsroot hangs early in the boot process.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> [horms+renesas at verge.net.au: resolved trivial conflict]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
> index 4071e61..3015797 100644
> --- a/arch/arm/configs/koelsch_defconfig
> +++ b/arch/arm/configs/koelsch_defconfig
> @@ -34,6 +34,8 @@ CONFIG_UNIX=y
>  CONFIG_INET=y
>  CONFIG_IP_PNP=y
>  CONFIG_IP_PNP_DHCP=y
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_ATA=y

Looks OK, thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

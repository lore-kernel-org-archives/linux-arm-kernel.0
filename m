From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 20 Feb 2012 19:15:05 +0000
Subject: [PATCH v7 6/8] davinci: dm644x: move vpfe init from soc to
 board	specific files
In-Reply-To: <1324475021-32509-7-git-send-email-manjunath.hadli@ti.com>
References: <1324475021-32509-1-git-send-email-manjunath.hadli@ti.com>
 <1324475021-32509-7-git-send-email-manjunath.hadli@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317C7F07@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manju,

On Wed, Dec 21, 2011 at 19:13:39, Hadli, Manjunath wrote:
> Move all vpfe platform device registrations to the board specific
> file like the rest of the devices, and have all of them together.

I dropped this line from commit text since EMAC and MDIO still
seem to be registered all the time so the "like the rest of the
devices" part isn't really true.

> 
> This would remove the  restriction of inclusion and registration of
> vpfe platform devices for non-vpfe boards.

I don't think the term "non-vpfe board" is in the right sense.
So, I replace this with the expanded form: "boards which do not use vpfe".

Apart from this, I also added the "ARM: " prefix to subject.

> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
> index 7d940f5..71aae93 100644
> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c

> +static struct platform_device *dm644x_video_devices[] __initdata = {
> +	&dm644x_vpss_device,
> +	&dm644x_ccdc_dev,
> +	&dm644x_vpfe_dev,
> +};

You add this array here and remove it in the very next patch. That's
not the right way of doing things. I dropped this array when committing
this patch.

Thanks,
Sekhar

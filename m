From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Jan 2018 15:47:40 +0100
Subject: [PATCH 2/2] soc: bcm: brcmstb: Be multi-platform compatible
In-Reply-To: <20180112210815.9684-3-f.fainelli@gmail.com>
References: <20180112210815.9684-1-f.fainelli@gmail.com>
 <20180112210815.9684-3-f.fainelli@gmail.com>
Message-ID: <CAK8P3a1H1y_f2M9a0F_CcsCgfx8Y2T=MHH9K+4=YqVN3_fB4wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 10:08 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> We were making a bunch of wrong assumptions that turned out to blow out
> on non-Broadcom STB platforms:
>
> - we would return -ENODEV from brcmstb_soc_device_early_init() if we
>   could not find the sun_top_ctrl device node, this is not an error
>   in the context of a multi-platform kernel
> - we would still try to register the Broadcom STB SoC device, even if we
>   are not running on such a platform
>
> While at it, also fix the sun_top_ctrl device_node leaks while we change
> the flow of brcmstb_soc_device_init() and
> brcmstb_soc_device_early_init().
>
> Fixes: f780429adfbc ("soc: brcmstb: biuctrl: Move to early_initcall")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> [florian: Combine all of Thierry's patch in one go for easier review]
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied both to next/drivers, thanks!

         Arnd

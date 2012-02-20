From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 20 Feb 2012 20:23:12 +0000
Subject: [PATCH v7 7/8] davinci: dm644x: add support for v4l2 video display
In-Reply-To: <1324475021-32509-8-git-send-email-manjunath.hadli@ti.com>
References: <1324475021-32509-1-git-send-email-manjunath.hadli@ti.com>
 <1324475021-32509-8-git-send-email-manjunath.hadli@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317C8008@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manju,

On Wed, Dec 21, 2011 at 19:13:40, Hadli, Manjunath wrote:
> Create platform devices for various video modules like venc,osd,
> vpbe and v4l2 driver for dm644x. Change the dm644x_init_video to
> make room for display config, and register the vpfe or vpbe devices
> based on the config pointer validity to make sure boards without vpfe
> or vpbe can be built with minimal changes.

> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> +static int dm644x_venc_setup_clock(enum vpbe_enc_timings_type type,
> +				   unsigned int mode)
> +{
> +	int ret = 0;
> +	void __iomem *vpss_clkctl_reg;
> +
> +	vpss_clkctl_reg = DAVINCI_SYSMODULE_VIRT(0x44);

Please define a macro for the register offset in davinci.h
and use it here. You can also get rid of the variable.

> +
> +	switch (type) {
> +	case VPBE_ENC_STD:
> +		writel(0x18, vpss_clkctl_reg);

Can you please use some masks to clarify how this and other such magic
numbers below (0x19, 0xa) are arrived at?

I would have made this change myself as I was doing it for rest
of the patches so far, but I cant seem to find the register definition
in any of the documentation I have looked at so far!

I have pushed patches 3-6 into 'v3.4/cleanup' branch of my tree[1].
Can you re-submit the remaining to patches after rebasing to
this branch? I have very little time left before I plan to send
the first sent of v3.4 changes to Arnd/Olof so please get back
quickly. Thanks for the help here.

You need to pull 'v3.4/cleanup' after the 'dependencies' branch to take care 
of some build dependencies.

Thanks,
Sekhar

[1] git://gitorious.org/linux-davinci/linux-davinci.git

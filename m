From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 9 Feb 2018 18:08:11 -0200
Subject: [PATCHv3 1/2] ARM: imx53: add secure-reg-access support for PMU
In-Reply-To: <20180209170358.7227-2-sebastian.reichel@collabora.co.uk>
References: <20180209170358.7227-1-sebastian.reichel@collabora.co.uk>
 <20180209170358.7227-2-sebastian.reichel@collabora.co.uk>
Message-ID: <CAOMZO5BvV8W0ORUG4K6OXE8OuZRn6Az6PeYd8niHe=RgzWJskw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 9, 2018 at 3:03 PM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:

> +       gpc_reg = ioremap(MXC_CORTEXA8_PLAT_GPC, 4);
> +       if (!gpc_reg) {
> +               pr_warning("unable to map GPC to enable perf\n");
> +               return;
> +       }
> +
> +       gpc = __raw_readl(gpc_reg);

You could use readl_relaxed() instead.

> +       gpc |= GPC_DBG_EN;
> +       __raw_writel(gpc, gpc_reg);

You could use writel_relaxed() instead.

> +
> +       return;

This 'return' can be removed.

> +}

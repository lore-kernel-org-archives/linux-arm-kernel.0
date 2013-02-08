From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 8 Feb 2013 09:09:42 +0100
Subject: [PATCH 1/4] ARM: tegra: Unify tegra{20,30,114}_init_early()
In-Reply-To: <20130208074720.GB21879@arwen.pp.htv.fi>
References: <1360308574-19658-1-git-send-email-hdoyu@nvidia.com><1360308574-19658-2-git-send-email-hdoyu@nvidia.com><20130208074720.GB21879@arwen.pp.htv.fi>
Message-ID: <20130208.100942.592982910310763762.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

Felipe Balbi <balbi@ti.com> wrote @ Fri, 8 Feb 2013 08:47:20 +0100:

> > +#if defined(CONFIG_ARCH_TEGRA_3x_SOC)
>
> how about using:
>
> #if IS_BUILTIN(CONFIG_ARCH_TEGRA_3x_SOC)
>
> instead ?

Why is IS_BUILTIN() prefered?

> > -void tegra20_hotplug_init(void);
> > -void tegra30_hotplug_init(void);
> > +void tegra20_hotplug_shutdown(void);
> > +void tegra30_hotplug_shutdown(void);
>
> aren't these two called only by tegra_hotplug_init() now ?

Yes

> That means they don't need to be exposed.

tegra{20,30}_hotplug_shutdown are defined in sleep-tegra{20,30}.S and
used in hotplug.c So I think that the above are necessary here.

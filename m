From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Dec 2010 17:57:27 -0800
Subject: [PATCH v2] OMAP4: Pandaboard: Fix MMC card detect gpio line
In-Reply-To: <1292940874-21419-1-git-send-email-nm@ti.com>
References: <1292940874-21419-1-git-send-email-nm@ti.com>
Message-ID: <20101222015726.GQ5829@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [101221 06:14]:
> From: Raghuveer Murthy <raghuveer.murthy@ti.com>
> 
> commit bf56f0a6668cd (2.6.37-rc1), from Nishanth Menon attempted
> to fix card detection for PandaBoard, unfortunately, the fix missed
> to initialize .gpio_cd member of omap2_hsmmc_info. This results
> in a default value of '0', which is a valid GPIO line.
> On PandaBoard, the side effect of this is that GPIO line 0 controls
> the powering TFP410 DVI chip, and without the fix DVI chip is
> inadvertently powered.
> 
> Tested-by: David Anders <x0132446@ti.com>
> 
> Acked-by: Nishanth Menon <nm@ti.com>
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
> ---
> v2: updated comment description to point out the potential regression.
>    it might be nice to have this in .37 rc cycle as the change was
>    introduced in .37-rc1, however, the DVI functionality(which is impacted
>    as a side effect) is not enabled in .37 rc.

I'll queue this for .38 because of "it never worked earlier either" logic.

Thanks,

Tony

From: tony@atomide.com (Tony Lindgren)
Date: Fri, 13 Feb 2015 10:33:28 -0800
Subject: [PATCHv2 00/33] ARM: OMAP2+: PRCM/omap ctrl cleanups against
 3.19-rc1
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Message-ID: <20150213183327.GQ2531@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

* Tero Kristo <t-kristo@ti.com> [150213 08:16]:
> Hi,
> 
> Updates since v1:
> 
> - fixed omap2/am33xx boot issues
> - added regmap support to generic omap clock core
> - control module driver converted to use syscon

I made some comments to patch 25 of this series detailing
how we should limit the syscon usage to the scm_conf register
area only.

> - dropped patches for removing legacy pad muxing support (this is still
>   needed)

Sounds like this can be moved to the DSS driver using the
syscon area as long as these are not in the pinctrl-single
padconf register area. Preferrably implementing some standard
Linux framework, along the lines pbias-regulator.c is handling
the SCM register for MMC.

Regards,

Tony

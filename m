From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 01 Dec 2014 15:25:06 +0200
Subject: build regression with "rcar-du: Remove platform data support"
In-Reply-To: <12234794.nfiRtpFgV8@wuerfel>
References: <12234794.nfiRtpFgV8@wuerfel>
Message-ID: <5028621.aLK7lB68Yl@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Monday 01 December 2014 14:09:36 Arnd Bergmann wrote:
> Hi Laurent,
> 
> linux-next has failed to build with lager_defconfig and marzen_defconfig for
> a while, with this error:
> 
> arch/arm/mach-shmobile/board-lager.c:35:41: fatal error:
> linux/platform_data/rcar-du.h: No such file or directory #include
> <linux/platform_data/rcar-du.h>
> 
> which is evidently the result of your patch
> 
> commit 2378ad1228d2cdae0ea5448beb4fb2b42ebaf99c
> Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Date:   Wed Sep 17 02:07:52 2014 +0300
> 
>     drm: rcar-du: Remove platform data support
> 
>     All platforms now instantiate the DU through DT, platform data support
>     isn't needed anymore.
> 
>     Signed-off-by: Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com>
> 
> that removes the header files. I assume some dependency wasn't tracked
> right, since linux-next still has these.
> 
> $ git grep rcar_du_ arch/arm
> arch/arm/mach-shmobile/board-lager.c:static struct rcar_du_encoder_data
> lager_du_encoders[] = { arch/arm/mach-shmobile/board-lager.c:static const
> struct rcar_du_platform_data lager_du_pdata __initconst = {
> arch/arm/mach-shmobile/board-marzen.c:static struct rcar_du_encoder_data
> du_encoders[] = { arch/arm/mach-shmobile/board-marzen.c:static const struct
> rcar_du_platform_data du_pdata __initconst = {
> 
> Can we please fix this before the merge window? Should the platform
> device registration just get removed from the two board files?

That's what I've proposed in

http://www.spinics.net/lists/dri-devel/msg72750.html

Dave, could you please reply to that ?

-- 
Regards,

Laurent Pinchart

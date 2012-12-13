From: tomba@iki.fi (Tomi Valkeinen)
Date: Thu, 13 Dec 2012 13:07:37 +0200
Subject: [PATCH 1/1] net: cpts: fix for build break after ARM SoC
 integration
In-Reply-To: <1354012034-31686-1-git-send-email-mugunthanvnm@ti.com>
References: <1354012034-31686-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <50C9B6F9.9020300@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2012-11-27 12:27, Mugunthan V N wrote:
>   CC      drivers/net/ethernet/ti/cpts.o
> drivers/net/ethernet/ti/cpts.c:30:24: fatal error: plat/clock.h: No such file or directory
> compilation terminated.
> make[4]: *** [drivers/net/ethernet/ti/cpts.o] Error 1
> make[3]: *** [drivers/net/ethernet/ti] Error 2
> make[2]: *** [drivers/net/ethernet] Error 2
> make[1]: *** [drivers/net] Error 2
> 
> fix for build break as the header file is removed from plat-omap as part of
> the below patch

linux-next still has this build problem, I guess this patch is lingering
somewhere. Somewhat annoying, as the driver is enabled by default. (btw,
why is it "default y"?)

 Tomi

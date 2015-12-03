From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Dec 2015 16:56:07 +0000
Subject: [PATCH v4 0/4] drm: Add support for the ARM HDLCD display
 controller
In-Reply-To: <1449139249-9171-1-git-send-email-Liviu.Dudau@arm.com>
References: <1449139249-9171-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20151203165606.GS8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 10:40:45AM +0000, Liviu Dudau wrote:
> This series depends on Sudeep Holla's SCPI driver (now in mainline) and on
> the tda998x patches that have been queued on Russell's patch system here [1].

Now merged into my tree.

Can I ask a fairly obvious question...

>  drivers/gpu/drm/Kconfig                            |   2 +
>  drivers/gpu/drm/Makefile                           |   1 +
>  drivers/gpu/drm/arm/Kconfig                        |  29 ++
>  drivers/gpu/drm/arm/Makefile                       |   2 +
>  drivers/gpu/drm/arm/hdlcd_crtc.c                   | 327 ++++++++++++
>  drivers/gpu/drm/arm/hdlcd_drv.c                    | 555 +++++++++++++++++++++
>  drivers/gpu/drm/arm/hdlcd_drv.h                    |  42 ++
>  drivers/gpu/drm/arm/hdlcd_regs.h                   |  87 ++++

Why is the subdirectory called "arm" and not "hdlcd" ?

ARM Ltd have more than one display controller (they have the AMBA PL110
and PL111 in addition to this), and (afaics) this doesn't drive these.
HDLCD probably won't be the last display hardware which ARM Ltd comes
out with either.

So, I think naming the subdirectory after the vendor is probably a
mistake.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

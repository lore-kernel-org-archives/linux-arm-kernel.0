From: m.silentcreek@gmail.com (m.silentcreek at gmail.com)
Date: Sat, 19 Dec 2015 13:39:36 -0800 (PST)
Subject: BUG - Bananapi USB not working on Mainline
In-Reply-To: <ec8d762c-3e2b-4438-a43e-ae2740f8a5f3@googlegroups.com>
References: <CAOP4N=_Ux0FPSRep7AfBVovd59LeDTbBjH=LBdfWDb6Mc3e=Fg@mail.gmail.com>
 <ec8d762c-3e2b-4438-a43e-ae2740f8a5f3@googlegroups.com>
Message-ID: <ed63cc0b-fb90-4947-ab4c-b89655538a1a@googlegroups.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Samstag, 19. Dezember 2015 20:38:08 UTC+1 schrieb Hans de Goede:
> The sunxi usb-phy driver now requires extcon (due to the added otg support), maybe the defconfig is not enabling extcon and thereby you are not getting the sunxi usb-phy driver build, or not build-in at least ?
> 
> Can you edit .config after the make defconfig and see what the value for CONFIG_PHY_SUN4I_USB is ?

I found the solution! The problem is CONFIG_AXP20X_POWER which was introduced in 4.4-rc1 but defaults to no and not set in sunxi_defconfig. Adding CONFIG_AXP20X_POWER=y to sunxi_defconfig solves that and get's my USB devices working again on linux 4.4-rc5. I actually brought that up on IRC once, but at that time nobody seemed to know so I forgot it again.

Anyway, wouldn't it be a better to just have it automatically be selected when e.g. CONFIG_PHY_SUN4I_USB or something else that depends on it is enabled?

Regards,

Timo

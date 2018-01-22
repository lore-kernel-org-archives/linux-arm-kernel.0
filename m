From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 22 Jan 2018 16:43:55 +0530
Subject: [PATCH 0/6] ARM: davinci: common clock prep work
In-Reply-To: <1516418424-28686-1-git-send-email-david@lechnology.com>
References: <1516418424-28686-1-git-send-email-david@lechnology.com>
Message-ID: <28bb9f44-c6b5-e2e9-2d13-5b50dbceac7b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 08:50 AM, David Lechner wrote:
> This series contains some changes needed for the conversion of arch/arm/mach-
> davinci to the common clock framework.
> 
> Most of the boards in mach-davinci do not have device tree support. However,
> CFGCHIP, which is a syscon regmap, is needed during clock init in early boot.
> Using a platform device for the syscon at this point is not an option. So,
> this series introduces a new way to register a syscon regmap on non-DT systems.
> 
> The DA8XX USB PHY driver is a consumer of the CFGCHIP syscon regmap, so some
> changes are needed in that driver as well since we are removing the syscon
> platform devices. The patch "phy: da8xx-usb: rename clock con_ids" doesn't
> have anything to do with syscon, but I included in this series because we are
> touching PHY code here anyway and it is also a dependency for the upcoming
> common clock framework conversion changes.
> 
> Maintainers, please coordinate with Sekhar before committing. We will probably
> want everything to go through the linux-davinci tree if possible.

You should wait for some more feedback before resending anything, but I
think it will be easier to reivew/accept this if the changes are just
related to removal of "syscon" platform device from devices-da8xx.c.

It _seems_ like this series does more than just that, and I hope it can
be pared down.

Thanks,
Sekhar

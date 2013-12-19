From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Dec 2013 14:40:23 -0700
Subject: [PATCH 05/10] ARM: tegra: Enable eDP for Venice2
In-Reply-To: <1387469182-14398-6-git-send-email-treding@nvidia.com>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
 <1387469182-14398-6-git-send-email-treding@nvidia.com>
Message-ID: <52B367C7.9010301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 09:06 AM, Thierry Reding wrote:
> Venice2 has a 12.9" (2560x1700) panel connected to the eDP output of the
> Tegra124. The panel has an EDID to describe the video timings but needs
> a few extra nodes to get the backlight to come up.

I started with next-20131219, merged your latest drm/for-next branch,
and this doesn't seem to work.

With Laxman's regulator patch applied and your 1/10 dropped since it's a
duplicate, the LCD backlight doesn't light up. I extracted the following
from this patch to fix Laxman's regulator definitions:

                        gpio = <&gpio TEGRA_GPIO(P, 2) GPIO_ACTIVE_LOW>;
+                       enable-active-high;
                };

and the backlight does light up, but that's all.

With Laxman's regulator patch reverted and your patch 1/10 applied to
replace it, I see the backlight working without having to manually fix
up the device tree. However, that's still all; nothing is actually
displayed.

Again, can you please rebase this whole series on the latest Tegra
for-3.14/dt and sort out the issues? Thanks.

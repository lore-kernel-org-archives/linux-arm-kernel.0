From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 04 Sep 2012 15:48:31 -0600
Subject: [PATCH v2] usb: move phy driver from mach-tegra to drivers/usb
In-Reply-To: <1346395526-18219-1-git-send-email-vbyravarasu@nvidia.com>
References: <1346395526-18219-1-git-send-email-vbyravarasu@nvidia.com>
Message-ID: <5046772F.6060908@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2012 12:45 AM, Venu Byravarasu wrote:
> As part of this patch:
> 	1. Moved existing tegra phy driver to drivers/USB directory.
> 	2. Added standard USB phy driver APIs to tegra phy driver.
> 
> Signed-off-by: Venu Byravarasu <vbyravarasu@nvidia.com>

Tested-by: Stephen Warren <swarren@nvidia.com>

Felipe, Would it be possible to apply this patch to a topic branch, so
that I can merge it into the Tegra tree? The reason is that I'd like to
remove Tegra's devices.[ch] in kernel 3.7, but to do that, I need to
move a tiny chunk of code out of that file somewhere else, and doing
that relies on adding a #include to usb_phy.h/tegra_usb_phy.h, which is
renamed in this patch.

Alternatively, if you don't think it'll cause any merge conflicts with
the USB PHY tree, I can just take this patch through the Tegra tree if
you want. Venu, do you plan any other patches within the next couple
weeks or so (i.e. before 3.6-rc6) that will depend on this patch? If so,
taking it only through the Tegra tree might not work so well.

Thanks.

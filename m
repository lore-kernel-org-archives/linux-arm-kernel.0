From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jan 2016 15:03:13 +0100
Subject: [PATCH for 4.4-rc8] ARM: Fix broken USB support in
 multi_v7_defconfig for sunxi devices
In-Reply-To: <1451655502-8561-1-git-send-email-public_timo.s@silentcreek.de>
References: <1451353653-17484-1-git-send-email-public_timo.s@silentcreek.de>
 <1451655502-8561-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <4046652.SybV1IGrL0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 January 2016 14:38:22 Timo Sigurdsson wrote:
> Commit 69fb4dcada77 ("power: Add an axp20x-usb-power driver") introduced a
> new driver for the USB power supply used on various Allwinner based SBCs.
> However, the driver was not added to multi_v7_defconfig which breaks USB
> support for some boards (e.g. LeMaker BananaPi) as the kernel will now
> turn off the USB power supply during boot by default if the driver isn't
> present. (This was not the case in linux 4.3 or lower where the USB power
> was always left on.)
> 
> Hence, add the driver to multi_v7_defconfig in order to keep USB support
> working on those boards that require it.
> 
> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
> Tested-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> Notes:
> 
> I chose to add AXP20X_POWER as a module here, since linux-next already
> has it this way, see commit 83e9e1f84074 ("ARM: multi_v7_defconfig:
> Enable RSB and AXP20X related drivers as modules").
> 

Applied to fixes, thanks!

	Arnd

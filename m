From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Oct 2015 15:22:54 +0200
Subject: [RFC PATCH] ARM: exynos_defconfig: Increase
 CONFIG_BLK_DEV_RAM_SIZE to 64K
In-Reply-To: <1445251715-9725-1-git-send-email-alim.akhtar@samsung.com>
References: <1445251715-9725-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <4039144.iLSv7qv3SU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 October 2015 16:18:35 Alim Akhtar wrote:
> Spam Status: CRM114    
> CONFIG_BLK_DEV_RAM_SIZE is currently set to 8K, which is a bit on the
> smaller side, lets bump it up to 64K so that a bigger RAM_DISK can
> be used with defconfig.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
> Every time I build exynos_defconfig, I need to manually change RAM_SIZE
> to match my ramdisk image size. I am not sure what is the best ramdisk size
> might be, but bumping it to 64K might be a reasonable one.

Is there still a reason to use ramdisks these days? If 8MB is not
enough to have a useful initrd, that might mean that everyone else
uses initramfs and you should just do the same thing?

Then we can also remove this option here.

	Arnd

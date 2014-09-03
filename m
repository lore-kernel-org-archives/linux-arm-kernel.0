From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 15:27:30 +0200
Subject: [PATCH] ARM: cns3xxx: fix allmodconfig panic in pci driver
In-Reply-To: <1409750292-24105-1-git-send-email-kaixu.xia@linaro.org>
References: <kaixu.xia@linaro.org>
 <1409750292-24105-1-git-send-email-kaixu.xia@linaro.org>
Message-ID: <2886818.zPBP0DOepO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 21:18:12 Xia Kaixu wrote:
> From: Xia Kaixu <kaixu.xia@linaro.org>
> 
> The kernel panic occurs when running an allmodconfig kernel on 
> OMAP4460. The inicall "cns3xxx_pcie_init" does not check which
> hardware it's running on and just tries to access to its specific 
> registers. Now call it from .init_late callback from the two
> machine descriptors.
> 
> Signed-off-by: Xia Kaixu <kaixu.xia@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Felix Fietkau <nbd@openwrt.org>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: linaro-kernel at lists.linaro.org
> Cc: linux-arm-kernel at lists.infradead.org

Hi Kaixu,

it seems this time all the Cc's worked. One thing I just noticed is that
you confused the 'Signed-off-by' lines. I did look at the patch earlier
before you sent it out but unfortunately missed that.

You can read again in Documentation/SubmittingPatches about how
they work, but the short version is that you must never put someone
else's name in Signed-off-by under a patch you write yourself.
When we apply the patch, I (or whoever else does) will put that
line below yours to document who handled the patch.

Otherwise, the patch looks good to me, thanks a lot for doing it.

	Arnd

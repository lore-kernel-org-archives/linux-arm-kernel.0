From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 30 Oct 2017 11:11:02 +0200
Subject: [PATCH 0/2] ARM: OMAP3: fix boot regression for N9
Message-ID: <1509354664-27694-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

N9 boot is apparently broken with mainline, caused by some recent
changes to TI clock drivers. The reason for failing boot is effectively
missing hwmod data piece for MMC3, so add this in place. The CM
related fix is also needed to properly handle idlest functionality
on OMAP3; currently this is mostly masked but will cause issues in
some places.

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 13 Sep 2018 19:02:31 +0200
Subject: [PATCH v2 02/24] drivers/video/fbdev: use ioremap_wc/wt()
 instead of __ioremap()
In-Reply-To: <2f980cf32a05415662272cf052c2b9e2a94c756f.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
 <CGME20180912155824epcas5p17cd1e14fa1cb246362ec47b15248cf71@epcas5p1.samsung.com>
 <2f980cf32a05415662272cf052c2b9e2a94c756f.1536692743.git.christophe.leroy@c-s.fr>
Message-ID: <20180913170233eucas1p19e6cd20020f27bb4db0cd927bb9a3302~UBFkQTUaX2145421454eucas1p1M@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/12/2018 05:58 PM, Christophe Leroy wrote:
> _PAGE_NO_CACHE is a platform specific flag. In addition, this flag
> is misleading because one would think it requests a noncached page
> whereas a noncached page is _PAGE_NO_CACHE | _PAGE_GUARDED
> 
> _PAGE_NO_CACHE alone means write combined noncached page, so lets
> use ioremap_wc() instead.
> 
> _PAGE_WRITETHRU is also platform specific flag. Use ioremap_wt()
> instead.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

After reading patch #1 this one LGTM.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  drivers/video/fbdev/chipsfb.c    |  3 +--
>  drivers/video/fbdev/controlfb.c  |  5 +----
>  drivers/video/fbdev/platinumfb.c |  5 +----
>  drivers/video/fbdev/valkyriefb.c | 12 ++++++------
>  4 files changed, 9 insertions(+), 16 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

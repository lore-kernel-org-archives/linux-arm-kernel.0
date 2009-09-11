From: p.osciak@samsung.com (Pawel Osciak)
Date: Fri, 11 Sep 2009 20:05:00 +0200
Subject: [PATCH 5/7] [ARM] s3c-fb: Added missing window enabled state updates.
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0771185D5C@bssrvexch01.BS.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>

---
 drivers/video/s3c-fb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 307a7e8..226d225 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -401,6 +401,7 @@ static int s3c_fb_set_par(struct fb_info *info)
 		writel(osdc_data, regs + VIDOSD_C(win_no));
 
 	data = WINCONx_ENWIN;
+	sfb->enabled |= (1 << win_no);
 
 	/* note, since we have to round up the bits-per-pixel, we end up
 	 * relying on the bitfield information for r/g/b/a to work out
@@ -633,6 +634,7 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
 		/* disable the DMA and display 0x0 (black) */
 		writel(WINxMAP_MAP | WINxMAP_MAP_COLOUR(0x0),
 		       sfb->regs + WINxMAP(index));
+        sfb->enabled &= ~(1 << index);
 		break;
 
 	case FB_BLANK_UNBLANK:
-- 
1.6.4.2.253.g0b1fac

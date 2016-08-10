From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Wed, 10 Aug 2016 22:48:47 +0800
Subject: [PATCH v4 2/9] v4l: add Mediatek compressed video block format
In-Reply-To: <1470840534-4788-2-git-send-email-tiffany.lin@mediatek.com>
References: <1470840534-4788-1-git-send-email-tiffany.lin@mediatek.com>
 <1470840534-4788-2-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <1470840534-4788-3-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add V4L2_PIX_FMT_MT21C format used on MT8173 driver.
It is compressed format and need MT8173 MDP driver to transfer to other
standard format.

Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c |    1 +
 include/uapi/linux/videodev2.h       |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 51a0fa1..d4ee0b8 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1282,6 +1282,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_JPGL:		descr = "JPEG Lite"; break;
 		case V4L2_PIX_FMT_SE401:	descr = "GSPCA SE401"; break;
 		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
+		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
 		default:
 			WARN(1, "Unknown pixelformat 0x%08x\n", fmt->pixelformat);
 			if (fmt->description[0])
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 724f43e..36210db 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -627,6 +627,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_Y8I      v4l2_fourcc('Y', '8', 'I', ' ') /* Greyscale 8-bit L/R interleaved */
 #define V4L2_PIX_FMT_Y12I     v4l2_fourcc('Y', '1', '2', 'I') /* Greyscale 12-bit L/R interleaved */
 #define V4L2_PIX_FMT_Z16      v4l2_fourcc('Z', '1', '6', ' ') /* Depth data 16-bit */
+#define V4L2_PIX_FMT_MT21C    v4l2_fourcc('M', 'T', '2', '1') /* Mediatek compressed block mode  */
 
 /* SDR formats - used only for Software Defined Radio devices */
 #define V4L2_SDR_FMT_CU8          v4l2_fourcc('C', 'U', '0', '8') /* IQ u8 */
-- 
1.7.9.5

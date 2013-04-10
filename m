From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 10 Apr 2013 17:33:01 +1000
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20130410173301.a9fb60beb9ca0865c93930f0@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in
arch/arm/mach-imx/clk-imx6q.c between commit e8094b2c1712 ("ARM i.MX6:
Fix ldb_di clock selection") from the arm-soc tree and commit
8034cf45ac38 ("ARM i.MX6q: Add audio/video PLL post dividers for i.MX6q
rev 1.1") from the imx-mxs tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-imx/clk-imx6q.c
index d38e54f,65319d5..0000000
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@@ -115,8 -187,8 +187,8 @@@ static const char *gpu2d_core_sels[]	= 
  static const char *gpu3d_core_sels[]	= { "mmdc_ch0_axi", "pll3_usb_otg", "pll2_pfd1_594m", "pll2_pfd2_396m", };
  static const char *gpu3d_shader_sels[] = { "mmdc_ch0_axi", "pll3_usb_otg", "pll2_pfd1_594m", "pll2_pfd9_720m", };
  static const char *ipu_sels[]		= { "mmdc_ch0_axi", "pll2_pfd2_396m", "pll3_120m", "pll3_pfd1_540m", };
- static const char *ldb_di_sels[]	= { "pll5_video", "pll2_pfd0_352m", "pll2_pfd2_396m", "mmdc_ch1_axi", "pll3_usb_otg", };
- static const char *ipu_di_pre_sels[]	= { "mmdc_ch0_axi", "pll3_usb_otg", "pll5_video", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd1_540m", };
 -static const char *ldb_di_sels[]	= { "pll5_video_div", "pll2_pfd0_352m", "pll2_pfd2_396m", "mmdc_ch1_axi", "pll3_pfd1_540m", };
++static const char *ldb_di_sels[]	= { "pll5_video_div", "pll2_pfd0_352m", "pll2_pfd2_396m", "mmdc_ch1_axi", "pll3_usb_otg", };
+ static const char *ipu_di_pre_sels[]	= { "mmdc_ch0_axi", "pll3_usb_otg", "pll5_video_div", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd1_540m", };
  static const char *ipu1_di0_sels[]	= { "ipu1_di0_pre", "dummy", "dummy", "ldb_di0", "ldb_di1", };
  static const char *ipu1_di1_sels[]	= { "ipu1_di1_pre", "dummy", "dummy", "ldb_di0", "ldb_di1", };
  static const char *ipu2_di0_sels[]	= { "ipu2_di0_pre", "dummy", "dummy", "ldb_di0", "ldb_di1", };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130410/c275be55/attachment.sig>

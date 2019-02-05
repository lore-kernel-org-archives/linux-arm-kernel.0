Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71A2C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:29:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B124920811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nWurZebW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B124920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oyqpecKMEdshdGPVPEGEjne1w+bPs5QRYiHvEbsoAgE=; b=nWurZebWIyiOs+
	aL6e08I3S+SqsRLce/61hioEZm3DU43OZ/zOqpKyXF7ChkvhC02PENfU6bLdMcuMw2EwoLt/jbFsZ
	MiC88PLcNt48cF+fuAj+vHG9nUBVntx4exHEwdFV9s9sTIY3b0TSqNNeYpX90I8mb1kXwGfXTHFEt
	YLolcUxomTX331hwYcAGANv7K1DjzFrm5A81EcV3JljKXR49bj/8vebVhH0DYtLcM8x0CQdcxFABp
	44sr47aMbS6KpCkoC1Y38DXa4UFYGvl4CyTevPF1mS+bDm6jMc1HHcN/8dudbIRmeD4kSTzCjLO8J
	uwARiVLWJ1NM42plbirA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr5Sv-00034p-K9; Tue, 05 Feb 2019 18:29:01 +0000
Received: from mail-ed1-f66.google.com ([209.85.208.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr5Sr-00034G-PL
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 18:28:59 +0000
Received: by mail-ed1-f66.google.com with SMTP id h15so3735519edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 10:28:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GUWL4HFbA0WThx5vSNz7vo6qnGLO2X6rwMGIHTJGgmQ=;
 b=aQQR/QBuivjbu0r+P+FTJfjDKnDpDTqj1E09c3RSMjsM0elSldtWFr9T6W+TsH+1xm
 Zzzs5gi9Lene0MR4p2hPMnEoXmi85C6qb3ubcM1olkdmJN7svMTXwN+GxLHXDZ9m0U9u
 CcXd/mD7t1bigKkdOWH72m9AAjM9mxcqTbm4XaOrC8EkBBdu+Gm6v6WazMk4wt/id0+6
 Mm7rVuR3+UwT4C2uQ60GSZz1X2MISVcbQY/p6Gti5P3VNZA/x2ooQxLZ+c8WD1CfQC83
 b97YUMEBJkIu2ygZu8+JcNm5Jta+rPkgSroPErddv/6E8J+rnmaIab+leYiklfRb8RyA
 Mfyw==
X-Gm-Message-State: AHQUAubF1AiOTLk+bsNz26vHzgvem977aH9Pm+tiwl2YkfiqMI+N8xLT
 ZTTjqq+zz9DnWtrU8eNRTBX3WIvZj+c=
X-Google-Smtp-Source: AHgI3IYOcMBkqQ7u4/bGVpSXZITy94u6qz5zwd+U2F6mNXAH2/L46qkvd6Y/POwJ0eYJ8shNFZ73xA==
X-Received: by 2002:a17:906:5053:: with SMTP id
 e19mr4585116ejk.9.1549391335470; 
 Tue, 05 Feb 2019 10:28:55 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com.
 [209.85.221.51])
 by smtp.gmail.com with ESMTPSA id c12sm4934275edi.52.2019.02.05.10.28.54
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 10:28:54 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id s12so4772766wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 10:28:54 -0800 (PST)
X-Received: by 2002:a5d:5208:: with SMTP id j8mr4922696wrv.188.1549391333880; 
 Tue, 05 Feb 2019 10:28:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
 <1416f6a45cf6da7ea28e17becd5f257a49746e04.1548236066.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <1416f6a45cf6da7ea28e17becd5f257a49746e04.1548236066.git-series.maxime.ripard@bootlin.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 6 Feb 2019 02:28:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v64hXpS3-QZDMjcmkR9HsNBf1E-S5AVjWBjNbCPs7nt1Pg@mail.gmail.com>
Message-ID: <CAGb2v64hXpS3-QZDMjcmkR9HsNBf1E-S5AVjWBjNbCPs7nt1Pg@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/sun4i: dsi: Add burst support
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_102857_828610_528164D0 
X-CRM114-Status: GOOD (  30.65  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Konstantin Sudakov <k.sudakov@integrasources.com>, bbrezillon@kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 11:54 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> From: Konstantin Sudakov <k.sudakov@integrasources.com>
>
> The current driver doesn't support the DSI burst operation mode.
>
> Let's add the needed quirks to make it work.
>
> Signed-off-by: Konstantin Sudakov <k.sudakov@integrasources.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 178 +++++++++++++++++++-------
>  1 file changed, 136 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index e3e4ba90c059..6840b3512a45 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -23,7 +23,9 @@
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_panel.h>
>
> +#include "sun4i_crtc.h"
>  #include "sun4i_drv.h"
> +#include "sun4i_tcon.h"
>  #include "sun6i_mipi_dsi.h"
>
>  #include <video/mipi_display.h>
> @@ -32,6 +34,8 @@
>  #define SUN6I_DSI_CTL_EN                       BIT(0)
>
>  #define SUN6I_DSI_BASIC_CTL_REG                0x00c
> +#define SUN6I_DSI_BASIC_CTL_TRAIL_INV(n)               (((n) & 0xf) << 4)
> +#define SUN6I_DSI_BASIC_CTL_TRAIL_FILL         BIT(3)
>  #define SUN6I_DSI_BASIC_CTL_HBP_DIS            BIT(2)
>  #define SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS                BIT(1)
>  #define SUN6I_DSI_BASIC_CTL_VIDEO_BURST                BIT(0)
> @@ -152,6 +156,8 @@
>
>  #define SUN6I_DSI_CMD_TX_REG(n)                (0x300 + (n) * 0x04)
>
> +#define SUN6I_DSI_SYNC_POINT           40
> +
>  enum sun6i_dsi_start_inst {
>         DSI_START_LPRX,
>         DSI_START_LPTX,
> @@ -365,31 +371,101 @@ static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
>         return delay;
>  }
>
> +static u16 sun6i_dsi_get_line_num(struct sun6i_dsi *dsi,
> +                                 struct drm_display_mode *mode)
> +{
> +       struct mipi_dsi_device *device = dsi->device;
> +       unsigned Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
> +
> +       return mode->htotal * Bpp / device->lanes;
> +}
> +
> +static u16 sun6i_dsi_get_drq_edge0(struct sun6i_dsi *dsi,
> +                                  struct drm_display_mode *mode,
> +                                  u16 line_num, u16 edge1)
> +{
> +       u16 edge0 = edge1;
> +
> +       edge0 += (mode->hdisplay + 40) * SUN6I_DSI_TCON_DIV / 8;
> +
> +       if (edge0 > line_num)
> +               return edge0 - line_num;
> +
> +       return 1;
> +}
> +
> +static u16 sun6i_dsi_get_drq_edge1(struct sun6i_dsi *dsi,
> +                                  struct drm_display_mode *mode,
> +                                  u16 line_num)
> +{
> +       struct mipi_dsi_device *device = dsi->device;
> +       unsigned Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
> +       unsigned hbp = mode->htotal - mode->hsync_end;

Allwinner's hbp is actually horizontal back porch plus sync pulse.
So this should be

    hbp = mode->htotal - mode->hsync_start;

> +       u16 edge1;
> +
> +
> +       edge1 = SUN6I_DSI_SYNC_POINT;
> +       edge1 += mode->hdisplay + hbp + 20;
> +       edge1 = edge1 * Bpp / device->lanes;

Compared to the A64 BSP, this seems to be incorrect. The original code was

    edge1 = sync_point +
                (panel->lcd_x + panel->lcd_hbp + 20) *
                dsi_pixel_bits[panel->lcd_dsi_format] /
                (8 * panel->lcd_dsi_lane);

Note that sync_point is outside of the parentheses and should not be
multiplied and divided.

This would make sense if sync_point is a fixed delay that is needed
regardless of the timings.

> +
> +       if (edge1 > line_num)
> +               return line_num;
> +
> +       return edge1;
> +}
> +
>  static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
>                                   struct drm_display_mode *mode)
>  {
>         struct mipi_dsi_device *device = dsi->device;
> -       u32 val = 0;
> +       u32 bpp = mipi_dsi_pixel_format_to_bpp(device->format);
> +       u32 tcon0_drq = 0;
> +
> +       if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> +               u16 line_num = sun6i_dsi_get_line_num(dsi, mode);
> +               u16 edge0, edge1;
> +
> +               edge1 = sun6i_dsi_get_drq_edge1(dsi, mode, line_num);
> +               edge0 = sun6i_dsi_get_drq_edge0(dsi, mode, line_num, edge1);
>
> -       if ((mode->hsync_end - mode->hdisplay) > 20) {
> +               regmap_write(dsi->regs, SUN6I_DSI_BURST_DRQ_REG,
> +                            SUN6I_DSI_BURST_DRQ_EDGE0(edge0) |
> +                            SUN6I_DSI_BURST_DRQ_EDGE1(edge1));
> +
> +               regmap_write(dsi->regs, SUN6I_DSI_BURST_LINE_REG,
> +                            SUN6I_DSI_BURST_LINE_NUM(line_num) |
> +                            SUN6I_DSI_BURST_LINE_SYNC_POINT(SUN6I_DSI_SYNC_POINT));
> +
> +               tcon0_drq = SUN6I_DSI_TCON_DRQ_ENABLE_MODE;
> +       } else if ((mode->hsync_end - mode->hdisplay) > 20) {
>                 /* Maaaaaagic */
>                 u16 drq = (mode->hsync_end - mode->hdisplay) - 20;

This and the above if clause should use hsync_start instead of hsync_end.

The A64 BSP specifies drq = vfp - 20.

> -
> -               drq *= mipi_dsi_pixel_format_to_bpp(device->format);
> +               drq *= bpp;
>                 drq /= 32;
>
> -               val = (SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
> -                      SUN6I_DSI_TCON_DRQ_SET(drq));
> +               tcon0_drq = SUN6I_DSI_TCON_DRQ_ENABLE_MODE |
> +                       SUN6I_DSI_TCON_DRQ_SET(drq);
>         }
>
> -       regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, val);
> +       regmap_write(dsi->regs, SUN6I_DSI_TCON_DRQ_REG, tcon0_drq);
>  }
>
>  static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
>                                       struct drm_display_mode *mode)
>  {
> +       struct mipi_dsi_device *device = dsi->device;
>         u16 delay = 50 - 1;
>
> +       if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> +               delay = (mode->htotal - mode->hdisplay) * 150;
> +               delay /= (mode->clock / 1000) * 8;
> +               delay -= 50;
> +       }
> +
> +       regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_SEL_REG,
> +                        2 << (4 * DSI_INST_ID_LP11) |
> +                        3 << (4 * DSI_INST_ID_DLY));
> +
>         regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
>                      SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
>                      SUN6I_DSI_INST_LOOP_NUM_N1(delay));
> @@ -456,48 +532,66 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
>         struct mipi_dsi_device *device = dsi->device;
>         unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
>         u16 hbp, hfp, hsa, hblk, vblk;
> +       u32 basic_ctl = 0;
>         size_t bytes;
>         u8 *buffer;
>
>         /* Do all timing calculations up front to allocate buffer space */
>
> -       /*
> -        * A sync period is composed of a blanking packet (4 bytes +
> -        * payload + 2 bytes) and a sync event packet (4 bytes). Its
> -        * minimal size is therefore 10 bytes
> -        */
> +       if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> +               hsa = 0;
> +               hbp = 0;
> +               hfp = 0;
> +               hblk = mode->hdisplay * Bpp;
> +               vblk = 0;
> +               basic_ctl = SUN6I_DSI_BASIC_CTL_VIDEO_BURST |
> +                           SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS |
> +                           SUN6I_DSI_BASIC_CTL_HBP_DIS;
> +
> +               if (device->lanes == 4)
> +                       basic_ctl |= SUN6I_DSI_BASIC_CTL_TRAIL_FILL |
> +                                    SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
> +       } else {
> +               /*
> +                * A sync period is composed of a blanking packet (4 bytes +
> +                * payload + 2 bytes) and a sync event packet (4 bytes). Its
> +                * minimal size is therefore 10 bytes
> +                */
>  #define HSA_PACKET_OVERHEAD    10
> -       hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
> -                 (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
> -
> -       /*
> -        * The backporch is set using a blanking packet (4 bytes +
> -        * payload + 2 bytes). Its minimal size is therefore 6 bytes
> -        */
> +               hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
> +                         (mode->hsync_end - mode->hsync_start) * Bpp -
> +                         HSA_PACKET_OVERHEAD);

I believe for all these packets, that minimum value is not needed. The
WC field of the long command packet refers to the length of the payload
only. The payload is used to pad the packet to the desired length, but
is otherwise useless. Likewise, the CRC value is only calculated against
the payload.

Specifying a minimum means you are likely skewing the timings.

> +
> +               /*
> +                * The backporch is set using a blanking packet (4 bytes +
> +                * payload + 2 bytes). Its minimal size is therefore 6 bytes
> +                */
>  #define HBP_PACKET_OVERHEAD    6
> -       hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
> -                 (mode->hsync_start - mode->hdisplay) * Bpp - HBP_PACKET_OVERHEAD);
> -
> -       /*
> -        * The frontporch is set using a blanking packet (4 bytes +
> -        * payload + 2 bytes). Its minimal size is therefore 6 bytes
> -        */
> +               hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
> +                         (mode->hsync_start - mode->hdisplay) * Bpp -
> +                         HBP_PACKET_OVERHEAD);
> +
> +               /*
> +                * The frontporch is set using a blanking packet (4 bytes +
> +                * payload + 2 bytes). Its minimal size is therefore 6 bytes
> +                */
>  #define HFP_PACKET_OVERHEAD    6
> -       hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
> -                 (mode->htotal - mode->hsync_end) * Bpp - HFP_PACKET_OVERHEAD);
> -
> -       /*
> -        * hblk seems to be the line + porches length.
> -        */
> -       hblk = mode->htotal * Bpp - hsa;
> -
> -       /*
> -        * And I'm not entirely sure what vblk is about. The driver in
> -        * Allwinner BSP is using a rather convoluted calculation
> -        * there only for 4 lanes. However, using 0 (the !4 lanes
> -        * case) even with a 4 lanes screen seems to work...
> -        */
> -       vblk = 0;
> +               hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
> +                         (mode->htotal - mode->hsync_end) * Bpp - HFP_PACKET_OVERHEAD);
> +
> +               /*
> +                * hblk seems to be the line + porches length.
> +                */
> +               hblk = mode->htotal * Bpp - hsa;

Based on the timing diagram in section 8.11 of the MIPI DSI spec, hblk is
supposed to take up the remainder of the scan line after the sync event or
sync pulse during the vertical inactive period. It is the BLLP portion.
This seems like the correct value, though it is somewhat simplified.
The packet overhead is gone (cancelled out with the one from hsa).

> +
> +               /*
> +                * And I'm not entirely sure what vblk is about. The driver in
> +                * Allwinner BSP is using a rather convoluted calculation
> +                * there only for 4 lanes. However, using 0 (the !4 lanes
> +                * case) even with a 4 lanes screen seems to work...
> +                */

No idea either.
Hope this helps.

ChenYu


> +               vblk = 0;
> +       }
>
>         /* How many bytes do we need to send all payloads? */
>         bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
> @@ -505,7 +599,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
>         if (WARN_ON(!buffer))
>                 return;
>
> -       regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, 0);
> +       regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, basic_ctl);
>
>         regmap_write(dsi->regs, SUN6I_DSI_SYNC_HSS_REG,
>                      sun6i_dsi_build_sync_pkt(MIPI_DSI_H_SYNC_START,
> --
> git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

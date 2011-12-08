From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 08 Dec 2011 13:03:26 +0530
Subject: [PATCH] video IPUv1 fixes for different display connections
In-Reply-To: <1322747932-24943-1-git-send-email-s.hauer@pengutronix.de>
References: <1322747932-24943-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1323329606.1641.25.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-12-01 at 14:58 +0100, Sascha Hauer wrote:
> Hi,
> 
> The following series fixes the display connections to the IPU on
> i.MX3 boards. The connection to the display is completely independend
> of the internal pixel format in the framebuffer. The driver instead
> changes the IPU <-> Display mapping dependent on the pixelformat
> which is wrong.
> The following patch makes 16bpp and 32bpp modes possible on both
> RGB666 and RGB888 connected displays.
> The burstsize setting for 32bpp was configured wrong, so 32bpp
> modes have obviously never been tested.
> 
> Not for stable since all in kernel boards seem to work.
Applied thanks.

Couldn't help but notice that :
@@ -312,7 +312,7 @@ static void ipu_ch_param_set_size(union
chan_param_mem *params,
        case IPU_PIX_FMT_RGB565:
                params->ip.bpp  = 2;
                params->ip.pfs  = 4;

is not really good way. Someone else who is using this driver has no way
of knowing what these magic numbers mean and how to use them
Perhaps you can add meaning to these numbers and some note on why they
should be set to these values.


-- 
~Vinod

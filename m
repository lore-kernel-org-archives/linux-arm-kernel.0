From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 8 Dec 2011 10:39:27 +0100
Subject: [PATCH] video IPUv1 fixes for different display connections
In-Reply-To: <1323329606.1641.25.camel@vkoul-udesk3>
References: <1322747932-24943-1-git-send-email-s.hauer@pengutronix.de>
 <1323329606.1641.25.camel@vkoul-udesk3>
Message-ID: <20111208093927.GU27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 01:03:26PM +0530, Vinod Koul wrote:
> On Thu, 2011-12-01 at 14:58 +0100, Sascha Hauer wrote:
> > Hi,
> > 
> > The following series fixes the display connections to the IPU on
> > i.MX3 boards. The connection to the display is completely independend
> > of the internal pixel format in the framebuffer. The driver instead
> > changes the IPU <-> Display mapping dependent on the pixelformat
> > which is wrong.
> > The following patch makes 16bpp and 32bpp modes possible on both
> > RGB666 and RGB888 connected displays.
> > The burstsize setting for 32bpp was configured wrong, so 32bpp
> > modes have obviously never been tested.
> > 
> > Not for stable since all in kernel boards seem to work.
> Applied thanks.
> 
> Couldn't help but notice that :
> @@ -312,7 +312,7 @@ static void ipu_ch_param_set_size(union
> chan_param_mem *params,
>         case IPU_PIX_FMT_RGB565:
>                 params->ip.bpp  = 2;
>                 params->ip.pfs  = 4;
> 
> is not really good way. Someone else who is using this driver has no way
> of knowing what these magic numbers mean and how to use them
> Perhaps you can add meaning to these numbers and some note on why they
> should be set to these values.

Yes, you are right. Adding defines for these really makes this better
readable. BTW did you queue both patches or only the first one?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

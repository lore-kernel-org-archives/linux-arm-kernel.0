From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 22 Apr 2010 16:33:43 +0200
Subject: [PATCH] serial/imx: only parse for iomem resources once
In-Reply-To: <1271838838.643120.804272014834.1.gpush@pororo>
References: <1271838838.643120.804272014834.1.gpush@pororo>
Message-ID: <20100422143343.GB32348@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 04:33:58PM +0800, Jeremy Kerr wrote:
> Currently, the iomem resources are parsed in serial_imx_probe, then
> again in imx_request_port and imx_release_port.
> 
> This change uses the imx_port data to retrieve the start and size of the
> memory region, rather than re-parsing the resources through
> platform_get_resource.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
What are the effects for this regarding run time?  How often are
request_port and release_port called?  I wonder if it's worth to save
the value.  Or what else than run time is your concern?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

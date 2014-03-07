From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Mar 2014 17:06:09 +0000
Subject: [PATCH 2/2] imx-drm: imx-ldb: Use OF graph to find connected panel
In-Reply-To: <1394114080-27223-2-git-send-email-p.zabel@pengutronix.de>
References: <1394114080-27223-1-git-send-email-p.zabel@pengutronix.de>
 <1394114080-27223-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140307170609.GP21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 02:54:40PM +0100, Philipp Zabel wrote:
> @@ -566,9 +566,18 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
>  			return -EINVAL;
>  		}
>  
> -		panel_node = of_parse_phandle(child, "fsl,panel", 0);
> -		if (panel_node)
> -			channel->panel = of_drm_find_panel(panel_node);
> +		/* The output port is port at 4 with mux or port at 1 without mux */
> +		port = of_graph_get_port_by_id(child, imx_ldb->lvds_mux ? 4 : 1);

I guess we're holding off on these two patches while the last bits of
the of-graph get sorted - the above function doesn't currently exist
so causes a build failure.

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

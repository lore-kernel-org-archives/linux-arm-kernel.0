From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 11 Feb 2014 11:38:31 +0300
Subject: [RFC PATCH 2/3] staging: imx-drm-core: Use graph to find
 connection between crtc and encoder
In-Reply-To: <20140210162631.GC26684@n2100.arm.linux.org.uk>
References: <1389019922-31992-1-git-send-email-p.zabel@pengutronix.de>
 <1389019922-31992-3-git-send-email-p.zabel@pengutronix.de>
 <20140210162631.GC26684@n2100.arm.linux.org.uk>
Message-ID: <20140211083831.GV26722@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Why is this loop soo complicated?  Why do you need to mess around with
> this "last_ep" stuff - you don't actually end up using it.
> 
> The loop reduces down to this without comments:
> 
>  	for (i = 0; !ret; i++) {
                    ^^^^
Philipp, "ret" isn't set anymore in the new loop.

>  		uint32_t mask;
> 
> 		ep = v4l2_of_get_next_endpoint(np, last_ep);
> 		if (!ep)
> 			break;
> 
> 		/* CSI */
> 		mask = imx_drm_find_crtc_mask(imxdrm, ep);
> 		of_node_put(ep);
> 
> 		if (mask == 0)
> 			return -EPROBE_DEFER;
> 
> 		crtc_mask |= mask;
> 	}

regards,
dan carpenter

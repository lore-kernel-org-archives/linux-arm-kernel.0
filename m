From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Aug 2013 20:19:04 +0100
Subject: [FAILURE] drivers/video/omap2/displays-new/connector-analog-tv.c
Message-ID: <20130801191903.GC23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Last couple of 4430SDP randconfig build attempts had this error in
common:

drivers/video/omap2/displays-new/connector-analog-tv.c: In function 'tvc_probe':
drivers/video/omap2/displays-new/connector-analog-tv.c:215:19: error: 'omap_dss_pal_timings' undeclared (first use in this function)

#ifdef CONFIG_OMAP2_DSS_VENC
/* Hardcoded timings for tv modes. Venc only uses these to
 * identify the mode, and does not actually use the configs
 * itself. However, the configs should be something that
 * a normal monitor can also show */
extern const struct omap_video_timings omap_dss_pal_timings;
extern const struct omap_video_timings omap_dss_ntsc_timings;
#endif

# CONFIG_OMAP2_DSS_VENC is not set

Maybe some required dependencies are missing?

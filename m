From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 24 Feb 2011 11:27:23 +0200
Subject: [PATCH v10 05/18] OMAP2,3 DSS2 Change driver name to omap_display
In-Reply-To: <1295850125-21405-6-git-send-email-sumit.semwal@ti.com>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
	<1295850125-21405-6-git-send-email-sumit.semwal@ti.com>
Message-ID: <1298539643.16119.54.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2011-01-24 at 11:51 +0530, ext Sumit Semwal wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> Change the driver name from omapdss to omap_display as the driver takes care of
> the display devices ie number of panels, type of panels available in the
> platform.  Change the device name in the board files and 2420,2430,3xxx clock
> files from omapdss to omap_display to match the driver name.

I just realized that changing the driver name will break all scripts and
applications using omapdss sysfs files.

How does this sound:

Let's leave the omapdss device name as it is. It represents a "super"
device, containing the dss sysfs files and upper level dss management.

Name the HW module platform drivers as: omapdss_dss, omapdss_venc,
omapdss_dispc, etc. This would indicate them to be clearly parts of DSS,
and would also prevent any possible name conflict if there would happen
to be a, say, "dsi" block in some other HW component.

 Tomi

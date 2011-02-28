From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 28 Feb 2011 09:19:09 +0200
Subject: [PATCH v10 05/18] OMAP2,3 DSS2 Change driver name to omap_display
In-Reply-To: <4D6B4A1A.9000304@ti.com>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
	<1295850125-21405-6-git-send-email-sumit.semwal@ti.com>
	<1298539643.16119.54.camel@deskari> <1298876015.2096.36.camel@deskari>
	<4D6B4A1A.9000304@ti.com>
Message-ID: <1298877549.2096.47.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-02-28 at 01:09 -0600, Taneja, Archit wrote:
> Hi,
> 
> On Monday 28 February 2011 12:23 PM, Valkeinen, Tomi wrote:
> > On Thu, 2011-02-24 at 03:27 -0600, Tomi Valkeinen wrote:
> >> Hi,
> >>
> >> On Mon, 2011-01-24 at 11:51 +0530, ext Sumit Semwal wrote:
> >>> From: Senthilvadivu Guruswamy<svadivu@ti.com>
> >>>
> >>> Change the driver name from omapdss to omap_display as the driver takes care of
> >>> the display devices ie number of panels, type of panels available in the
> >>> platform.  Change the device name in the board files and 2420,2430,3xxx clock
> >>> files from omapdss to omap_display to match the driver name.
> >>
> >> I just realized that changing the driver name will break all scripts and
> >> applications using omapdss sysfs files.
> >>
> >> How does this sound:
> >>
> >> Let's leave the omapdss device name as it is. It represents a "super"
> >> device, containing the dss sysfs files and upper level dss management.
> >>
> >> Name the HW module platform drivers as: omapdss_dss, omapdss_venc,
> >> omapdss_dispc, etc. This would indicate them to be clearly parts of DSS,
> >> and would also prevent any possible name conflict if there would happen
> >> to be a, say, "dsi" block in some other HW component.
> >
> > Any comments on this?
> 
> I also think we need to stick to the older name, "omapdss_dss" sounds a 
> bit confusing, and I think one of the previous versions had something 
> like "dss_dss" in it and it wasn't approved. Does something like 
> "omapdss_core" or "omapdss_dss_core" make sense, or is it more misleading?

It is confusing, but so is the hardware naming =). There is a DSS module
inside the omap display subsystem. That's why I would like to name it
"dss", not "core", so it's clear it refers to this DSS module.

"dss_dss" looks a bit silly, but I think "omapdss_dss" is slightly
better in the sense that it doesn't repeat the same "dss", and there is
an "omapdss" device, which acts like "manager" for these module devices.
But yes, I wouldn't call it perfect either.

"omapdss_dss_core" is one option. But then again, TRM doesn't speak of
"core". 

Also, these HW module devices are not used by the userspace, nor any
other component inside the kernel than dss. They are quite hidden, and
so the naming is not that critical. We can easily change these names
later, if needed.

 Tomi

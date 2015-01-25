From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 25 Jan 2015 22:49:48 +0100
Subject: [PATCH 0/4] Drop legacy support for omap3517
In-Reply-To: <20150125212015.GA14307@amd>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <20150113204219.GJ2419@atomide.com>
 <20150115142536.GC512@earth.universe> <201501241300.00723@pali>
 <20150125212015.GA14307@amd>
Message-ID: <20150125214947.GB20695@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 25, 2015 at 10:22:58PM +0100, Pavel Machek wrote:
> > Another regression for DT setup (which does not occur for board code):
> > 
> > omap_hsmmc driver does not export slot_name sysfs entry because
> > it not supported by DT yet. Entry slot_name is used by userspace
> > application to determinate if mmc block device is internal eMMC
> > memory or external uSD card. So support for this property also in
> > DT is needed.
> > 
> > Here is simple patch which fix this problem:
> 
> Thanks!
> 
> Does it need line into Documentation/devicetree/ somewhere?

Documentation/devicetree/bindings/mmc/mmc.txt (generic)
Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt (omap specific)

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150125/2ee8f6e0/attachment-0001.sig>

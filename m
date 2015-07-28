From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 28 Jul 2015 13:20:32 +0200
Subject: [PATCH V3 10/19] drm/tegra: dc: Prepare for generic PM domains
In-Reply-To: <55B73D8C.103@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-11-git-send-email-jonathanh@nvidia.com>
 <20150717104154.GM3057@ulmo> <55B73D8C.103@nvidia.com>
Message-ID: <20150728112030.GA10949@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 09:30:04AM +0100, Jon Hunter wrote:
> 
> On 17/07/15 11:41, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> > 
> > On Mon, Jul 13, 2015 at 01:39:48PM +0100, Jon Hunter wrote:
> >> Add support to the tegra dc driver for generic PM domains. However,
> >> to ensure backward compatibility with older device tree blobs ensure
> >> that the driver can work with or without generic PM domains. In order
> >> to migrate to generic PM domain infrastructure the necessary changes
> >> are:
> >>
> >> 1. If the "power-domains" property is present in the DT device node then
> >>    generic PM domains is supported and pm_runtime_enable() should be
> >>    called for the device. Furthermore, the enabling and disabling of the
> >>    power-domain is handled via calling pm_runtime_get/put, respectively.
> > 
> > The device could be PM runtime enabled even if no power-domains property
> > is set. Couldn't we check something more direct, like for example if the
> > dev->pm_domain is non-NULL?
> 
> Yes could do that instead.
> 
> > Perhaps it'd be worth converting the driver to use runtime PM first, and
> > move all the powergate and clock handling into suspend/resume functions,
> > and then we can conditionalize whether or not we call the legacy API iff
> > dev->pm_domain == NULL?
> 
> May be that would be a cleaner transition than trying to do it all in
> one go.

I have a couple of patches in my tree to do this for DRM as part of an
effort to restore DPMS. It's fairly tricky to get right in DRM and
requires all sorts of changes to the driver.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150728/f7735d82/attachment.sig>

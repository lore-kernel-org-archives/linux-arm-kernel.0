From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 30 Jul 2013 08:11:19 +0300
Subject: [PATCH v2 05/22] ARM: dt: tegra30: iommu: Add
 "nvidia,memory-client"
In-Reply-To: <51F6AA98.4020701@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-6-git-send-email-hdoyu@nvidia.com>
 <51E5D3D9.2090608@wwwdotorg.org>
 <20130729.140646.649065361266278007.hdoyu@nvidia.com>
 <51F6AA98.4020701@wwwdotorg.org>
Message-ID: <20130730081119.71de9d10e08307cdaca62fe3@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Jul 2013 19:47:04 +0200
Stephen Warren <swarren@wwwdotorg.org> wrote:

> On 07/29/2013 05:06 AM, Hiroshi Doyu wrote:
> > Stephen Warren <swarren@wwwdotorg.org> wrote @ Wed, 17 Jul 2013 01:14:33 +0200:
> > 
> >> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> >>> Add "nvidia,memory-client" to identify which swgroup ID a device
> >>> belongs to.
> >>
> >> This property also isn't in the documentation.
> >>
> >> Again, if client devices are required to have this new property, the DT
> >> isn't backwards-compatible; fail:-(
> > 
> > If there's no this property, just falling back to use the system
> > default address space. I think that this won't break the
> > compatibility basically. Only problem may be the inconsistency of
> > setting this property among the HWs in the same group.
> 
> When you say "group" there, what kind of group? I thought that each HW
> module had its own "SWGROUP ID", and hence there are no "HWs in the same
> group"?

A "swgroup" can have multiple HWs. So there are 3 concept here.

swgroup: one client to issue request from MC perspective
HW: swgroup can have multiple HWs(real H/W units)
device driver: Can have multiple swgroups.

From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 29 Jul 2013 13:06:46 +0200
Subject: [PATCH v2 05/22] ARM: dt: tegra30: iommu: Add
 "nvidia,memory-client"
In-Reply-To: <51E5D3D9.2090608@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com><1373021097-32420-6-git-send-email-hdoyu@nvidia.com><51E5D3D9.2090608@wwwdotorg.org>
Message-ID: <20130729.140646.649065361266278007.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> wrote @ Wed, 17 Jul 2013 01:14:33 +0200:

> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> > Add "nvidia,memory-client" to identify which swgroup ID a device
> > belongs to.
> 
> This property also isn't in the documentation.
> 
> Again, if client devices are required to have this new property, the DT
> isn't backwards-compatible; fail:-(

If there's no this property, just falling back to use the system
default address space. I think that this won't break the
compatibility basically. Only problem may be the inconsistency of
setting this property among the HWs in the same group. If one of them
is set in one AS, but not for the other, then the other H/W won't
work. If we really want to have this kind of constraint implmeneted in
DT, some kind of bus model is needed.

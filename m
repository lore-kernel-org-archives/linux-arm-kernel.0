From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Jun 2013 12:38:17 +0200
Subject: [PATCH 01/23] ARM: tegra: Create a DT header defining swgroups ID
In-Reply-To: <20130626.133141.857713230994773030.hdoyu@nvidia.com>
References: <1372238906-9346-2-git-send-email-hdoyu@nvidia.com>
 <20130626100648.GC27083@manwe>
 <20130626.133141.857713230994773030.hdoyu@nvidia.com>
Message-ID: <20130626103816.GI27083@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:31:41PM +0200, Hiroshi Doyu wrote:
> Hi Thierry,
> 
> Thierry Reding <thierry.reding@gmail.com> wrote @ Wed, 26 Jun 2013 12:06:49 +0200:
> ...
> > I'm not entirely sure where to find these mappings in the TRM. I see
> > that there's a list of the groups in 15.10.11, but where do the numbers
> > come from?
> 
> To convert swgroup ID bit to register address,
> 
> #define HWGRP_ASID_REG(x) ((x) * sizeof(u32) + SMMU_AFI_ASID)
> 
> in "[PATCH 15/23] iommu/tegra: smmu: Calculate ASID register offset by ID"

Oh, I see. Thanks for pointing that out.

> > And why are some of the names aliased? If it's for
> > readability only maybe we could add some more for SWGID_HC ->
> > SWGID_HOST1X and perhaps SWGID_NV -> SWGID_GR3D.
> 
> I used the exact same name from TRM register definition. I thought
> that same naming in TRM may be better since this bit is converted to
> register, but I'm quite open to rename if needed.

I think it's fine to keep the names from the TRM. I was just wondering
why some groups can be referenced using multiple names, like ISP2 -> ISP
and MSENC -> MPE.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/a0a76dad/attachment-0001.sig>

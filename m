From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Apr 2012 16:25:37 +0300
Subject: [PATCH v2 2/3] ARM: tegra: Add SMMU enabler in AHB
In-Reply-To: <20120424.160319.1903472399760352200.hdoyu@nvidia.com>
References: <20120424123248.GG8444@arwen.pp.htv.fi>
 <20120424.153930.1438573079107186567.hdoyu@nvidia.com>
 <20120424124115.GL8444@arwen.pp.htv.fi>
 <20120424.160319.1903472399760352200.hdoyu@nvidia.com>
Message-ID: <20120424132536.GO8444@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 03:03:19PM +0200, Hiroshi Doyu wrote:
> > > Only Tegra3 has SMMU.
> > 
> > but all of them ? In that case, you could call this from probe itself,
> > right ? But an ifdef won't work in all cases, so you need to do runtime
> > detection based on some revision register or cpu detection...
> 
> So far we don't have so many variants, and presently TEGRA_3x_SOC
> always has a SMMU. If there were some variants of TEGRA_3x_SOC, where
> some might not have SMMU, then runtime detection would make sense
> there. Now it's something like TEGRA_3x_SOC == SMMU.

the problem is when you have single kernel for TEGRA 2 and TEGRA 3. If
you rely on ifdef, one of them won't work properly, right ? ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120424/c8b50bf8/attachment.sig>

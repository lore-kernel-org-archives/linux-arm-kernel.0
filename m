From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 30 Oct 2014 15:56:56 +0100
Subject: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
 support
In-Reply-To: <5452418F.8080005@nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
 <54520CFE.9060907@nvidia.com> <5452107D.8080207@nvidia.com>
 <54521181.8080005@nvidia.com> <54521B22.6070708@nvidia.com>
 <54523E8B.7000900@nvidia.com> <5452418F.8080005@nvidia.com>
Message-ID: <20141030145654.GD20072@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 03:47:59PM +0200, Terje Bergstr?m wrote:
> On 30.10.2014 15:35, Alexandre Courbot wrote:
> > Great, thanks for confirming!
> > 
> > Thierry, how do you want to address this? We could change the register
> > for the GPU group, or (maybe preferable if we want to reflect the actual
> > hardware state) add the GPUB group. I don't know if that would be easy
> > though since we would have the problem of the gpusrd and gpuswr clients
> > ownership (seems like they would belong to both groups?)
> 
> gpusrd and gpuswr are client IDs for GPU reads and writes on MC. GPU and
> GPUB are SW group IDs for SMMU. There's no 1:1 or hierarchical mapping.

Since the GPU client ID is effectively useless for purposes of IOMMU
translation I'd lean towards just keeping the existing TEGRA_SWGROUP_GPU
and update the register to point to MC_SMMU_GPUB_ASID_0.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141030/3318166e/attachment.sig>

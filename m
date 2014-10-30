From: tbergstrom@nvidia.com (=?windows-1252?Q?Terje_Bergstr=F6m?=)
Date: Thu, 30 Oct 2014 15:47:59 +0200
Subject: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
 support
In-Reply-To: <54523E8B.7000900@nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
 <54520CFE.9060907@nvidia.com> <5452107D.8080207@nvidia.com>
 <54521181.8080005@nvidia.com> <54521B22.6070708@nvidia.com>
 <54523E8B.7000900@nvidia.com>
Message-ID: <5452418F.8080005@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.10.2014 15:35, Alexandre Courbot wrote:
> Great, thanks for confirming!
> 
> Thierry, how do you want to address this? We could change the register
> for the GPU group, or (maybe preferable if we want to reflect the actual
> hardware state) add the GPUB group. I don't know if that would be easy
> though since we would have the problem of the gpusrd and gpuswr clients
> ownership (seems like they would belong to both groups?)

gpusrd and gpuswr are client IDs for GPU reads and writes on MC. GPU and
GPUB are SW group IDs for SMMU. There's no 1:1 or hierarchical mapping.

Terje

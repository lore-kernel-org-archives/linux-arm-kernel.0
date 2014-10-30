From: tbergstrom@nvidia.com (=?windows-1252?Q?Terje_Bergstr=F6m?=)
Date: Thu, 30 Oct 2014 12:18:37 +0200
Subject: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
 support
In-Reply-To: <54520CFE.9060907@nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
 <54520CFE.9060907@nvidia.com>
Message-ID: <5452107D.8080207@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.10.2014 12:03, Alexandre Courbot wrote:
> I had to change the .reg of TEGRA_SWGROUP_GPU to 0xaac to get the IOMMU
> to work with GK20A. The reason is still not completely clear to me, but
> if you look at the TRM you see that 0xaa8 is basically constant, with
> the SMMU translation bit hardcoded to DISABLE (and the ASID field being
> meaningless in that case). However right after that register you have a
> functional one named GPUB instead of GPU, and this one is fully
> writeable (and has the expected effect).

GPU has two SW group IDs, because it accesses memory both with and
without translation. The bit 34 in addresses in f.ex. PTE chooses
between the two.

GPU is hard-wired to disable translation. For GPUB translation can be
enabled.

Terje

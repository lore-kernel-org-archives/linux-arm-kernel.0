From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Jul 2012 10:29:48 -0600
Subject: [PATCH v2 0/6] Port Tegra to generic clk framework
In-Reply-To: <1341313761-22118-1-git-send-email-pgaikwad@nvidia.com>
References: <1341313761-22118-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <4FF31DFC.8030708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2012 05:09 AM, Prashant Gaikwad wrote:
> This patch set ports Tegra clock code to generic clock framework.
> 
> Depends on
> [PATCH v3 0/9] Add clk_prepare/clk_unprepare series
> [PATCH] ARM: tegra: Remove second instance of uart clk
> [PATCH] dma: tegra: add clk_prepare/clk_unprepare
> [PATCH] ARM: tegra: dma: rename driver name for clock to "tegra-apbdma"
> 
> Tested on Ventana and Cardhu
> 
> v2:
>  - Rebased on Tegra's for-3.6/common-clk

OK, this applies to for-3.6/common-clk without issue now. However, there
are still runtime problems:

On Tegra20(Ventana), running Tegra's for-next branch with these patches
merged in, if I play audio, the sound is much too low a pitch; the I2S
clock must be being set too low. Also, if I play the same file twice,
once encoded as 48KHz once encoded as 44.1KHz, the pitch is different.

On Tegra20(Ventana), running next-20120703 plus a few local patches for
regulators plus these common clock patches, then I see the same
segfaults during boot that I mentioned before. It seems something in
linux-next not in Tegra's for-next branch is breaking the common clock
code for us.

Neither problem is seen on Cardhu with the same kernels.

Can you please investigate and fix these issues? Thanks.

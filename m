From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 11 Oct 2013 15:38:09 +0800
Subject: [PATCH 4/7] ARM: tegra: add LP1 support code for Tegra124
In-Reply-To: <5255E4CD.1050509@wwwdotorg.org>
References: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
 <1381310411-11391-5-git-send-email-josephl@nvidia.com>
 <5255E4CD.1050509@wwwdotorg.org>
Message-ID: <1381477089.5685.3.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-10-10 at 07:20 +0800, Stephen Warren wrote:
> On 10/09/2013 03:20 AM, Joseph Lo wrote:
> > The LP1 suspend procedure is the same with Tegra30 and Tegra114. Just
> > need to update the difference of the register address, then we can
> > continue to share the code.
> > -	.rept (tegra30_sdram_pad_size - tegra114_sdram_pad_address) / 4
> > +	.rept (tegra124_sdram_pad_address - tegra114_sdram_pad_address) / 4
> 
> I assume this is intended to reserve enough space to store all the saved
> registers for the largest table of tegra30_sdram_pad_address,
> tegra114_sdram_pad_address, tegra124_sdram_pad_address. I count more
> entries in the existing Tegra114 table than the new Tegra124 table, so
> I'm not sure this part of the change is correct.
> 
> Is there no way to do a max(tegra30 size, tegra114 size, tegra124 size)
> so you don't have to pick manually which size to reserve here?

I don't have a good way to achieve this, because we may have another new
SoC that may continue re-use these codes. Hence I need to keep
maintaining the max() function.

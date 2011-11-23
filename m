From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Nov 2011 09:54:21 -0800
Subject: [PATCH 09/17] ASoC: Tegra I2S: Remove dependency on pdev->id
In-Reply-To: <20111123110338.GC21073@opensource.wolfsonmicro.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-10-git-send-email-swarren@nvidia.com>
 <20111123110338.GC21073@opensource.wolfsonmicro.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174F08C711@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote at Wednesday, November 23, 2011 4:04 AM:
> On Tue, Nov 22, 2011 at 06:21:17PM -0700, Stephen Warren wrote:
> 
> > +	i2s->dai = tegra_i2s_dai_template;
> > +	i2s->dai.name = pdev->name;
> > +
> 
> This should really be part of the same commit as the arch/arm side
> change in order to avoid bisection breaks as from the point of view of
> non-DT systems it's moving the number into the name.

Sorry, I don't quite follow here; the original hard-coded dai structures
already had the ID in the name, and hence exactly match the platform
device names tegra-i2s.0 and tegra-i2s.1:

static struct snd_soc_dai_driver tegra_i2s_dai[] = {
	{
		.name = DRV_NAME ".0",
...
	},
	{
		.name = DRV_NAME ".1",

Or were you referring the AUXDATA fix for tegra-i2s.1? That's not an
issue since nothing uses the 2nd I2C controller on Tegra in mainline
yet.

-- 
nvpublic

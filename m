From: kbeldan@baylibre.com (Karl Beldan)
Date: Wed, 17 Aug 2016 13:01:06 +0000
Subject: [PATCH 2/2] ARM: davinci_all_defconfig: enable modules for sound
 on LCDK
In-Reply-To: <388d5e63-ff82-ca88-c60a-24ad87700afd@ti.com>
References: <20160810200853.24275-1-kbeldan@baylibre.com>
 <20160810200853.24275-2-kbeldan@baylibre.com>
 <52f428a2-7818-5f3a-bb66-70e2eaa63e7a@ti.com>
 <20160817101331.GA8009@gobelin>
 <388d5e63-ff82-ca88-c60a-24ad87700afd@ti.com>
Message-ID: <20160817130106.GA21333@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 04:08:03PM +0530, Sekhar Nori wrote:
> On Wednesday 17 August 2016 03:43 PM, Karl Beldan wrote:
> > On Wed, Aug 17, 2016 at 02:20:51PM +0530, Sekhar Nori wrote:
> >> On Thursday 11 August 2016 01:38 AM, Karl Beldan wrote:
> >>> This is the minimal set of additional modules required to support audio
> >>> on the LCDK.
> >>>
> >>> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> >>
> >> This patch does not apply because Kevin already added some missing audio
> >> modules through commit "ARM: davinci_all_defconfig: enable DA850 audio
> >> as modules"
> >>
> >> Can you please rebase on master branch of my tree[1] and resend?
> >>
> > 
> > I checked out your tree.
> > With Kevin's patch the needed modules get selected without needing 2/2.
> > 
> > However I don't know why he used:
> >  CONFIG_SND_DA850_SOC_EVM=m
> > instead of: 
> >  CONFIG_SND_DAVINCI_SOC_MCASP=m
> >  CONFIG_SND_SOC_TLV320AIC3X=m
> > The former seems to me to be pre-DT style config. I used the latter in
> > 2/2 and thought that's what we'd start switching to ? Unless it is for
> > pre-DT compatibility ?
> 
> I don't think this is related to DT. As you said,
> CONFIG_SND_DA850_SOC_EVM selects CONFIG_SND_DAVINCI_SOC_MCASP and
> CONFIG_SND_SOC_TLV320AIC3X anyway.
> 
> To be honest, I am okay either way. Copying Peter to see if he has any
> preference.
> 

Ok, I dropped 2/2 in v2 which will rely on Kevin's change.

Rgds, 
Karl

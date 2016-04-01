From: pc.liao@mediatek.com (PC Liao)
Date: Fri, 1 Apr 2016 10:50:52 +0800
Subject: [PATCH] ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
 driver
In-Reply-To: <20160329160703.GN2350@sirena.org.uk>
References: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
 <20160328191115.GE2350@sirena.org.uk> <1459258103.3747.7.camel@mtksdaap41>
 <20160329160703.GN2350@sirena.org.uk>
Message-ID: <1459479052.24414.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, 2016-03-30 at 00:07 +0800, Mark Brown wrote:
> On Tue, Mar 29, 2016 at 09:28:23PM +0800, PC Liao wrote:
> 
> > - mediatek,rt5650_i2s: I2S mode of rt5650
> > 0: Default setting. Playback and record path use same set of I2S.
> > Playback/Record path using same I2S clock connect from MT8173 I2S1 to
> > rt5650 I2S1.
> > 1: Playback and record path use different set of I2S. Playback path
> > connects from MT8173 I2S1 to rt5650 I2S1 and record path connects from
> > MT8173 I2S2 to rt5650 I2S2.
> 
> > Because we use codec ASRC function and need to initialize on different
> > setting about this parts:
> 
> This sort of arrangement is very common - it's often needed to get
> different sample rates for playback and capture.  Normally it'd be
> represented in the DT by having the two DAI links specified normally and
> then having the driver look at the DT to see what's connected to work
> out what mode to use.

Could you please suggest the reference driver about this?
Thanks!

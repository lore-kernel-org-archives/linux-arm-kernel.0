From: pc.liao@mediatek.com (PC Liao)
Date: Wed, 6 Apr 2016 21:58:25 +0800
Subject: [PATCH] ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
 driver
In-Reply-To: <20160402170404.GG2350@sirena.org.uk>
References: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
 <20160328191115.GE2350@sirena.org.uk> <1459258103.3747.7.camel@mtksdaap41>
 <20160329160703.GN2350@sirena.org.uk> <1459479052.24414.3.camel@mtksdaap41>
 <20160402170404.GG2350@sirena.org.uk>
Message-ID: <1459951105.28748.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Sun, 2016-04-03 at 01:04 +0800, Mark Brown wrote:
> On Fri, Apr 01, 2016 at 10:50:52AM +0800, PC Liao wrote:
> > On Wed, 2016-03-30 at 00:07 +0800, Mark Brown wrote:
> 
> > > This sort of arrangement is very common - it's often needed to get
> > > different sample rates for playback and capture.  Normally it'd be
> > > represented in the DT by having the two DAI links specified normally and
> > > then having the driver look at the DT to see what's connected to work
> > > out what mode to use.
> 
> > Could you please suggest the reference driver about this?
> 
> Any driver that can identify an individual DAI within a device by using
> sound-dai references, even simple-card does this.

Thanks for suggestion.
This machine driver is based on DPCM.
Should I add BE DAI and use DAPM, then using ucm-config(mixer control)
to control the path?
Or, do I think the wrong direction?
Thanks!

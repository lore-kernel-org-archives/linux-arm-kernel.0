From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Mar 2016 09:07:03 -0700
Subject: [PATCH] ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
 driver
In-Reply-To: <1459258103.3747.7.camel@mtksdaap41>
References: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
 <20160328191115.GE2350@sirena.org.uk>
 <1459258103.3747.7.camel@mtksdaap41>
Message-ID: <20160329160703.GN2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 09:28:23PM +0800, PC Liao wrote:

> - mediatek,rt5650_i2s: I2S mode of rt5650
> 0: Default setting. Playback and record path use same set of I2S.
> Playback/Record path using same I2S clock connect from MT8173 I2S1 to
> rt5650 I2S1.
> 1: Playback and record path use different set of I2S. Playback path
> connects from MT8173 I2S1 to rt5650 I2S1 and record path connects from
> MT8173 I2S2 to rt5650 I2S2.

> Because we use codec ASRC function and need to initialize on different
> setting about this parts:

This sort of arrangement is very common - it's often needed to get
different sample rates for playback and capture.  Normally it'd be
represented in the DT by having the two DAI links specified normally and
then having the driver look at the DT to see what's connected to work
out what mode to use.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160329/003a4c4b/attachment.sig>

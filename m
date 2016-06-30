From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Thu, 30 Jun 2016 20:55:45 +0800
Subject: [alsa-devel] [PATCH v5 7/9] ASoC: bt-sco: extend rate and add a
 general compatible string
In-Reply-To: <20160629191500.GU6247@sirena.org.uk>
References: <1466149440-23889-1-git-send-email-garlic.tseng@mediatek.com>
 <1466149440-23889-8-git-send-email-garlic.tseng@mediatek.com>
 <20160629191500.GU6247@sirena.org.uk>
Message-ID: <1467291345.11091.16.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-06-29 at 20:15 +0100, Mark Brown wrote:
> On Fri, Jun 17, 2016 at 03:43:58PM +0800, Garlic Tseng wrote:
> > Add supports for 16k (wideband BT) and add a general compatible
> > string "linux,bt-sco"
> 
> This will claim that we support 16k on existing systems which we clearly
> don't.  It also seems unwise to advertise multiple rates when we've no
> way to configure the rates...  how does the BT controller figure out
> what the sample rate is?

The codec driver is a dummy driver for bt device and actually do
nothing. The user-space will control both bt part and alsa part (at
least in mt2701 platform). Yes the sound/soc/codecs/bt-sco.c was only
support 8k and was already there before the patch, but I think it might
be ok to extend it to 16k without any side effect.

If you worry about some potential risk (I don't see any) maybe we have
to develop another dummy bt-sco codec driver which support both 8k and
16k?

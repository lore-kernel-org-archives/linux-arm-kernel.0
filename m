From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Thu, 5 May 2016 10:45:42 +0800
Subject: [alsa-devel] [PATCH 1/7] ASoC: mediatek: Refine mt8173 driver
 and change config option
In-Reply-To: <20160504164306.GA6292@sirena.org.uk>
References: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
 <1461934848-60011-2-git-send-email-garlic.tseng@mediatek.com>
 <20160504164306.GA6292@sirena.org.uk>
Message-ID: <1462416342.25179.36.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-05-04 at 17:43 +0100, Mark Brown wrote:
> On Fri, Apr 29, 2016 at 09:00:42PM +0800, Garlic Tseng wrote:
> 
> >  .../{mtk-afe-pcm.c => mt8173/mt8173-afe-pcm.c}     | 488 ++++++++++-----------
> 
> So there's going to be no code sharing at all between this and any other
> Mediatek chips?  That seems very surprising, it'd suggest that the
> hardware designers were creating a new design completely from scratch
> each time which doesn't seem all that likely.  This is an unusual way of
> organizing things and we need a much clearer explanation of what's going
> on here.

MT8173 and MT2701 are from different product lines so the register
control sequences are very different. If another driver for 8173-like
(or 2701-like) chip go upstream it shall share some common code with the
relatively driver indeed. However I think MT8173 and MT2701 can't share
the platform driver or a lot of "if MT8173 else MT2701" will mess up the
code.


However, several (maybe 2 or 3) tiny functions for the two driver code
are very similar indeed. For example, pointer callback functions of
platform driver are very similar. It reads the cursor and return. But
I'm not sure if it is better to share the function. It is too trivial
for me.

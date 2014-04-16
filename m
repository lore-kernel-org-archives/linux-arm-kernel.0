From: zonque@gmail.com (Daniel Mack)
Date: Wed, 16 Apr 2014 19:39:27 +0200
Subject: [PATCH v4 00/21] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <1397668411-27162-1-git-send-email-ynvich@gmail.com>
References: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
 <1397668411-27162-1-git-send-email-ynvich@gmail.com>
Message-ID: <534EC04F.9010408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/16/2014 07:13 PM, Sergei Ianovich wrote:
> We had an intensive discussion of the series in the beginning of
> December 2013 [1]. The discussion resulted in 3 versions of the series
> in less than 3 weeks. Then there was a decision to block this series
> until Daniel Mack's DMA-engine-for-PXA series is ready.

For whatever reason, I only received patches 1-8 out of 21 in this series.

> Unfortunately Daniel neigther agrees to review my trivial temporary
> solution to the DMA-in-device-tree (patch 7 of 21), nor he is active
> in DMA series development. There is no progress for 3 months.

Well, IIRC, I asked you to look into the MMC performance regressions
that you reported and see what we can do about them. I currently don't
have hardware to reproduce this, so I can't do it myself.

My impression is that the transisiton will only be painless if the
mmp_pdma driver provides comparable performance to the existing
implementation. I also still think that adding hacks to the drivers to
manually parse the dma properties (as in #8) brings us further away from
a proper solution, not closer.

> As with any big out of tree series, its support is painful. It requires
> extensive merging when doing bisects, on each step.

I know that, and I'm not violently against getting your patches in. I
was just hoping for some help around here in order to sort out things
and implement it properly. The reason why I haven't been working on
these drivers lately is simply the sheer lack of time :(


Thanks,
Daniel

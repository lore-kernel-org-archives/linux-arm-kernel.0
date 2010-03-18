From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 18 Mar 2010 12:09:08 +0000
Subject: [PATCH 1/5] ASoC: split pxa ssp for reusing code
In-Reply-To: <771cded01003171929t5364eafblf2bd734e2fd1202@mail.gmail.com>
References: <771cded01003171929t5364eafblf2bd734e2fd1202@mail.gmail.com>
Message-ID: <20100318120907.GH3080@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 17, 2010 at 10:29:46PM -0400, Haojian Zhuang wrote:
> From ffd197865a1114b46cc7d6b0442e4c6ece962f8b Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 17 Mar 2010 10:45:30 -0400
> Subject: [PATCH] ASoC: split pxa ssp for reusing code
> 
> Since basic SSP features are shared between PXA2xx and PXA168, the difference
> is focused on clock generating. Now split ssp code into two parts. One is for
> general ssp feature. The other is for pxa2xx parts.

Could you please provide a more detailed description of what the
differences between the two SSP implementations.  This description is
rather vauge and doesn't appear to 100% tie in with the implemenation -
for example, the hw_params() implementations for the two variants seem
*very* close to each other.

It may be that some of this stuff can be handled by having a common
hw_params() which can be called by device specific code that handles the
differences.  Given how fiddly the configuration of the framing is
having two different implementations to keep in sync doesn't seem good.

From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 30 Jul 2012 16:02:53 +0100
Subject: [PATCH 13/18] ARM: ux500: Add ux500 PCM to DB8500 Device Tree
In-Reply-To: <501699B2.7030002@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-14-git-send-email-lee.jones@linaro.org>
 <20120729205001.GK4384@opensource.wolfsonmicro.com>
 <5016389B.4020003@linaro.org>
 <20120730134054.GC4468@opensource.wolfsonmicro.com>
 <501699B2.7030002@linaro.org>
Message-ID: <20120730150252.GG4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 03:26:58PM +0100, Lee Jones wrote:
> On 30/07/12 14:40, Mark Brown wrote:

> >>We use it register the driver for probe()ing. In the same way we do
> >>for the PMU and Regulators. All three of which actually belong to a
> >>different hardware block. Do you know of a better way to register
> >>those devices?

> >You've not identified which of the two cases above we're in...  assuming
> >it's a virtal device look at how the DT bindings for the other platforms
> >are doing things.

> I thought it would have been obvious by my response. The PMU seems
> to be a virtual device with no registers or IRQs.

That's not at all obvious, no.

> I've found a DT which seems to do it in the same way as I do
> 'arch/powerpc/boot/dts/p1022ds.dts', but some others call PCM
> registration from the CPU-side DAI probe(). Would that be your
> preference?

Yes, do what the other drivers are doing

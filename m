From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 30 Jul 2012 16:01:30 +0100
Subject: [PATCH 05/18] ASoC: Ux500: Enable ux500 MSP driver for Device Tree
In-Reply-To: <501692B8.6050102@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-6-git-send-email-lee.jones@linaro.org>
 <20120729204218.GI4384@opensource.wolfsonmicro.com>
 <50162F70.2050900@linaro.org>
 <20120730133930.GB4468@opensource.wolfsonmicro.com>
 <501692B8.6050102@linaro.org>
Message-ID: <20120730150129.GF4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 02:57:12PM +0100, Lee Jones wrote:
> On 30/07/12 14:39, Mark Brown wrote:

> >Why does the driver care - doesn't the pinctrl abstraction and/or
> >bindings handle this sensibly?

> Not when I tested it. pinctrl_get() came back !IS_ERR() for MSP0,
> MSP2 & MSP3, then when it went on to pinctrl_lookup_state(), only
> then did it fail. Would it be more sane to retract the error
> messages and just let it fail silently? It's either that or have
> lots of "could not get MSP defstate" clogging up the log.

This sounds to me like we should be ensuring that there's a single
fixed state available for these MSPs (representing the fact that the
pins are always in the right mode) in the pinctrl bindings.

As with several of other changes for this platform it seems like we need
to think carefully about the abstraction level we're working at.

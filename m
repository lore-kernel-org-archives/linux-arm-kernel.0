From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Aug 2012 14:20:23 +0100
Subject: [PATCH 1/6] ASoC: dapm: If one widget fails, do not force all
 subsequent widgets to fail too
In-Reply-To: <5018D880.5090306@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
 <20120731134214.GK4468@opensource.wolfsonmicro.com>
 <5017EAC3.3080504@linaro.org>
 <20120731142820.GW4468@opensource.wolfsonmicro.com>
 <5017EDCA.4020601@linaro.org>
 <20120731145443.GY4468@opensource.wolfsonmicro.com>
 <5017F68B.3060400@linaro.org>
 <20120731151819.GC4468@opensource.wolfsonmicro.com>
 <5018D880.5090306@linaro.org>
Message-ID: <20120801132022.GS11892@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 08:19:28AM +0100, Lee Jones wrote:
> On 31/07/12 16:18, Mark Brown wrote:

> >I'm not going to apply this patch.  This isn't a vendor BSP, we
> >shouldn't be putting random hacks like this in core code.

> BSP kernel or otherwise, it still seems wrong to me to fail and
> entire audio driver just because of a broken link.

No, really.  Random disconnections in the DAPM graph are just endless
pain from a support and debug point of view.  This isn't something that
randomly breaks on specific hardware where we'd expect random errors at
runtime, it's something that will never have worked - it seems clear
nobody tested the mainline submission.

It's very disappointing to see such an error exist, and even more
disappointing that there's no interest in fixing the driver.

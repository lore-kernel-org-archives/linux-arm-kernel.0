From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Aug 2012 10:59:00 +0100
Subject: [PATCH 1/6] ASoC: dapm: If one widget fails, do not force all
 subsequent widgets to fail too
In-Reply-To: <003901cd7073$d49cacc0$7dd60640$@se>
References: <20120731134214.GK4468@opensource.wolfsonmicro.com>
 <5017EAC3.3080504@linaro.org>
 <20120731142820.GW4468@opensource.wolfsonmicro.com>
 <5017EDCA.4020601@linaro.org>
 <20120731145443.GY4468@opensource.wolfsonmicro.com>
 <5017F68B.3060400@linaro.org>
 <20120731151819.GC4468@opensource.wolfsonmicro.com>
 <5018D880.5090306@linaro.org>
 <20120801132022.GS11892@opensource.wolfsonmicro.com>
 <003901cd7073$d49cacc0$7dd60640$@se>
Message-ID: <20120802095900.GC29157@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 07:58:24AM +0200, Ola Lilja wrote:

> Accusing me of having "no interest in fixing the driver" is just absurd
> regarding the time I've spent on this. I'm also still driving for

Sorry, this is more directed at the current round of fixes that are
being sent than the driver itself - the patches to bodge around the
issue are being pushed fairly aggressively as an urgent fix without
even mentioning what the issue is.  I don't have any concerns with
the driver, only with the way it's being fixed.

> Regarding the problem with the failing DAPM-widget I can probably guess
> What is going wrong when Lee is trying it out. There will be two failing
> clock-supply widgets due to the fact that on the mainline-code these
> clocks simply is not there yet. I have, of course, tested this driver
> before submitting it, and I wouldn't dream on submitting a driver where
> there were failing widgets/routes. Internally, I have put a patch with our
> clock-tree for Ux500 on, but this is not mainline-quality code and that is

This sort of reliance on out of tree patches which any real user of the
device would be expected to have sounds like exactly the sort of thing
I'd expect to have caused an issue like this, and obviously the fix here
is to get the clocks in place (even if just as stubs, though I'd expect
there to be a major impact on the functionality of the device if it's
not clocked...) rather than to just bodge out the error checking.

It does also suggest that the DT binding for this device will need to
include the setup of these clocks (I believe the clock bindings for DT
have just gone into mainline this merge window but I'd need to check).

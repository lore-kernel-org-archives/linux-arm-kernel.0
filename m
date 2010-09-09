From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 9 Sep 2010 10:38:10 +0100
Subject: [PATCH] MMC: move regulator handling closer to core v3
In-Reply-To: <4C887837.6060508@nokia.com>
References: <1283677538-31121-1-git-send-email-linus.walleij@stericsson.com>
	<20100908155114.880463fc.akpm@linux-foundation.org>
	<4C887837.6060508@nokia.com>
Message-ID: <20100909093810.GA1988@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 09, 2010 at 09:01:27AM +0300, Adrian Hunter wrote:

> As an aside, I would like to enhance the regulator framework to
> enable boards to hook their code directly into the regulator.

What do you mean when you say that you would like boards to "hook
directly into the regulator" - what do you want to be able to do?
Is this the notifiers?  Do you need more of them?

> Arguably this is essential to allow pbias configuration (without
> which the board may be damaged) so that regulator_enable/disable
> can be used independently of the board, or for example to allow

I can't parse this at all I'm afraid.  Could you be more specific about
what you mean by using enable and disable independantly of the board -
clearly the consumer drivers are already able to be board independant?

> the regulator core to turn the regulator on/off at initialisation.

The regulator core already supports enabling or disabling regulators
from the machine constraints which I *think* is what you're looking for
but since I can't follow what you're saying above I'm not sure.

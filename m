From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Mar 2011 21:21:10 +0000
Subject: [PATCH] leds: leds-regulator.c, fix handling already enabled
	regulators
In-Reply-To: <1300914002-17760-1-git-send-email-ospite@studenti.unina.it>
References: <1300914002-17760-1-git-send-email-ospite@studenti.unina.it>
Message-ID: <20110323212110.GA26862@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2011 at 10:00:02PM +0100, Antonio Ospite wrote:

> The leds-regulator driver was ignoring the initial status of the
> regulator; this resulted in rdev->use_count incremented up to 2 after
> calling regulator_led_set_value() in the .probe method when a regulator
> was already enabled at insmod time, and this made impossible to ever
> disable the regulator.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> NOTE: initially I thought about CC-ing stable at kernel.org as well on 
> this, as it is an actual fix, but then I checked that there are 
> currently no users of the driver in mainline linux and I dropped it, is 
> that how it should be?

Even if there's no users in mainline people could well be shipping out
of tree boards using it and could benefit from the code.  OTOH it's not
the most urgent thing ever.

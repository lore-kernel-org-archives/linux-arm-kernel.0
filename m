From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Dec 2009 20:41:22 +0000
Subject: [PATCH] leds: Add LED class driver for regulator driven LEDs.
In-Reply-To: <20091202213131.1393a956.ospite@studenti.unina.it>
References: <1259775625-25973-1-git-send-email-ospite@studenti.unina.it>
	<1259778235.3588.141.camel@odin>
	<20091202213131.1393a956.ospite@studenti.unina.it>
Message-ID: <20091202204121.GB18311@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2009 at 09:31:31PM +0100, Antonio Ospite wrote:
> Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> > Some regulators may not support voltage change (via hw design or
> > constraints) so set_voltage() will fail. We probably want to handle this
> > regulator type so we don't call set_voltage().

> Ok, I'll read more about the regulator framework to find out how to
> check regulator capabilities.

Checking for errors when counting and listing the voltages ought to
cover this.

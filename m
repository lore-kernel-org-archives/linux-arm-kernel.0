From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Oct 2013 21:46:17 +0100
Subject: [PATCH 2/2] misc: atmel_pwm: set initcall level to subsys
In-Reply-To: <20131030110705.GA29813@localhost>
References: <1382459560-26596-1-git-send-email-jhovold@gmail.com>
 <20131029232249.GA20476@kroah.com> <20131030110705.GA29813@localhost>
Message-ID: <201310302146.18248.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 October 2013, Johan Hovold wrote:
> > I really hate this type of patch, as it's papering over the real
> > problem.  What happens when someone else moves their driver to this
> > level?  Then you are back to the original problem.
> 
> Yes, it's crude, but it's currently the only way to express a preferred
> probe order.

Does the same problem occur with the generic PWM subsystem?

The atmel_pwm driver apparently is the last PWM driver that has
not been converted to the generic subsystem yet. Doing that would
also let us drop the atmel-pwm-bl driver in favor of the generic
backlight.

	Arnd

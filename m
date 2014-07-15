From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Jul 2014 11:39:38 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <CAAVeFu+Z2xzUy6pGWu3H4MXdkBq39-USHbwNU9ih6AvvxPyu5A@mail.gmail.com>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <16507628.c6raaN50oI@wuerfel> <20140714183624.GV6800@sirena.org.uk>
 <4657735.1VKsbQGuH6@wuerfel>
 <CAAVeFu+Z2xzUy6pGWu3H4MXdkBq39-USHbwNU9ih6AvvxPyu5A@mail.gmail.com>
Message-ID: <20140715103938.GJ6800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 04:36:20PM +0900, Alexandre Courbot wrote:

> Direction and initial value, on the other hand, are clearly properties
> that ought to be set by the driver itself. Thus my expectation here
> would be that the driver sets the GPIO direction and initial value as
> soon as it gets it using gpiod_direction_output(). In other words,

Well, it's a bit of a mix really - from a hardware point of view they
normally are actually often fixed.

> there is no replacement for gpio_request_one() with the gpiod
> interface. Is there any use-case that cannot be covered by calling
> gpiod_direction_output() right after gpiod_get()? AFAICT this is what
> gpio_request_one() was doing anyway.

Right, the original goal was to provide a better interface for
requesting a GPIO - it saves a lot of error handling code throughout the
kernel and avoids the possibility of bugs due to users forgetting to
mark the directio for the GPIO.  Having a direct replacement also makes
conversions to gpiod easier.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140715/ceaf2154/attachment.sig>

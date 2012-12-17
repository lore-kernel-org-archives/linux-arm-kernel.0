From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Mon, 17 Dec 2012 15:30:45 +0100
Subject: devicetree support for efikasb
In-Reply-To: <87bods92pc.fsf@dell.be.48ers.dk>
References: <20121217075907.GQ24458@pengutronix.de>
 <87licwdikj.fsf@lebrac.rtp-net.org>
 <87licw97nn.fsf@dell.be.48ers.dk>
 <871ueodb75.fsf@lebrac.rtp-net.org>
 <87bods92pc.fsf@dell.be.48ers.dk>
Message-ID: <20121217143045.GA3219@type.bordeaux.inria.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Korsgaard, le Mon 17 Dec 2012 15:24:15 +0100, a ?crit :
> Samuel, what happened to the ledtriggers-for-keyboard-leds stuff?

AIUI, it's still in the TODO list of Dmitry Torokhov (latest version
was sent on Date: Mon, 14 Nov 2011 05:06:13 +0100). There was a Kconfig
issue that might be what is blocking it:

?
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -8,6 +8,7 @@ config VT
>       bool "Virtual terminal" if EMBEDDED
>       depends on !S390
>       select INPUT
> +     select LEDS_INPUT

This will not work as LEDS_INPUT is itself depends and selects other
symbols and "select" statement does not propagate dependencies.
?

Samuel

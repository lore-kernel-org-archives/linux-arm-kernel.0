From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 17 Dec 2012 15:40:04 +0100
Subject: devicetree support for efikasb
In-Reply-To: <20121217143045.GA3219@type.bordeaux.inria.fr> (Samuel Thibault's
 message of "Mon, 17 Dec 2012 15:30:45 +0100")
References: <20121217075907.GQ24458@pengutronix.de>
 <87licwdikj.fsf@lebrac.rtp-net.org> <87licw97nn.fsf@dell.be.48ers.dk>
 <871ueodb75.fsf@lebrac.rtp-net.org> <87bods92pc.fsf@dell.be.48ers.dk>
 <20121217143045.GA3219@type.bordeaux.inria.fr>
Message-ID: <87624091yz.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Samuel" == Samuel Thibault <samuel.thibault@ens-lyon.org> writes:

Hi,

 Samuel> AIUI, it's still in the TODO list of Dmitry Torokhov (latest
 Samuel> version was sent on Date: Mon, 14 Nov 2011 05:06:13
 Samuel> +0100). There was a Kconfig issue that might be what is
 Samuel> blocking it:

 Samuel> ?
 >> --- a/drivers/char/Kconfig
 >> +++ b/drivers/char/Kconfig
 >> @@ -8,6 +8,7 @@ config VT
 >> bool "Virtual terminal" if EMBEDDED
 >> depends on !S390
 >> select INPUT
 >> +     select LEDS_INPUT

 Samuel> This will not work as LEDS_INPUT is itself depends and selects other
 Samuel> symbols and "select" statement does not propagate dependencies.

Ok, but that could either be solved by also selecting NEW_LEDS to pull
in LEDS_INPUT dependencies, so if we still want to be able to build
without pulling in the leds subsystem you could do 'select LEDS_INPUT if
NEW_LEDS' and stick the implementation inside an #ifdef NEW_LEDS.

-- 
Bye, Peter Korsgaard

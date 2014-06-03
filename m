From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 03 Jun 2014 23:12:09 +0200
Subject: [alsa-devel] [PATCH] ASoC: pxa: add I2C dependencies as needed
In-Reply-To: <46560700.2S4p0nUZl8@wuerfel> (Arnd Bergmann's message of "Tue,
 03 Jun 2014 20:38:27 +0200")
References: <46560700.2S4p0nUZl8@wuerfel>
Message-ID: <87k38xg0k6.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> We have in the past added 'depends on I2C' for some of the PXA boards
> after hitting randconfig build bugs. I have seens a couple of new
> bugs in this area during the linux-next cycle for 3.16, after it
> became possible to build some more PXA machines with I2C disabled.
>
> To shut this up for good, this adds the dependency to every board
> that uses I2C as the interface to the codec. I have gone through
> all board files and verified that they all either use AC97 or
> I2C, and this annotates the latter. Some of these already enable
> I2C from mach-pxa/Kconfig, but since that can change it's better
> to be explicit here.
>
> The link error that can result otherwise happens when CONFIG_I2C
> is set to 'm' and the codec driver is built-in as a result of being
> selected by the platform specific glue.

Hi Arnd,

Any reason SND_PXA2XX_SOC_MIOA701 escaped ? The board is PXA based, and its
codec wm9713 is I2C based, and relies on AC97.

Cheers.

-- 
Robert

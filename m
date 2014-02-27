From: markus.mayer@linaro.org (Markus Mayer)
Date: Thu, 27 Feb 2014 14:20:17 -0800
Subject: [PATCH] gpio: only enable kona driver on BCM_MOBILE or for
 compile testing
In-Reply-To: <1392990146-18916-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1392990146-18916-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAPdLdqkq06AuLr8a8x9aY8BmHHbcNsL5tmQrH4j8bEom_HS-kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 February 2014 05:42, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> I'm not sure if and how "Kona" fits into the bcm281xx namespace, but
> reading through the commit logs of the changes touching
> drivers/gpio/gpio-bcm-kona.c so far suggests it does. In this case I'd
> consider it a good idea to mention "bcm281xx" in the help text of
> GPIO_BCM_KONA.

Naming these components has been quite a challenge for our upstreaming
effort. Some things are not very obvious unless you know he chip or
were involved in those discussions.

"Kona" can be thought of as an architecture or a family of chips.
bcm281xx is one member of that family. There are others. I submitted
bcm21664 to arm-linux just a few minutes ago. bcm21664 also uses
gpio-bcm-kona.c.

Mentioning the SoCs in the help text is a good idea, but we'll likely
have to come up with a central location where all supported members of
the Kona family are listed, so they aren't scattered all over
different sub-systems (Kona watchdog, Kona GPIO, Kona timer, etc.) If
we don't have a central location, we'll be certain to forget updating
one of the help texts eventually, and it would become inconsistent.

Regards,
-Markus

-- 
Markus Mayer
Broadcom Landing Team

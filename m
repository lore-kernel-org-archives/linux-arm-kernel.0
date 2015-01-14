From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Jan 2015 13:26:16 +0100
Subject: [PATCH RFC] pinctrl: at91
In-Reply-To: <20150106093706.GC26982@ldesroches-Latitude-E6320>
References: <CACRpkdbkUUzVVMp14szY+vGNd+d+8bL066STh_XMGud-UsFBqA@mail.gmail.com>
 <1418637470-5839-1-git-send-email-ludovic.desroches@atmel.com>
 <54943933.60102@atmel.com>
 <20150106093706.GC26982@ldesroches-Latitude-E6320>
Message-ID: <CACRpkda9wTPcRy6nRGP08rDpHV=tRyYVuD80TeO2zFGzX+aJcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 6, 2015 at 10:37 AM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:

> Usage of of_gpiochip_add() only solves my issue about gpio but not about
> pinctrl stuff, I still need a patch to manage the case when we have a gap if
> a gpio controller is not enabled to not break the pin naming, etc.

This has been the topic of many threads today.
I assume you are talking about keeping GPIO numbers
consistent.

- My suggestion is to add alias handling of the GPIO chips
  to the core so they can be probed in the right order.

- For consistency in sysfs use the "names" array in
  struct gpio_chip so you can search for a symbolic
  name in sysfs and don't have to rely on fragile stuff
  like GPIO numbers.

- Partake in the development of a new GPIO ABI
  that does not use the global GPIO numberspace.

Yours,
Linus Walleij

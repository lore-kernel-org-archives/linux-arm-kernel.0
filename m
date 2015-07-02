From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 2 Jul 2015 16:26:01 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <5594E9F6.7040701@linutronix.de>
References: <cover.1435777856.git.rcochran@linutronix.de>
 <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
 <5594E9F6.7040701@linutronix.de>
Message-ID: <20150702142601.GB9349@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 02, 2015 at 09:36:22AM +0200, Sebastian Andrzej Siewior wrote:
> If you are in a specific SoC you could do
> 	base = of_alias_get_id(np, "gpio") * num_of_gpio_per_chip
> and get consistent numbers / sane.

And what about /sys/class/gpio ?

> I think this is the one reason why there is no generic binding for the
> starting address. The other reason might be that this is simply a user
> space problem. To get consistent numbers all you need to do to lookup
> each gpio's memory address and decide if this is the one you look for.

The user should be able to simply look up a GPIO in the data sheet,
and then use it from a shell script.  Why not make that easy to do?

(Other gpio controllers are doing that, too, BTW.)

Thanks,
Richard

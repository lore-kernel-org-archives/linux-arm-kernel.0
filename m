From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 27 Mar 2015 10:18:14 +0000
Subject: [PATCH 01/13] thermal: Make temperatures consistently unsigned
 long
In-Reply-To: <1427385240-6086-2-git-send-email-s.hauer@pengutronix.de> (Sascha
 Hauer's message of "Thu, 26 Mar 2015 16:53:48 +0100")
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <9hhzj6y217d.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Sascha Hauer <s.hauer@pengutronix.de> writes:

> The thermal framework uses int, long and unsigned long for temperatures
> in millicelsius. The majority of functions uses unsigned long, so change
> the remaining functions to use this type aswell.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I'd suggest changing to long instead. It would allow the use of the
thermal framework in environments where temperatures are below 0C -
quite easily reached in many parts of the world.

Regards,
Punit

> ---
>  drivers/thermal/thermal_core.c | 10 +++++-----
>  include/linux/thermal.h        |  6 +++---
>  2 files changed, 8 insertions(+), 8 deletions(-)
>

[...]

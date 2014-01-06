From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 6 Jan 2014 22:31:35 +0100
Subject: [RFC RESEND PATCH 1/1] thermal: introduce clock cooling device
In-Reply-To: <1389013458-14719-1-git-send-email-eduardo.valentin@ti.com>
References: <1389013458-14719-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <20140106213135.GA14927@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> --- /dev/null
> +++ b/drivers/thermal/clock_cooling.c
> @@ -0,0 +1,484 @@
> +/*
> + *  drivers/thermal/cpu_cooling.c

Bit too much copy&paste...


> + *  Copyright (C) 2013	Texas Instruments Inc.
> + *  Contact:  Eduardo Valentin <eduardo.valentin@ti.com>
> + *
> + *  Highly based on cpu_cooling.c.

Check english. And you should add samsung & linaro copyright here,
since you copied from it.

> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

can we get rid of ~~~s?

> +static int clock_cooling_get_property(struct clock_cooling_device *ccdev,
> +				      unsigned long input,
> +				      unsigned long *output,
> +				      enum clock_cooling_property property)
> +{
> +	int i, j;
> +	unsigned long max_level = 0, level = 0;
...
> +	if (property == GET_MAXL) {
> +		*output = (unsigned int)max_level;

What is going on with types here? Remove cast?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

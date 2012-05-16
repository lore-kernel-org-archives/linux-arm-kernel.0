From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 May 2012 00:21:14 +0800
Subject: [PATCH] gpio/generic: initialize the shadow of direction register
In-Reply-To: <20403.46023.772833.889330@ipc1.ka-ro>
References: <20120516053301.GB21517@S2100-06.ap.freescale.net>
 <20403.20214.297216.188300@ipc1.ka-ro>
 <20120516072859.GE21517@S2100-06.ap.freescale.net>
 <20403.22671.800713.334846@ipc1.ka-ro>
 <CAAQ0ZWRpm8mrBnseepV17QMGZcz3W=vw4yYJR5UvSGg2i5dvgg@mail.gmail.com>
 <20403.41495.610333.670008@ipc1.ka-ro>
 <20120516133850.GA3764@S2100-06.ap.freescale.net>
 <20403.44198.671025.83880@ipc1.ka-ro>
 <20120516140717.GB3764@S2100-06.ap.freescale.net>
 <20403.46023.772833.889330@ipc1.ka-ro>
Message-ID: <20120516162113.GF3764@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 04:03:51PM +0200, Lothar Wa?mann wrote:
> _You_ want to introduce a change that will change the behaviour of
> existing code, so it's _your_ responsibility to make sure that your
> change doesn't break other users.
> 
> Those are the current users of bgpio:
> ./drivers/gpio/gpio-sodaville.c:        ret = bgpio_init(&sd->bgpio, &pdev->dev, 4,
> ./drivers/gpio/gpio-ep93xx.c:   err = bgpio_init(bgc, dev, 1, data, NULL, NULL, dir, NULL, false);
> ./drivers/gpio/gpio-mxc.c:      err = bgpio_init(&port->bgc, &pdev->dev, 4,
> ./drivers/gpio/gpio-mxs.c:      err = bgpio_init(&port->bgc, &pdev->dev, 4,
> 
> You should at least CC: their maintainers to inform them that the code
> they are relying on will change its behaviour.
> 
Yeah, considering it's impossible for me to test the change on all
those hardwares, that's the only thing I can do.  Thanks for pointing
those users to me.

-- 
Regards,
Shawn

From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 May 2012 00:17:27 +0800
Subject: [PATCH] gpio/generic: initialize the shadow of direction register
In-Reply-To: <20403.45469.121234.808145@ipc1.ka-ro>
References: <1337054198-24674-1-git-send-email-shawn.guo@linaro.org>
 <20402.798.622618.263780@ipc1.ka-ro>
 <20120516053301.GB21517@S2100-06.ap.freescale.net>
 <20403.20214.297216.188300@ipc1.ka-ro>
 <20120516072859.GE21517@S2100-06.ap.freescale.net>
 <20403.22671.800713.334846@ipc1.ka-ro>
 <CAAQ0ZWRpm8mrBnseepV17QMGZcz3W=vw4yYJR5UvSGg2i5dvgg@mail.gmail.com>
 <20403.45469.121234.808145@ipc1.ka-ro>
Message-ID: <20120516161726.GE3764@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 03:54:37PM +0200, Lothar Wa?mann wrote:
> Actually I had sent a similar patch in July last year which was
> rejected with the following reasoning:
> 
> | I don't know if this is a valid thing to do or not. Not every GPIO
> | controller supports reading back the initial state from the direction
> | register. I suspect it is better to leave initialization of the
> | direction to the gpio controller driver itself.
> 
> See: http://lkml.indiana.edu/hypermail/linux/kernel/1107.0/00908.html
> 
> That's why I came up with the patch to gpio-mxc.c
> 
Thanks for the whole story, Lothar.  Hopefully, with the additional
condition checking added, Grant would agree it's the right thing to do.
I will send v2 of the patch to see what we get from people.

-- 
Regards,
Shawn

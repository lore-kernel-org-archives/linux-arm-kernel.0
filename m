From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 16 May 2012 15:54:37 +0200
Subject: [PATCH] gpio/generic: initialize the shadow of direction register
In-Reply-To: <CAAQ0ZWRpm8mrBnseepV17QMGZcz3W=vw4yYJR5UvSGg2i5dvgg@mail.gmail.com>
References: <1337054198-24674-1-git-send-email-shawn.guo@linaro.org>
 <20402.798.622618.263780@ipc1.ka-ro>
 <20120516053301.GB21517@S2100-06.ap.freescale.net>
 <20403.20214.297216.188300@ipc1.ka-ro>
 <20120516072859.GE21517@S2100-06.ap.freescale.net>
 <20403.22671.800713.334846@ipc1.ka-ro>
 <CAAQ0ZWRpm8mrBnseepV17QMGZcz3W=vw4yYJR5UvSGg2i5dvgg@mail.gmail.com>
Message-ID: <20403.45469.121234.808145@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On 16 May 2012 15:34, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> > You initialize a variable to a specific value that defaulted to zero
> > before.
> >
> The variable defaulted to zero is causing a problem.  I'm fixing that problem.
> 
Actually I had sent a similar patch in July last year which was
rejected with the following reasoning:

| I don't know if this is a valid thing to do or not. Not every GPIO
| controller supports reading back the initial state from the direction
| register. I suspect it is better to leave initialization of the
| direction to the gpio controller driver itself.

See: http://lkml.indiana.edu/hypermail/linux/kernel/1107.0/00908.html

That's why I came up with the patch to gpio-mxc.c


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

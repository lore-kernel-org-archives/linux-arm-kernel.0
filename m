From: rob@emanuele.us (Robert Emanuele)
Date: Mon, 14 Dec 2009 10:57:52 -0800
Subject: Enhanced MMC/SD Card Power Control
Message-ID: <9f53b4330912141057n52bc9331q3089ee0fb0bcbc50@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings once again,

Over the summer I had submitted a series of patches for the atmel-mci
driver.  One of these was for power control of each mci slot.

http://lists.arm.linux.org.uk/lurker/message/20090617.005438.eb1570d9.en.html

I'd like to resubmit this and enhance it slightly.  The current work
I'm doing is on Atmel's AT91SAM9G45.  In the patch above I include a
power control pin and the state it needs to be pulled.  I'd like to
change this to two platform defined functions for power on and power
off.  This way given which ever platform this is being used on that
platforn can concisely define how to move from a power on state to a
power off and vice versa.

For example, on my platform I would pull some GPIO high to turn off a
FET to the power of the slot and then change the function of all the
pins going to the card (except for the detect pin of course) to open
drains.  Then on power up I would do the reverse.

Given what I have described here, where would be the most logical
place to put such code?  I was assuming that it would go into the
platform configuration into the board file (board-mynewboard.c in
arch/arm/mach-at91/).

Thank you for your help and comments,

Rob

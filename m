From: n.kinar@usask.ca (Nicholas Kinar)
Date: Mon, 23 May 2011 14:53:27 -0600
Subject: LCDVSYNC not set up in Atmel AT91SAM9RL device code
Message-ID: <4DDAC947.7040705@usask.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I've been setting up an LCD display interfaced to the Atmel AT91SAM9RL 
processor, and I noticed that in the 
/arch/arm/mach-at91/at91sam9rl_devices.c file, the GPIO pin AT91_PIN_PC4 
is not switched over to the LCD peripheral.

To make the LCD display peripheral operate properly, I had to add the 
following line to the at91_add_device_lcdc() function:

at91_set_A_periph(AT91_PIN_PC4, 0);    /* LCDVSYNC */

Perhaps this could be patched?  I do not know if a similar issue also 
occurs in other device setup files.

Nicholas

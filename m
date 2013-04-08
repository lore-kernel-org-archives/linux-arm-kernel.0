From: fabian@ritter-vogt.de (Fabian Vogt)
Date: Mon, 08 Apr 2013 21:16:27 +0200
Subject: [RFC PATCH arm: initial TI-Nspire support]
In-Reply-To: <896CB251-17FC-4327-BA4E-A8FD9ED1BEC7@gmail.com>
References: <6FE4B33E-A503-4A75-AEED-831CB2C06D83@gmail.com>
 <4B3FD561-84FC-40CD-B747-13851692D673@gmail.com>
 <521DFDFC-7E9E-47EA-ACDA-C91BBDC8454E@gmail.com>
 <201304072323.42173.arnd@arndb.de>
 <896CB251-17FC-4327-BA4E-A8FD9ED1BEC7@gmail.com>
Message-ID: <op.wu8k5pwqu7prd4@fabians-laptop.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest kernel it seems to get stuck at
console_lock() in register_framebuffer (drivers/video/fbmem.c:1655)
if the LCD-controller is enabled. (Early printk and serial console works  
fine)
CONFIG_NO_HZ is not activated, it works completely.
Could this be a kernel bug or is this an issue with our timer  
configuration?

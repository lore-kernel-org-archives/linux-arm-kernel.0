From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 28 Jan 2014 15:14:37 +0100
Subject: [PATCH 01/11] resolve PXA<->8250 serial device address conflict
In-Reply-To: <1385879185-22455-2-git-send-email-ynvich@gmail.com>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <1385879185-22455-2-git-send-email-ynvich@gmail.com>
Message-ID: <20140128141437.GB8713@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> PXA serial ports have "standard" UART names (ttyS[0-3]), major
> device number (4) and first minor device number (64) by default.
> 
> If the system has extra 8250 serial port hardware in addition
> to onboard PXA serial ports, default settings produce a device
> allocation conflict.
> 
> The patch provides a configuration option which can move onboard
> ports out of the way of 8250_core by assigning a different (204)
> major number and corresponding device names (ttySA[0-3]).

Yes, please. I was hitting the same issue with Sharp Zaurus and bluetooth
CF card... Bluetooth card had 8250 inside...


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

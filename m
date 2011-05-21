From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 21 May 2011 22:28:07 +0200
Subject: [PATCH] MAX1111: Fix race condition causing NULL pointer exception
In-Reply-To: <201105200013.20380.morpheus.ibis@gmail.com>
References: <1305731918-20164-1-git-send-email-morpheus.ibis@gmail.com>
	<201105191451.40416.morpheus.ibis@gmail.com>
	<20110519193121.GC7445@n2100.arm.linux.org.uk>
	<201105200013.20380.morpheus.ibis@gmail.com>
Message-ID: <20110521202806.GA3518@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I think you want to hold the mutex at the point you setup the data to be
> > transferred, do the transfer, and then release the mutex once you've read
> > the results of the transfer.
> 
> oh no, not again...
> this was the earliest version, not the cleaned-up one (notice the lock in 
> setup-transfer, which I said was unnecessary)
> here is the cleaner (newest) version:

Unfortunately that one does not apply, due to 

> @@ -213,6 +224,7 @@ static int __devexit max1111_remove(struct spi_device 
> *spi)

Whitespace damage. (but if you just delete this extra newline, its
fine).

Other than that, it seems to work. I was playing with max1111 a lot
today, and no oops.

ACK.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

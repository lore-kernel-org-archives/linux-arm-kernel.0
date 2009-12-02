From: andy@warmcat.com (Andy Green)
Date: Wed, 02 Dec 2009 19:35:33 +0000
Subject: [PATCH 1/1] fix occasional ULPI timeouts with ehci-mxc
In-Reply-To: <37367b3a0912021058j2801df5l2c937ac339bc5f6b@mail.gmail.com>
References: <1259770381-16987-1-git-send-email-valentin.longchamp@epfl.ch>
	<37367b3a0912021058j2801df5l2c937ac339bc5f6b@mail.gmail.com>
Message-ID: <4B16C185.80905@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/09 18:58, Somebody in the thread at some point said:

Hi -

> mx27# usb 2-1: new low speed USB device using mxc-ehci and address 2
> hub 2-0:1.0: unable to enumerate USB device on port 1
>
> What you think about it?

What did you do with your chip select line on the ULPI PHY?

The first iMX LiteKIT board I had was an old revision where they had 
tied the PHY chip select pin asserted.  The ULPI PHY acted braindamaged 
because glitchy junk from during poweron / reset was taken as real data 
and it never recovered during the session.

Later versions of the LiteKIT changed this to be pulled deasserted and a 
GPIO can drive it asserted after reset is all done.  After I got a later 
revision with that mod, and drove the GPIO, suddenly all was well.

Never going to get that week back though.

-Andy

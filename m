From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 27 Nov 2009 11:50:41 +0100
Subject: Changing HZ value in linux kernel
In-Reply-To: <3523d4970911250050u4e5fd676w51585fd65c7798c7@mail.gmail.com>
References: <3523d4970911250050u4e5fd676w51585fd65c7798c7@mail.gmail.com>
Message-ID: <20091127105040.GB26570@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Nov 25, 2009 at 08:50:43AM +0000, Robert Garrett wrote:
> I have a question about timers in the linux kernel.  I'm working with an
> embedded ARM processor (pxa-x270) and linux kernel version 2.6.16.  One of
> the drivers I'm writing needs 1ms timing accuracy and I found I could
> achieve this using kernel timers and changing the value of HZ to 1000 (the
> default is 100).
> 
> However, I now find that mdelay and udelay etc. don't give the correct
> delays.  This causes a problem in one of the other drivers I have, but I'm
> also worried that other code within the kernel may have broken aswell.
HZ=1000 produces some overhead that might or might not be too heavy for
your machine.

Maybe high-resolution timers can help you, but probably
you have to update your kernel so something newer than 2.6.16 for that.
 
Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |

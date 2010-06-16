From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Jun 2010 10:19:31 +0100
Subject: [PATCH 02/10] arm/zImage: some comments for __armv3_mpu_cache_on
In-Reply-To: <AANLkTiluJns87Cc7Xk4VA-_9nXMNuhfcR2Kwu0A0IevK@mail.gmail.com>
References: <20100610102427.GC31057@pengutronix.de>
	<1276165636-20150-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTiluJns87Cc7Xk4VA-_9nXMNuhfcR2Kwu0A0IevK@mail.gmail.com>
Message-ID: <20100616091931.GA16149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 16, 2010 at 11:16:43AM +0800, Eric Miao wrote:
> > ? ? ? ? ? ? ? ?mrc ? ? p15, 0, r0, c1, c0, 0 ? @ read control reg
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?@ .... .... .... WC.M
> > ? ? ? ? ? ? ? ?orr ? ? r0, r0, #0x000d ? ? ? ? @ .... .... .... 11.1
> > + ? ? ? ? ? ? ? /* ?? this overwrites the value constructed above? */
> > ? ? ? ? ? ? ? ?mov ? ? r0, #0
> 
> This does seem to be an error.

If we can't test the removal of that line, we have to assume that the
existing code was tested, and did work.  (It certainly will work, but
slower because the caches would not be on.)  We don't know if removing
this line would cause problems.

I think it's better just to add a comment about it, and leave the code
as-is.

However, if someone has an ARM740T system and can test the removal of
this, then we can remove it.  I suspect that ARM740T systems are rarely
worked on now though - esp. as the whole nommu stuff doesn't seem to
get much attention.

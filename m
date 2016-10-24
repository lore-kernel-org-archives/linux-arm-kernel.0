From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 24 Oct 2016 23:41:52 +0200
Subject: [RFC] shutdown machine when li-ion battery goes below 3V
In-Reply-To: <20161024212932.uhjz752z2cy5hohl@atomide.com>
References: <20161024212250.GA31336@amd>
 <20161024212932.uhjz752z2cy5hohl@atomide.com>
Message-ID: <20161024214152.GA32310@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2016-10-24 14:29:33, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [161024 14:24]:
> > Hi!
> > 
> > What about something like this? N900 will drain the battery down to
> > system crash, which is quite uncool.
> 
> Can't we make that generic and configurable for the voltage somehow?

I was afraid someone would ask :-).

Yes, we probably need to create battery object in the device tree,
then add properties there.

> Also, the shutdown voltage can depend on external devices connected.
> It could be for example 3.3V depending on eMMC on some devices while
> devices with no eMMC could have it at 3.0V.

Actually, I'd like to shutdown at 3.3V or more (like 3.5V), because
going below that is pretty mean to the battery. But if I set threshold
too high, GSM activity will push it below that for a very short while,
and I'll shutdown too soon.

Ideas welcome...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/eff01459/attachment-0001.sig>

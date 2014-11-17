From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 17 Nov 2014 11:05:19 +0100
Subject: [RFC] adp1653: Add device tree bindings for LED controller
In-Reply-To: <201411170943.20810@pali>
References: <20141116075928.GA9763@amd>
 <201411170943.20810@pali>
Message-ID: <20141117100519.GA4353@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon 2014-11-17 09:43:19, Pali Roh?r wrote:
> On Sunday 16 November 2014 08:59:28 Pavel Machek wrote:
> > For device tree people: Yes, I know I'll have to create file
> > in documentation, but does the binding below look acceptable?
> > 
> > I'll clean up driver code a bit more, remove the printks.
> > Anything else obviously wrong?

> I think that this patch is probably not good and specially not 
> for n900. adp1653 should be registered throw omap3 isp camera 
> subsystem which does not have DT support yet.

Can you explain?

adp1653 is independend device on i2c bus, and we have kernel driver
for it (unlike rest of n900 camera system). Just now it is unusable
due to lack of DT binding. It has two functions, LED light and a
camera flash; yes, the second one should be integrated to the rest of
camera system, but that is not yet merged. That should not prevent us
from merging DT support for the flash, so that this part can be
tested/maintained.

> See n900 legacy board camera code in file board-rx51-camera.c.

I have seen that.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 16 Jul 2017 20:22:35 +0200
Subject: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
In-Reply-To: <5290346.YItt1Jp12B@aspire.rjw.lan>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <1529148.KHlxNOSRLV@aspire.rjw.lan>
 <20170706031750.GA12954@xo-6d-61-c0.localdomain>
 <5290346.YItt1Jp12B@aspire.rjw.lan>
Message-ID: <20170716182235.GB14461@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > So why exactly isn't it reasonable?
> > > 
> > > Please use technical arguments.  Saying that something is wrong without
> > > explaining the problem you see with it isn't particulatly useful in technical
> > > discussions.
> > 
> > Deep in your heart, you should know that having enum listing all the platforms linux
> > runs on is a very bad idea.
> 
> Even so, if I'm unable to explain to people why this is a bad idea in technical
> terms, that doesn't mean too much.

I could say something O(#drivers * #platforms) vs. O(#drivers +
#platforms) lines of code -- but I thought it was obvious...?

> > Anyway, there are better solutions, regulator framework already knows if given rail
> > will be powered off or not, and their driver already knows if they are going
> > suspend/standby. They just need to use existing interfaces.
> 
> So they need to know what has been passed to suspend_devices_and_enter()
> anyway and currently there's no interface for that.  That actually is the source
> of the whole issue.

Yep, I don't like that, but I guess we should give drivers enough
information to ask regulator framework.

Best regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170716/5b0418fd/attachment.sig>

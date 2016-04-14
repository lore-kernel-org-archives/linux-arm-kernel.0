From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 14 Apr 2016 15:13:49 +0200
Subject: [PATCH v6 14/14] arm64: hibernate: Prevent resume from a
 different kernel version
In-Reply-To: <570F9160.30408@arm.com>
References: <1456766423-1554-1-git-send-email-james.morse@arm.com>
 <1456766423-1554-15-git-send-email-james.morse@arm.com>
 <20160410114938.GB30188@xo-6d-61-c0.localdomain>
 <570F9160.30408@arm.com>
Message-ID: <20160414131349.GA15106@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> Signed-off-by: James Morse <james.morse@arm.com>
> > 
> > Better solution would be to store the current bits _and_ UTS version. Then bump UTS_VERSION
> > every time Linux behaviour changes w.r.t. EFI. For a while, it would change a lot, but then
> > it should stabilize, as the port stabilizes
> 
> If we want to support resuming with a different kernel version. Patch 13 (of
> this series) does this, it has 'HIBERNATE_VERSION', which we would have to
> increase every time an incompatible change is made, but I'm worried that its a
> constant game of catch-up to work out which changes are compatible. The first
> sign a user gets that this isn't supported, (who reads the changelog?), is when
> it fails to resume, and they loose any data that was written to the hibernate image.
> 

> What does restoring with a different kernel version get used for? (I agree its a
> neat trick!) I can see it would be useful on laptops, where the distribution can
> upgrade the kernel and the user can still use hibernate before they reboot. But
> the distribution can switch this value to be just the kernel version if they are
> willing to test hibernate/resume over any updates they make.

Well, it is way too easy to forget that you've updated your kernel,
and then hibernate. I've been burned more than once. 

And for example updating from 4.4.1 to 4.4.2 to 4.4.3 to... should be
very safe, and pretty important for distribution users.

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

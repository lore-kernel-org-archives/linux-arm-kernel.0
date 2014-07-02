From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jul 2014 17:15:58 +0100
Subject: [PATCH RFC v2 3/8] component: add support for component match
 array
In-Reply-To: <CAAQKjZOf-UoONHFf=6W4j4rXuo0nSJrhK_QesxNR55CEF7XONw@mail.gmail.com>
References: <20140624192830.GC20555@n2100.arm.linux.org.uk>
 <E1WzWOy-0007zc-36@rmk-PC.arm.linux.org.uk>
 <CA+gwMcdO5P-Yu+-FeHHGxkKwObsATL-ThVDwmEm2_cZ3enUXPQ@mail.gmail.com>
 <20140626144601.GS32514@n2100.arm.linux.org.uk>
 <20140701142210.GS32514@n2100.arm.linux.org.uk>
 <CAAQKjZOf-UoONHFf=6W4j4rXuo0nSJrhK_QesxNR55CEF7XONw@mail.gmail.com>
Message-ID: <20140702161557.GN32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 12:26:39AM +0900, Inki Dae wrote:
> It's has been just a week. I will check and look into your patch
> series. I think Exynos drm should also be considered for the use of
> component match array.

Actually, this series has been around for much longer than just a
week.  Your new usage introduced in the recent merge window is what
has resulted in you becoming aware of this series.

It was developed before April through discussions, and then shared
with those people.  Then, April 27th, it was posted publically to
all the recipients except yourself (because Exynos hadn't visibly
been converted).  At that time, two reviewed-by tags were given.

It was also sent out last week, with yourself added to the recepient
list because there is now a dependency with some of your work.

However, what I'm asking for is *not* the entire series to be merged
at this point - that would break Exynos DRM.  I'm asking for the first
three to be merged initially by Greg, which gets the new interface in
place without breaking existing users.  We can then convert existing
users at a slower rate, and remove the old interface once everyone
has caught up.

So, I'd ask that you give priority to looking at the first three
patches and deciding whether you find them acceptable as a replacement
interface, rather than trying to review the entire set of six core
patches (1,2,3,6,7,8).

What I'm trying to avoid here is for all these patches to be delayed
past the next merge window, and pushed into the next cycle.  That's
likely to end up in the same scenario as exists with Exynos DRM today,
only with other new users of the existing interface - and then have to
repeat this whole "try to get the new users to review this set of
changes" cycle again.

We're half way through -rc3 right now.  -final occurs anytime between
-rc6 and -rc9, which could be just three and a half weeks away.

I have other changes which I need to get out onto the list(s) which
depend on this too (for DRM) which I'm hoping to also make this coming
merge window, but I can't start that process until I know where I
stand with these.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

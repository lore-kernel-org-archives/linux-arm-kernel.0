From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 12 Jun 2014 18:47:48 +0200
Subject: [PATCH 0/5] Handle non-secure L2C initialization on Exynos4
In-Reply-To: <20140612162014.GA3705@n2100.arm.linux.org.uk>
References: <CAD8Lp46MbKZrCAMp+9T9LbWTB4uHRDdivhtjoQbkTyBbK48EgQ@mail.gmail.com>
 <20140612162014.GA3705@n2100.arm.linux.org.uk>
Message-ID: <5399D9B4.5030901@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 12.06.2014 18:20, Russell King - ARM Linux wrote:
> On Thu, Jun 12, 2014 at 02:38:49PM +0100, Daniel Drake wrote:
>> From 2e67231f10ed0b05c2bacfdd05774fe21315d6da Mon Sep 17 00:00:00 2001
>> From: Gu1 <gu1@aeroxteam.fr>
>> Date: Mon, 21 Jan 2013 04:13:56 +0100
>> Subject: [PATCH] ARM: EXYNOS: Add secure firmware support for l2x0 init
>>
>> Conflicts:
>> 	arch/arm/mm/cache-l2x0.c
> 
> For this patch... it's a big NAK because it's taking us right back down
> the route of a totally fucked up cache-l2x0.c driver.

This is just an old, internal patch that was not going to be upstreamed.
I just posted another series yesterday[1], hopefully doing it the right
way. Looking forward for review comments.

[1] http://thread.gmane.org/gmane.linux.kernel/1722989

> 
> Why can't you people write stuff properly?  There's already another set
> of patches on this mailing list which want to pass the virtual base
> address of the l2x0 controller to l2c_write_sec() so that various
> registers can be read back, because the platform's secure API can
> only update several registers at the same time.

Probably the series you mention is [1]? :)

> 
> This is the same pattern that is revealed in this patch.  So, what
> this means is that the l2c_write_sec API is wrong.  We need to come
> up with a *replacement* API which allows the platforms to do this
> kind of setup in a *clean* way, and stop creating rotten hacks like
> this which just makes long term maintanence a nightmare.
> 
> So... please start doing stuff properly.  If you don't, you're going
> to be getting more flames from me, especially if you start doing this
> kind of hackery on code that I've been cleaning up to get rid of such
> crap.
> 

Yes, I fully agree. Fortunately that was not supposed to hit upstream.

You've done a lot of great work to refactor this driver (thanks!), which
made it possible to support Exynos secure firmware in a sane way and
this is how it should be done.

Best regards,
Tomasz

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 May 2012 13:48:20 +0000
Subject: [PATCHv2 0/3] Add support for DRM display subsystem
In-Reply-To: <CAH9JG2V_9RVPvEHodDD422r=o4QxHcrMO-YXv2KUGYeys=ZjqA@mail.gmail.com>
References: <1331635180-7207-1-git-send-email-m.szyprowski@samsung.com>
 <037301cd2e90$529112e0$f7b338a0$%kim@samsung.com>
 <CAH9JG2V_9RVPvEHodDD422r=o4QxHcrMO-YXv2KUGYeys=ZjqA@mail.gmail.com>
Message-ID: <201205101348.20870.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 May 2012, Kyungmin Park wrote:
> > And I won't apply new feature for non-dt board file from now on. I think,
> > we
> > need to support DT in mach-exynos/ instead of non-DT and DT together, so
> > please consider to move on dt supporting for Samsung mobile boards.
> >
> 
> Probably you misunderstand Arnd word.
> 
> "From the statements made so far, I can see no clear policy that we can
> apply to everyone. My take on this is that for any work I spend on
> multiplatform kernel, I concentrate on the DT-based board files and
> get them to work together first, but leave it up to the individual
> subarch maintainers whether they want to add other board files into
> the mix."
> 
> It doesn't mean add new feature to non-DT board. don't add new board file.

This is a completely separate discussion, the problem at hand doesn't
have anything to do with building a kernel for multiple mach-*
directories combined that I was referring to in the text you quote.

> In this case, DRM is not yet ready to support DT.
> 
> Okay, you can just drop this patches. but please note that this
> patches are posted at Mar 13 before you decide.

I think it's a good idea to make new features DT-only because this
way we don't get any regressions and everyone who want to use
the new feature will be able to test the DT support on his board.

This of course requires that basic DT support is available for the
systems in question so we don't regress when moving away from the
old board files. My impression is that we're getting close to that
point on exynos thanks to Thomas' work on this. AFAICT we don't
have a DT binding for screen timings yet, so you will still have
to use auxdata for that or put the timings into the driver.

	Arnd

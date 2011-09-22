From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Sep 2011 13:35:11 +0200
Subject: [GIT PULL] ux500-core for 3.2
In-Reply-To: <CACRpkdakwQMaqJ4TwXxPJYjayMjO5iN68RQSZODGfhGCEjXnZA@mail.gmail.com>
References: <CACRpkdZofKjOrPFWNR-2D0LWx3NGMiLwyhf7gAVdvBGvQHqJLQ@mail.gmail.com>
	<201109202248.01993.arnd@arndb.de>
	<CACRpkdakwQMaqJ4TwXxPJYjayMjO5iN68RQSZODGfhGCEjXnZA@mail.gmail.com>
Message-ID: <201109221335.11643.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 September 2011, Linus Walleij wrote:
> On Tue, Sep 20, 2011 at 10:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 20 September 2011, Linus Walleij wrote:
> >> to the ARM SoC tree (ux500 branch or however you prefer to handle it)?
> >> They have all been reviewed on the ARM list recently and are mostly
> >> minor fixes and Lee Jones nice cleanup patch.
> >
> > I would really like to see this split into logical branches, even
> > if there are just a few patches for each of them.
> 
> No problem. So the preferred scheme is to have three topics
> for a SoC: fixes, cleanup and "new stuff" or something like that?

Roughly, yes.  For new stuff, you can have multiple sub-categories,
depending on how many patches you have.

Some platforms have separated board-specific updates from overall
platform changes, which I find very useful.

Also, if you add (or remove) a major feature, that can be a branch
by itself for this feature.

> > It's also not clear if the two bug fix patches should be applied
> > to 3.1 and -stable as well as 3.2. My feeling is that they should.
> 
> Depends. For Srinidhi's
> "mach-ux500: enable fix for ARM errata 754322"
> yes, definately.
> 
> For:
> "mach-ux500: unlock I&D l2x0 caches before init"
> it's a performance regression, nothing like a crash or so.
> 
> (I guess you're referring to these two?)

Right, thanks for the explanation. If the latter is a regression,
I'd still treat it as a bug fix. For a general (non-regression)
performance improvement, I'd put it into a development branch.

> > If you want bug fixes to be backported, please add a 'Cc: stable at kernel.org'
> > line after your Signed-off-by. If not, add an explanation to the
> > pull request why they are not relevant for backporting.
> (...)
> > Please submit the two bug fixes again, rebased to an -rc release.
> 
> I'll fix.
> 
> Since it's just two patches I guess you can just pick these
> two in plaintext? But I can make a pull request if you prefer...

In general, I prefer pull requests, but if you have no other patches
for 3.2, I can just cherry-pick them from the branch I already pulled.
I would put the first patch into fixes for 3.1 and mark it as 'Cc:stable'
and the other one into fixes for 3.2 then.

	Arnd

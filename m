From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 17 Mar 2011 19:50:36 -0700
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <20110317183048.GW7258@atomide.com>
References: <20110317183048.GW7258@atomide.com>
Message-ID: <AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2011 at 11:30 AM, Tony Lindgren <tony@atomide.com> wrote:
>
> Please pull omap changes for this merge window from:

Gaah. Guys, this whole ARM thing is a f*cking pain in the ass.

You need to stop stepping on each others toes. There is no way that
your changes to those crazy clock-data files should constantly result
in those annoying conflicts, just because different people in
different ARM trees do some masturbatory renaming of some random
device. Seriously.

That usb_musb_init() thing in arch/arm/mach-omap2/usb-musb.c also
seems to be totally insane. I wonder what kind of insanity I'm missing
just because I don't happen to see the merge conflicts, just because
people were lucky enough to happen to not touch the same file within a
few lines.

Somebody needs to get a grip in the ARM community. I do want to do
these merges, just to see how screwed up things are, but guys, this is
just ridiculous. The pure amount of crazy churn is annoying in itself,
but when I then get these "independent" pull requests from four
different people, and they touch the same files, that indicates that
something is wrong.

And stop the crazy renaming already! Just leave it off. Don't rename
boards and drivers "just because", at least not when there clearly are
clashes. There's no point. I'm not even talking about the file renames
(which happened and can also make it "fun" to try to resolve the
conflicts when somebody else then makes _other_ changes), but about
the stupid "change human-readable names in board files just to annoy
whoever needs to merge the crap".

Somebody in the ARM community really needs to step up and tell people
to stop dicking around.

(I'm replying to the omap pull request, because that's the one I did
last, but I don't know who to "blame". I don't care. It really doesn't
matter. I realize thar ARM vendors do crazy shit and haven't figured
out this whole "platform" thing yet, but you guys need to push back on
the people sending you crap).

                                   Linus

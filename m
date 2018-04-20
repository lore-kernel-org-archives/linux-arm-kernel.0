From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 20 Apr 2018 09:34:02 +0200
Subject: [regression v4.17-rc0] Re: FORTIFY_SOURCE breaks ARM compilation
 in -next -- was Re: ARM compile failure in Re: linux-next: Tree for
 Apr 4
In-Reply-To: <CAGXu5jK9f62n95sOdJViXHXzQFyCdcsWt9HPvcdSFRp9Qqg0bg@mail.gmail.com>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404074856.GA9342@amd> <20180404175852.GI5700@atomide.com>
 <20180404184622.GA8608@amd> <20180404195951.GJ5700@atomide.com>
 <20180404201837.GA9710@amd> <20180415173908.GA2024@amd>
 <CAGXu5jK9f62n95sOdJViXHXzQFyCdcsWt9HPvcdSFRp9Qqg0bg@mail.gmail.com>
Message-ID: <20180420073402.GA9356@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2018-04-15 11:00:06, Kees Cook wrote:
> On Sun, Apr 15, 2018 at 10:39 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> Thanks.
> >>
> >> Ok, let me try to bisect it. Compile-problem should be easy...
> >>
> >> Hmm. And as it is compile-problem in single file, it should even be
> >> reasonably fast. I did not realize how easy it would be:
> >>
> >> #!/bin/bash
> >> set -e
> >> cp config.ok .config
> >> yes '' | ARCH=arm make lib/string.o
> >>
> >> And the winner is:
> >>
> >> ee333554fed55555a986a90bb097ac7f9d6f05bf is the first bad commit
> >> commit ee333554fed55555a986a90bb097ac7f9d6f05bf
> >> Author: Jinbum Park <jinb.park7@gmail.com>
> >> Date:   Tue Mar 6 01:39:24 2018 +0100
> > ...
> >
> >>     Acked-by: Kees Cook <keescook@chromium.org>
> >>     Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
> >>     Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >
> > So I bisect a problem in -next, and patch is merged to Linus,
> > _anyway_, breaking compilation there? Neither Jinbum nor Russell even
> > bother to comment.
> 
> Hi! Sorry I lost this email in my inbox. It seems this is specific to
> a particular subset of arm architectures? (My local builds of arm all
> succeed, for example. Can you send your failing config?) I'll take a
> closer look on Monday if Daniel doesn't beat me to it.

Daniel, Kees: any news?

I'm aware you did not specify which Monday :-).
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180420/c69c1652/attachment.sig>

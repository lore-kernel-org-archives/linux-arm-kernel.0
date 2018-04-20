From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 20 Apr 2018 21:15:23 +0200
Subject: [regression v4.17-rc0] Re: FORTIFY_SOURCE breaks ARM compilation
 in -next -- was Re: ARM compile failure in Re: linux-next: Tree for
 Apr 4
In-Reply-To: <CAGXu5j+6D3PiVc9SR4+31ZGDC2r5uWJOw8Sn3cDhXdNqBGH+hQ@mail.gmail.com>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404074856.GA9342@amd> <20180404175852.GI5700@atomide.com>
 <20180404184622.GA8608@amd> <20180404195951.GJ5700@atomide.com>
 <20180404201837.GA9710@amd> <20180415173908.GA2024@amd>
 <CAGXu5jK9f62n95sOdJViXHXzQFyCdcsWt9HPvcdSFRp9Qqg0bg@mail.gmail.com>
 <20180420073402.GA9356@amd>
 <CAGXu5j+6D3PiVc9SR4+31ZGDC2r5uWJOw8Sn3cDhXdNqBGH+hQ@mail.gmail.com>
Message-ID: <20180420191523.GA28597@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> Hi! Sorry I lost this email in my inbox. It seems this is specific to
> >> a particular subset of arm architectures? (My local builds of arm all
> >> succeed, for example. Can you send your failing config?) I'll take a
> >> closer look on Monday if Daniel doesn't beat me to it.
> >
> > Daniel, Kees: any news?
> >
> > I'm aware you did not specify which Monday :-).
> 
> Hi! Sorry, I got distracted. So the .config you sent me builds fine
> with my cross compiler. I suspect this is something specific to ELDK's
> compiler. I can try some other compiler versions. What version of gcc
> is failing?

I have:

pavel at duo:/data/l/linux-n900$ arm-linux-gnueabi-gcc --version
arm-linux-gnueabi-gcc (GCC) 4.7.2
Copyright (C) 2012 Free Software Foundation, Inc.
pavel at duo:/data/l/linux-n900$ arm-linux-gnueabi-ld --version
GNU ld (GNU Binutils) 2.23.1.20121113
Copyright 2012 Free Software Foundation, Inc.

Let me try with eldk-5.6:

pavel at duo:/data/l/linux-n900$ arm-linux-gnueabi-gcc --version
arm-linux-gnueabi-gcc (GCC) 4.8.2
pavel at duo:/data/l/linux-n900$ arm-linux-gnueabi-ld --version
GNU ld (GNU Binutils) 2.24

make  lib/string.o

Seems to succeed, so I guess full build will succeed, too...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180420/9debba4e/attachment.sig>

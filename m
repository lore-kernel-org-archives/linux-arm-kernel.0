From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 15 Apr 2018 19:39:08 +0200
Subject: [regression v4.17-rc0] Re: FORTIFY_SOURCE breaks ARM compilation in
 -next -- was Re: ARM compile failure in Re: linux-next: Tree for Apr 4
In-Reply-To: <20180404201837.GA9710@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404074856.GA9342@amd> <20180404175852.GI5700@atomide.com>
 <20180404184622.GA8608@amd> <20180404195951.GJ5700@atomide.com>
 <20180404201837.GA9710@amd>
Message-ID: <20180415173908.GA2024@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Thanks.
> 
> Ok, let me try to bisect it. Compile-problem should be easy...
> 
> Hmm. And as it is compile-problem in single file, it should even be
> reasonably fast. I did not realize how easy it would be:
> 
> #!/bin/bash
> set -e
> cp config.ok .config
> yes '' | ARCH=arm make lib/string.o
> 
> And the winner is:
> 
> ee333554fed55555a986a90bb097ac7f9d6f05bf is the first bad commit
> commit ee333554fed55555a986a90bb097ac7f9d6f05bf
> Author: Jinbum Park <jinb.park7@gmail.com>
> Date:   Tue Mar 6 01:39:24 2018 +0100
...

>     Acked-by: Kees Cook <keescook@chromium.org>
>     Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
>     Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

So I bisect a problem in -next, and patch is merged to Linus,
_anyway_, breaking compilation there? Neither Jinbum nor Russell even
bother to comment.

And BTW, Russell, there's another regression I bisected to your
commit, that one is like two releases old, and "only" causes
compilation warnings during build with non-US locale. I even proposed
fix for that. Guess what? Ignored too.


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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180415/f9e15140/attachment-0001.sig>

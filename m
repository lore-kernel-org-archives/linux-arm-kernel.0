From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 16 Jan 2017 22:15:40 +0100
Subject: Nokia N900: mixers changed between 4.9 and 4.10-rc3, no longer
 can use in-call speaker
In-Reply-To: <201701150100.54214@pali>
References: <20170112181826.GA28290@amd> <201701121934.19810@pali>
 <20170114225614.GA25321@amd> <201701150100.54214@pali>
Message-ID: <20170116211540.GA19736@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > So regression seems to be between v4.9 and v4.10. Any ideas?
> 
> Interesting... seems there are no sound relevant changes after v4.9.
> 
> Looks like there are only three commits after v4.9 for sound/soc which 
> are built for Nokia N900:

I'm at ce38207f161513ee3d2bd3860489f07ebe65bc78, which is already
broken, and first broken commit by Linus.

> e411b0b5eb9b65257a050eac333d181d6e00e2c6

Can't revert that easily.

> e7aa450fe17890e59db7d3c2d8eff5b6b41fc531

This can be reverted. Lets try. Did not help.

> 63c3194b82530bd71fd49db84eb7ab656b8d404a

Commit older than this one fails, IIRC.

> Maybe something not related to sound/soc could broke it?

Its definitely caused by something merged here:

commit ce38207f161513ee3d2bd3860489f07ebe65bc78
Merge: a9042de 995c6a7
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Dec 14 11:14:28 2016 -0800

So it should be easy to find out..

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170116/a8bf5045/attachment-0001.sig>

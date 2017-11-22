From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 22 Nov 2017 17:19:14 +0100
Subject: [PATCH 00/18] arm64: Unmap the kernel whilst running in
 userspace (KAISER)
In-Reply-To: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
Message-ID: <20171122161913.GB12684@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> This patch series implements something along the lines of KAISER for arm64:
> 
>   https://gruss.cc/files/kaiser.pdf
> 
> although I wrote this from scratch because the paper has some funny
> assumptions about how the architecture works. There is a patch series
> in review for x86, which follows a similar approach:
> 
>   http://lkml.kernel.org/r/<20171110193058.BECA7D88@viggo.jf.intel.com>
> 
> and the topic was recently covered by LWN (currently subscriber-only):
> 
>   https://lwn.net/Articles/738975/
> 
> The basic idea is that transitions to and from userspace are proxied
> through a trampoline page which is mapped into a separate page table and
> can switch the full kernel mapping in and out on exception entry and
> exit respectively. This is a valuable defence against various KASLR and
> timing attacks, particularly as the trampoline page is at a fixed virtual
> address and therefore the kernel text can be randomized
> independently.

If I'm willing to do timing attacks to defeat KASLR... what prevents
me from using CPU caches to do that?

There was blackhat talk about exactly that IIRC...
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171122/576180b2/attachment.sig>

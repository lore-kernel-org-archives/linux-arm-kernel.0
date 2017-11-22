From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 23 Nov 2017 00:37:38 +0100
Subject: [PATCH 00/18] arm64: Unmap the kernel whilst running in
 userspace (KAISER)
In-Reply-To: <C271F3D3-A849-43F5-AE0A-6997890A3857@linaro.org>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
 <20171122161913.GB12684@amd>
 <CAKv+Gu9xw92F_K5XhDwpuSWCSbVJOMGSszuGBkyrhqboLhA-Mw@mail.gmail.com>
 <20171122223355.GA5877@amd>
 <C271F3D3-A849-43F5-AE0A-6997890A3857@linaro.org>
Message-ID: <20171122233738.GA25313@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>> If I'm willing to do timing attacks to defeat KASLR... what prevents
> >>> me from using CPU caches to do that?
> >>> 
> >> 
> >> Because it is impossible to get a cache hit on an access to an
> >> unmapped address?
> > 
> > Um, no, I don't need to be able to directly access kernel addresses. I
> > just put some data in _same place in cache where kernel data would
> > go_, then do syscall and look if my data are still cached. Caches
> > don't have infinite associativity.
> > 
> 
> Ah ok. Interesting.
> 
> But how does that leak address bits that are covered by the tag?

Same as leaking any other address bits? Caches are "virtually
indexed", and tag does not come into play...

Maybe this explains it?

https://www.youtube.com/watch?v=9KsnFWejpQg
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171123/cd26b01c/attachment.sig>

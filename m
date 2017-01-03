From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 3 Jan 2017 21:54:37 +0100
Subject: [Question] New mmap64 syscall?
In-Reply-To: <14981df2-b120-17c3-a5a8-5cbbd2008c4f@redhat.com>
References: <20161206185440.GA4654@yury-N73SV>
 <f544bcc3-8aae-1bd0-b744-9964fc038a51@redhat.com>
 <20161207154811.GA15248@yury-N73SV>
 <14981df2-b120-17c3-a5a8-5cbbd2008c4f@redhat.com>
Message-ID: <20170103205437.GA22548@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> >Hi Florian,
> >
> >I frankly don't understand what you mean, All syscalls you mentioned
> >doesn't take off_t or other 64-bit arguments. 'VM changes' - virtual
> >memory? If so, I don't see any changes in VM with this approach, just
> >correct handling of big offsets.
> 
> What I was trying to suggest is a completely different interface which is
> not subject to register size constraints and which has been requested before
> (a mechanism for batching mm updates).

While I agree that batching might be good idea, I believe mmap64()
makes sense, too. Yes, I guess libc could do the translation, but
indirection will cost some performance, and will be problematic for
stuff such as strace.

...actually, with strace and batched interface, it will be impossible
to see what is going on because of races. So I'm not sure if I like
the batched interface at all...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170103/fa7b7a22/attachment.sig>

From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 12 Jan 2017 22:51:28 +0100
Subject: [Question] New mmap64 syscall?
In-Reply-To: <59af3a6f-f30c-46a5-2d0b-6a7e36668e6b@redhat.com>
References: <20161206185440.GA4654@yury-N73SV>
 <f544bcc3-8aae-1bd0-b744-9964fc038a51@redhat.com>
 <20161207154811.GA15248@yury-N73SV>
 <14981df2-b120-17c3-a5a8-5cbbd2008c4f@redhat.com>
 <20170103205437.GA22548@amd>
 <59af3a6f-f30c-46a5-2d0b-6a7e36668e6b@redhat.com>
Message-ID: <20170112215128.GA14063@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2017-01-12 17:13:25, Florian Weimer wrote:
> On 01/03/2017 09:54 PM, Pavel Machek wrote:
> >...actually, with strace and batched interface, it will be impossible
> >to see what is going on because of races. So I'm not sure if I like
> >the batched interface at all...
> 
> I'm not sure if I understand this problem.
> 
> ioctl, fcntl, most socket system calls, even open all have this problem as
> well, right?

Yes, ioctl() and similar are problematic. Still it is possible to
implement secure sandbox using ptrace. Dealing with indirect mmap()
would difficult AFAICT.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170112/d730fd12/attachment-0001.sig>

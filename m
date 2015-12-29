From: ben@decadent.org.uk (Ben Hutchings)
Date: Tue, 29 Dec 2015 14:11:50 +0000
Subject: [PATCH] ARM: mm: Enable PXN when running non-LPAE kernel on LPAE
In-Reply-To: <56828F44.9030204@arm.com>
References: <005201d1415a$e5fe5ed0$b1fb1c70$@samsung.com>
 <1451341389.25978.39.camel@decadent.org.uk> <56828F44.9030204@arm.com>
Message-ID: <1451398310.25978.51.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-12-29 at 13:48 +0000, Vladimir Murzin wrote:
> On 28/12/15 22:23, Ben Hutchings wrote:
[...]
> > I've never needed to use a web-based system to submit kernel patches
> > before, and I'm not going to start now.??Someone else can re-submit
> 
> You don't have to... I just quote Catalin's recipe [1]
> 
> > You can send patches as usual to patches at arm.linux.org.uk, just add
> > KernelVersion: v3.?? after the --- line in your patch (maybe this could
> > be automate as well but I didn't bother).
> > 
> > For series, because the arrival order is not guaranteed, I use the git
> > alias below to trick it into sleeping 60s between patches:
> > 
> > ksend-rmk-patch = !git send-email --annotate --no-thread --suppress-cc=all --to-cmd='sleep 60 && echo patches at arm.linux.org.uk "#"'
> > 
> > For stgit, I have a dedicated template:
> > 
> > From: %(sender)s
> > To: patches at arm.linux.org.uk
> > Subject: %(prefix)s%(shortdescr)s
> > 
> > %(longdescr)s
> > PATCH FOLLOWS
> > KernelVersion:%(version)s
> > %(diff)s
> > 
> > And there is always git pull request that Russell is happy with.
> 
> Does it work for you?
> 
> [1] https://lkml.org/lkml/2014/8/22/228

Thanks.  Jungseung Lee has already re-submitted this patch, though.

Ben.

-- 
Ben Hutchings
If God had intended Man to program,
we'd have been born with serial I/O ports.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151229/015636b9/attachment.sig>

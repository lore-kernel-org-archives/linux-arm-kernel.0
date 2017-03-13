From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Mar 2017 13:21:50 +0000
Subject: [RFC PATCH 00/12] Ion cleanup in preparation for moving out of
 staging
In-Reply-To: <20170313105433.GA12980@e106950-lin.cambridge.arm.com>
References: <20170303132949.GC31582@dhcp22.suse.cz>
 <cf383b9b-3cbc-0092-a071-f120874c053c@redhat.com>
 <20170306074258.GA27953@dhcp22.suse.cz>
 <20170306104041.zghsicrnadoap7lp@phenom.ffwll.local>
 <20170306105805.jsq44kfxhsvazkm6@sirena.org.uk>
 <20170306160437.sf7bksorlnw7u372@phenom.ffwll.local>
 <CA+M3ks77Am3Fx-ZNmgeM5tCqdM7SzV7rby4Es-p2F2aOhUco9g@mail.gmail.com>
 <26bc57ae-d88f-4ea0-d666-2c1a02bf866f@redhat.com>
 <CA+M3ks6R=n4n54wofK7pYcWoQKUhzyWQytBO90+pRDRrAhi3ww@mail.gmail.com>
 <20170313105433.GA12980@e106950-lin.cambridge.arm.com>
Message-ID: <20170313132150.324h7em7c3iowmwj@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13, 2017 at 10:54:33AM +0000, Brian Starkey wrote:
> On Sun, Mar 12, 2017 at 02:34:14PM +0100, Benjamin Gaignard wrote:

> > Another point is how can we put secure rules (like selinux policy) on
> > heaps since all the allocations
> > go to the same device (/dev/ion) ? For example, until now, in Android
> > we have to give the same
> > access rights to all the process that use ION.
> > It will become problem when we will add secure heaps because we won't
> > be able to distinguish secure
> > processes to standard ones or set specific policy per heaps.
> > Maybe I'm wrong here but I have never see selinux policy checking an
> > ioctl field but if that
> > exist it could be a solution.

> I might be thinking of a different type of "secure", but...

> Should the security of secure heaps be enforced by OS-level
> permissions? I don't know about other architectures, but at least on
> arm/arm64 this is enforced in hardware; it doesn't matter who has
> access to the ion heap, because only secure devices (or the CPU
> running a secure process) is physically able to access the memory
> backing the buffer.

> In fact, in the use-cases I know of, the process asking for the ion
> allocation is not a secure process, and so we wouldn't *want* to
> restrict the secure heap to be allocated from only by secure
> processes.

I think there's an orthogonal level of OS level security that can be
applied here - it's reasonable for it to want to say things like "only
processes that are supposed to be implementing functionality X should be
able to try to allocate memory set aside for that functionality".  This
mitigates against escallation attacks and so on, it's not really
directly related to secure memory as such though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170313/841d0bd3/attachment.sig>

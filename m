From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 May 2014 18:38:53 +0100
Subject: [PATCH] ARM: mm: Add workaround for erratum 763126
In-Reply-To: <CAD=FV=XeYdgqk3-CpS2NNXFAnn+uGDC6844d-L6vfS=SYEuw-Q@mail.gmail.com>
References: <1399528508-2806-1-git-send-email-arjun.kv@samsung.com>
 <CAD=FV=XeYdgqk3-CpS2NNXFAnn+uGDC6844d-L6vfS=SYEuw-Q@mail.gmail.com>
Message-ID: <20140508173853.GG8981@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On Thu, May 08, 2014 at 05:57:03PM +0100, Doug Anderson wrote:
> On Wed, May 7, 2014 at 10:55 PM, Arjun.K.V <arjun.kv@samsung.com> wrote:
> > From: "Arjun.K.V" <arjun.kv@samsung.com>
> >
> > Three processor exclusive access livelock.
> > In a system with three or more coherent masters that all use
> > the ldrex/strex synchronization primitives to access a semaphore
> > in coherent cacheable memory, there is a possibility of a
> > livelock condition where two masters continuously attempt
> > and fail to get the lock while the third master
> > continuously reads the lock.

Tentative NAK. You're paraphrasing the bug to make it sound worse than it
is -- whilst two of the cores need to be in a ldrex/strex loop, the third
needs to be issuing snoops from a normal load (to get the line into a shared
state). Please can you point me at the code in Linux which is triggering
this issue?

Cheers,

Will

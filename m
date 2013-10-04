From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Oct 2013 12:50:22 +0100
Subject: Use of drivers/platform and matching include?
In-Reply-To: <CAOesGMhBaj14++kJ9tVko68MjC7D+JZrBRgoxa4zmZ9z186MQw@mail.gmail.com>
References: <BC1C47B3-5412-4829-A1D9-AAB04694D1CC@codeaurora.org>
 <CAOesGMjJ6Uj0uGFJqtnWQyDW+tr6eLVWoHZ+B7uFna+L8N6E8Q@mail.gmail.com>
 <20131003170914.GA11992@kroah.com>
 <CAOesGMhBaj14++kJ9tVko68MjC7D+JZrBRgoxa4zmZ9z186MQw@mail.gmail.com>
Message-ID: <20131004115022.GN12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 10:54:07AM -0700, Olof Johansson wrote:
> It wouldn't be a huge deal to add something like arch/arm/syslib and
> give some of the system library-type code a home there -- stuff like
> resource allocation libraries, etc. I don't think we want to collect
> all the back-end drivers in there though, just libraries.

We don't need yet another subdirectory in arch/arm - yes, that's a
favourite way of avoiding any issues, but really it's not the right
answer.  We already have a place for shared cross-platform code, and
it's called arch/arm/common.

> I think many of us are hesitant to introduce something that runs the
> risk of becoming a dumping ground for all these "I don't know where to
> put them, so here you go" drivers, since we've spent so much time
> cleaning them all up and de-forking per-vendor implementations of
> similar things.

"Drivers go under drivers/" is what we've decided.  If we want to change
that, then we should move all those IRQ, gpio and clock drivers back out
of the drivers/ subtree, because many of them are SoC specific.

Please, think back to why we made the original decision(s) to move this
stuff out of arch/arm.

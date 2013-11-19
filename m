From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 19 Nov 2013 14:33:18 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <5289A356.4060004@jonmasters.org>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.
 com> <20131115095717.GC1709@e106331-lin.cambridge.arm.com> <5289A356.
 4060004@jonmasters.org>
Message-ID: <20131119143318.0FDB7C4079D@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Nov 2013 00:19:18 -0500, Jon Masters <jonathan@jonmasters.org> wrote:
> > I think that trying to shoe-horn ACPI-derived information into device
> > tree is fundamentally the wrong approach. I don't think it encourages
> > best practices, and I don't think it's beneficial to the long term
> > health of Linux or the ecosystem as a whole.
> 
> It's going to be a messy thing to even attempt. Look, I wish we had a
> time machine and could have done this whole thing years ago, but I'm not
> sure it would have gone differently. ACPI is something a lot of people
> emotionally hate. In the Enterprise space myself and others *need* it
> (along with UEFI) to have a scalable solution that doesn't result in an
> onslaught of customer support calls, which a non-standards body backed
> moving target of DTB will do.

I think that sells our entire community short. The Linux kernel itself is
nowhere near standards body backed, and the userspace ABI is absolutely
stable. It's stable because we've made stability a priority. Linus and
others have been vocal about it, and maintainers have enforced it.
Suggesting the lack of a standards body means we're left with a moving
target is clearly not true.

As much as we hoped ARM ACPI support would be complete by now and merged
into the kernel, it isn't. I really can't fault (or expect) any hardware
vendor to ship only ACPI when support for it isn't in mainline.

As for DT, we discussed DT stability at length in Edinburgh. We've made
the commitment to support shipped hardware. If hardware ships with a DT
that boots on mainline, then we will not break it.

> And besides all of the big boys are going
> to be using ACPI whether it's liked much or not.

I have to call that statement out as over the line. It comes across as
attempting to shame maintainers into accepting ACPI, and further implies
that non-ACPI users are not "big boys" and therefore just playing
around. That is not okay.

The ACPI support patches must satisfy maintainers before they will be
accepted. This is normal and we've done this before. The current patches
raise serious concerns, but they're also generating constructive
feedback. If ACPI isn't there in time then we can support the hardware
with DT, whether it is provided by the firmware (preferred), or shipped
with the kernel.

g.

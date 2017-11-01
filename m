From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Nov 2017 19:10:43 +0000
Subject: [PATCH] ARM: add a private asm/unaligned.h
In-Reply-To: <CAKv+Gu_tt0a3AXiWPN1PjGb8Ruo2dx60yDEV5h5kPQmHRgQp9A@mail.gmail.com>
References: <8737601u4d.fsf@free-electrons.com>
 <20171030163816.GA27404@n2100.armlinux.org.uk>
 <20171031124707.GD9463@n2100.armlinux.org.uk>
 <CAKv+Gu-te-Q+em36jM-dyouZuov_=xJaVY0Yr-3JCmJn6Zi4sg@mail.gmail.com>
 <87mv478na9.fsf@free-electrons.com>
 <CAKv+Gu9d2TUQHavs-rasKFcNmmwo22dwiGuD2+jBLqawbZAwuA@mail.gmail.com>
 <20171101180033.GP9463@n2100.armlinux.org.uk>
 <CAKv+Gu8F8PKSecjt2pze=9rd-TNDWs6n1+nV8GYyF+ZGunMiNQ@mail.gmail.com>
 <20171101181101.GQ9463@n2100.armlinux.org.uk>
 <CAKv+Gu_tt0a3AXiWPN1PjGb8Ruo2dx60yDEV5h5kPQmHRgQp9A@mail.gmail.com>
Message-ID: <20171101191043.GR9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 06:20:25PM +0000, Ard Biesheuvel wrote:
> On 1 November 2017 at 18:11, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > Have some patience and give your fellow developers some breathing space.
> >
> 
> Apologies if that sounded rude, but the first fix I proposed for
> Gregory's issue was sent on September 8th, i.e., almost two months
> ago.

I still do not agree that the patch you came up with on the 8th September
was reasonable.  It seemed to be a case of "oh, we have these extra
sections, let's get rid of them" and "let's align the piggy data".
There was no investigation _why_ and no justification for any of it
other than "it seems to fix a problem".

Sorry, that's way too vague, and hacky.

Having waited those two months, we now understand what is really going
on, why things have broken, and we have a completely different set of
fixes for it.  More importantly, we have the necessary understanding to
prevent a reoccurance in the future by detecting it.

Had your original patch on the 8th September been merged, we wouldn't
be in this position, and we wouldn't have this additional understanding.

So, IMHO the wait has been /well/ worth it.  Non-boot problems are
normally the hardest to solve, and it's always worth properly
understanding them rather than applying sticky plasters.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

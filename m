From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Aug 2013 19:37:08 +0100
Subject: Build breakage due to latest ARM fixes
In-Reply-To: <CAOesGMhNr5-6T9s8Y9jr2pWy=baceuZwGFNj2HtnqU9DbwPLvw@mail.gmail.com>
References: <CAOesGMgWeP-CdmOE-S7XZmJ-+1buP9a1cqavUns2gpgKrrhaxQ@mail.gmail.com>
 <20130803000731.GS23006@n2100.arm.linux.org.uk>
 <20130804125346.GH23006@n2100.arm.linux.org.uk>
 <CAOesGMhNr5-6T9s8Y9jr2pWy=baceuZwGFNj2HtnqU9DbwPLvw@mail.gmail.com>
Message-ID: <20130804183708.GI23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 04, 2013 at 11:20:21AM -0700, Olof Johansson wrote:
> On Sun, Aug 4, 2013 at 5:53 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sat, Aug 03, 2013 at 01:07:31AM +0100, Russell King - ARM Linux wrote:
> >> I'll look into that.  Obviously, I never build nommu because it isn't
> >> part of the build system and the nommu platform I do have - OKI67001 -
> >> doesn't have mainline kernel support.  (And if it did, it would not be
> >> DT, so I doubt it's submittable.)
> >
> > Okay, what I'm going to do is push the OKI67001 stuff into mainline
> > irrespective of DT or not, so that I can then add noMMU build _and_
> > boot tests to my build system, which should ensure that problems
> > like that get detected before they're pushed upstream.
> 
> That seems like a step backwards. How have !MMU changes been handled
> until now? Someone external has been relied on for testing?

No, they've had no testing as far as I'm aware.  noMMU never got to the
stage when it was merged that it had any platforms before Hiyok went
silent.

The only real testing I'm aware of is when I recreated the OKI67001
support a while back and got my board to boot.

As for qemu, software emulations while nice and convenient don't
accurately reflect real hardware.

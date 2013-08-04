From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Aug 2013 13:53:46 +0100
Subject: Build breakage due to latest ARM fixes
In-Reply-To: <20130803000731.GS23006@n2100.arm.linux.org.uk>
References: <CAOesGMgWeP-CdmOE-S7XZmJ-+1buP9a1cqavUns2gpgKrrhaxQ@mail.gmail.com>
 <20130803000731.GS23006@n2100.arm.linux.org.uk>
Message-ID: <20130804125346.GH23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 03, 2013 at 01:07:31AM +0100, Russell King - ARM Linux wrote:
> I'll look into that.  Obviously, I never build nommu because it isn't
> part of the build system and the nommu platform I do have - OKI67001 -
> doesn't have mainline kernel support.  (And if it did, it would not be
> DT, so I doubt it's submittable.)

Okay, what I'm going to do is push the OKI67001 stuff into mainline
irrespective of DT or not, so that I can then add noMMU build _and_
boot tests to my build system, which should ensure that problems
like that get detected before they're pushed upstream.

If people want me to care about noMMU, that's what has to happen
because I have no other noMMU platform - if not, people can put up with
noMMU breaking from time to time.

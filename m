From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 9 Oct 2014 15:44:41 +0100
Subject: [PATCH v1] Arm64: ASLR: fix text randomization
In-Reply-To: <20141008112154.GF26140@arm.com>
References: <1412685628-27178-1-git-send-email-achandran@mvista.com>
 <20141007134349.GR24725@leverpostej>
 <CAFdej01hex6aeNNjdA1uDodEQ-d=JhsoqFJHkPvnKY+xbzZmxw@mail.gmail.com>
 <20141008112154.GF26140@arm.com>
Message-ID: <20141009144441.GA18384@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 12:21:55PM +0100, Will Deacon wrote:
> On Wed, Oct 08, 2014 at 07:51:54AM +0100, Arun Chandran wrote:
> > On Tue, Oct 7, 2014 at 7:13 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > > I wasn't able to spot where the randomness came from in the
> > > ARCH_BINFMT_ELF_RANDOMIZE_PIE case, so it's not clear to me if the
> > > generic implementation behaves identically other than disabling
> > > randomization when told to via proc.
> > 
> > I also don't know from where it is coming; but it works on arm and x86 :)
> 
> The randomness will come from elf_map, since that will descend into the mmap
> code and end up with a randomised base address (see mmap_base and
> arch_pick_mmap_layout).

Given that, it sounds like the existing randomize_et_dyn is redundant?

If so, the patch looks sane to me.

Mark.

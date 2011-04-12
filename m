From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Apr 2011 21:47:14 +0100
Subject: A15 h/w virtulization support
In-Reply-To: <BANLkTi=cOmWQuPY_aG5T6JoOAYCXshdyPg@mail.gmail.com>
References: <BANLkTi=cOmWQuPY_aG5T6JoOAYCXshdyPg@mail.gmail.com>
Message-ID: <20110412204714.GD7806@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 12:16:10PM +0530, Subash Patel wrote:
> If I am not wrong, Cortex-A15 is WIP with many SoC vendors. From my
> understanding, A15 has additional operational mode "hypervisor mode"
> and SMMU support for GuestOS memory to IPA in VMM, and IPA in VMM into
> PA. I was curious to know whether ARM v7 changes for Linux
> is happening for this? This will help to understand the KVM changes
> that may be required to run Linux directly in ring-0, and support
> guest OS?

Currently, I am planning no work on merging virtualization support.

Linus complained during the last merge window about the size of the
arch/arm sub-tree, and we - as the *entire* ARM community - really
need to address this issue right now.

Therefore, I will be taking no patches which aren't bug fixes or
consolidation patches for code which already lives in the kernel.

I am presently not convinced that many people are taking this issue
seriously enough, believing that "someone else will sort it out for
me."  This isn't going to happen.  If that's what many people are
doing, then I believe that we'll see ARM being removed from mainline
kernels.

Longer term, folk need to open their minds and look through code
which is already present to see whether code which one SoC already
implements can be re-used for their SoC, and actually sort out
re-using that code rather than submitting their own thing.

I believe that we are far too large in mainline to allow anything new
in.

If you're wondering "why doesn't X do that work" the answer is that
there have already been efforts to consolidate things, but because of
the sheer amount of new ARM specific code flowing into the kernel,
these consolidations completely disappear into the noise.  We need an
army of people working on this.

So, at the moment, virtualization support for ARM in mainline kernels
is completely out of the question.

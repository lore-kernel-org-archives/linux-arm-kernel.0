From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Jun 2014 10:46:48 +0100
Subject: [PATCH v7 0/9] ARM: VDSO
In-Reply-To: <CAKv+Gu9NfGT8r8FSYzsuP70r1BRD_pdJw7AZHkc4qLt2_SwanA@mail.gmail.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <20140627085125.GA7088@hal> <20140627085705.GC32514@n2100.arm.linux.org.uk>
 <CAKv+Gu9NfGT8r8FSYzsuP70r1BRD_pdJw7AZHkc4qLt2_SwanA@mail.gmail.com>
Message-ID: <20140627094648.GE32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 11:41:46AM +0200, Ard Biesheuvel wrote:
> It appears that the EF_ARM_ABI_FLOAT_[SOFT|HARD] defines are just renames of
> 
> #define EF_ARM_SOFT_FLOAT       0x200
> #define EF_ARM_VFP_FLOAT        0x400
> 
> so perhaps use those instead?

Or maybe provide our own definitions so we're not reliant on the host
environment providing the correct definitions for these.

> > This is what really concerns me about the VDSO.  It adds an additional
> > dependence on the C library in order to build the kernel.  What if you
> > don't have a C library in your cross-build setup (I don't.)
> >
> 
> This is a host tool, so this is about the host libc not the target libc.

It still sounds pretty fragile.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

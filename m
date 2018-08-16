From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Aug 2018 10:14:54 +0100
Subject: [GIT PULL] arm64: updates for 4.19
In-Reply-To: <CALAqxLVeSHp+D=9t0f7ve7YgSzqVNTkVVzv-8tdQkJARJ8Bo8Q@mail.gmail.com>
References: <20180814113633.GE28664@arm.com>
 <CALAqxLVeSHp+D=9t0f7ve7YgSzqVNTkVVzv-8tdQkJARJ8Bo8Q@mail.gmail.com>
Message-ID: <20180816091454.GA31093@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On Wed, Aug 15, 2018 at 04:55:15PM -0700, John Stultz wrote:
> On Tue, Aug 14, 2018 at 4:36 AM, Will Deacon <will.deacon@arm.com> wrote:
> >
> > Please pull these arm64 updates for 4.19. Details in the tag, but please be
> > aware that we've pulled in the x86/mm branch from -tip so that we can make
> > use of the core ioremap changes which allow us to put down huge mappings
> > in the vmalloc area without screwing up the TLB. Much of the positive
> > diffstat is because of the rseq selftest for arm64.
> >
> > There is a trivial conflict in arch/arm64/Makefile with your tree, since
> > we effectively rewrote a fix that was merged in -rc5 [96f95a17c1cf]. The
> > correct resolution is therefore to prefer the code using ld-option, which
> > is what we have here. We also ran into a couple of trivial conflicts that
> > were resolved in -next with the KVM and EFI trees.
> >
> 
> Hey Will,
>   So I noticed issues booting Linus' master on the HiKey960 board I
> have today (something hangs early in boot before I get any serial
> output), and isolated the issue down to your branch here.
> 
> It seems to be coming from 693350a79980 ("arm64: insn: Don't fallback
> on nosync path for general insn patching"), and reverting that change
> resolves the issue for me.
> 
> If you have any suggestions for alternative fixes or things to try,
> please let me know.

Hmm, sorry about that. It's also just been reported on linux-arm-kernel[1], and
they have a backtrace, so I'll take a look today.

Cheers,

Will

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/596961.html

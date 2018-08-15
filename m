From: john.stultz@linaro.org (John Stultz)
Date: Wed, 15 Aug 2018 16:55:15 -0700
Subject: [GIT PULL] arm64: updates for 4.19
In-Reply-To: <20180814113633.GE28664@arm.com>
References: <20180814113633.GE28664@arm.com>
Message-ID: <CALAqxLVeSHp+D=9t0f7ve7YgSzqVNTkVVzv-8tdQkJARJ8Bo8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2018 at 4:36 AM, Will Deacon <will.deacon@arm.com> wrote:
>
> Please pull these arm64 updates for 4.19. Details in the tag, but please be
> aware that we've pulled in the x86/mm branch from -tip so that we can make
> use of the core ioremap changes which allow us to put down huge mappings
> in the vmalloc area without screwing up the TLB. Much of the positive
> diffstat is because of the rseq selftest for arm64.
>
> There is a trivial conflict in arch/arm64/Makefile with your tree, since
> we effectively rewrote a fix that was merged in -rc5 [96f95a17c1cf]. The
> correct resolution is therefore to prefer the code using ld-option, which
> is what we have here. We also ran into a couple of trivial conflicts that
> were resolved in -next with the KVM and EFI trees.
>

Hey Will,
  So I noticed issues booting Linus' master on the HiKey960 board I
have today (something hangs early in boot before I get any serial
output), and isolated the issue down to your branch here.

It seems to be coming from 693350a79980 ("arm64: insn: Don't fallback
on nosync path for general insn patching"), and reverting that change
resolves the issue for me.

If you have any suggestions for alternative fixes or things to try,
please let me know.

thanks
-john

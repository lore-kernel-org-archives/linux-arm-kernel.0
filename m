From: martinwguy@gmail.com (Martin Guy)
Date: Fri, 15 Apr 2011 16:30:50 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110414094447.GA1611@n2100.arm.linux.org.uk>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikr-J0HSW74dPvGfuJe6GdCBs151w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 April 2011 11:44, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> This morning, I looked at linux-next to find out how arch/arm is doing
> for the next merge window.
>
> $ git diff -C --cumulative v2.6.39-rc1... arch
> ?19.7% arch/arm/mach-imx/
> ?19.2% arch/arm/mach-mx3/
> ? 3.4% arch/arm/mach-mxc91231/
> ?18.1% arch/arm/mach-ux500/
> ?74.1% arch/arm/
> ? 3.2% arch/m68k/
> ? 4.0% arch/mips/lantiq/
> ? 6.9% arch/mips/
> ? 3.1% arch/x86/kvm/
> ? 7.6% arch/x86/
> ?100.0% arch/

One reason for high ARM activity is that the arm port has far more
different supported computers and drivers for more different hardware
than any other processor, so more activity in the arm tree than any
other is unlikely to go away unless we stop developing for ARM
platforms.

Another is that most of this is recently-produced hardware, so there
are a lot new drivers to develop.

Lastly, ARM platforms are common and tend to be cheap, so they are the
boards that young, enthusiastic developers are likely to have in front
of them and, since it covers many many machines, they are more likely
to find places where suoport is lacking or can be improved.

Counting the arch-specific C files:
for a in arch/* ; do echo -n "$a    "; find $a -name '*.[ch]' | wc -l;
done | sort -nrk 2
arch/arm	3040
arch/mips	1206
arch/powerpc	1018
arch/x86	762
arch/sh	591
arch/sparc	454
...

That's a total of 30% of the files out of the 10000 files under 25 architecture.
I don't think this "problem" is likely to go away.  At best, we can
try to limit the number of "remove trailing spaces from lines" type of
patches.

   M

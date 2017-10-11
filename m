From: james.morse@arm.com (James Morse)
Date: Wed, 11 Oct 2017 16:34:45 +0100
Subject: [PATCH 1/3] arm: vdso: Rewrite gettimeofday to more closely match
 arm64 variant
In-Reply-To: <20170911161827.112786-1-salyzyn@android.com>
References: <20170911161827.112786-1-salyzyn@android.com>
Message-ID: <59DE3A15.90800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/09/17 17:18, Mark Salyzyn wrote:
> Take an effort to recode the arm64 vdso code from assembler to C
> previously submitted by Andrew Pinski <apinski@cavium.com>, rework
> it for use in both arm and arm64, overlapping any optimizations
> for each architecture.
> 
> Side effects include renaming some vdso_datapage.h variables, adding
> a few more to enhance features and functionality to match.

There are quite a lot of different things going on here, all of which are
interleaved in this patch. Could you split them out into smaller simpler changes?

The bits I count are:
* Pulling 32bit specific eabi and fallback macro out into compiler.h,
* Adding support for __vdso_clock_getres,
* Flipping tk_is_cntvct's logic to become use_syscall,
* Variable renames to align 32/64 bit,

...are those 'coarse' versions of the timer calls being added, or just moved around?


Thanks,

James

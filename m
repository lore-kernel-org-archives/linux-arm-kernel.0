From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Dec 2011 22:24:28 +0000
Subject: [GIT PULL v2] Linux support for ARM LPAE
In-Reply-To: <20111206203416.GV14542@n2100.arm.linux.org.uk>
References: <20111206152955.GC31720@arm.com>
 <20111206203416.GV14542@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk6ATr1thCL+-Cb4bOiObVmXrcoqvBiEBVzss_dATjt1VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 December 2011 20:34, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 06, 2011 at 03:29:55PM +0000, Catalin Marinas wrote:
>> I updated the series with an additional signed-off-by to your patch. The
>> code is unchanged. Could you please pull it again?
>
> I will for this time only, but note - last time you said:
>
>> If there are no further comments, could you please pull the ARM LPAE
>> branch below? They should be merged after Will's idmap patches (no real
>> conflict, just correctly functioning setup_mm_for_reboot).
>
> Now, the thing is, merging it after Will's patches won't solve that in
> any shape or form - it really does not matter what order I do the merges
> in, the fact of the matter is that there is no ordering or dependence
> between your patches and Will's, so there's no guarantee that your code
> will see a properly functioning setup_mm_for_reboot.

This situation is not unique to my LPAE patches (git bisect doesn't
always go well merges). There are many other situations where one
relies on some stuff to get into mainline (or maintainer tree) before
merging. Just have a look at the kernel logs.

But if you want, there other solutions:

1. I can rebase the LPAE branch on top of your devel-stable _after_
you merged Will's patches. Then I send another pull request.

2. Only merge the LPAE patches without the one adding the Kconfig
option. Later apply the Kconfig patch.

> If you actually depend on something in some other tree, you need to have
> it merged into your tree _before_ the objects which depend on it.

Not easy in this instance. AFAIK Will's code relied on some reset
patches from you, so Will just used your devel-stable branch.

> As I said, I will merge it this time around, but next time I won't.

As I also said above, there are solutions. What it is really needed is
_better_ collaboration during merges and _discussing_ the best
approach rather than threatening that there won't be other pulls. I'm
open to rebase my branch against other commits, just say it. I doubt
this is the only time where merge issues occured.

-- 
Catalin

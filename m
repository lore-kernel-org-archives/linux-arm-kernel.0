From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Nov 2012 19:35:08 +0100
Subject: [PATCH 2/4] gpio: samsung: Skip registration if pinctrl driver is
 present on Exynos4x12
In-Reply-To: <0e8301cdbe62$56a1d010$03e57030$%kim@samsung.com>
References: <1351089457-8205-1-git-send-email-t.figa@samsung.com>
 <1351089457-8205-3-git-send-email-t.figa@samsung.com>
 <CACRpkdYNDSp0K3wpvUem9ecsW-JQ9L6aKqaOmHNUR65DQTMNHA@mail.gmail.com>
 <0c5301cdbca2$30320240$909606c0$%kim@samsung.com>
 <CACRpkdaOpzFvs_wqy9sdrmx1=wEs5uxqfh_rOrKxLTXV-q1K2Q@mail.gmail.com>
 <0e8301cdbe62$56a1d010$03e57030$%kim@samsung.com>
Message-ID: <CACRpkdZGu2VfP-EzAOxK3947x6Pd78bh=TWDK98iXwkJx2WiTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 9, 2012 at 11:09 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> On Wed, Nov 7, 2012 at 5:41 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>>
>> > A commit 1b6056d6 ("pinctrl: samsung: Include bank-specific eint offset
>> in
>> > bank struct") which is in your pinctrl tree (samsung branch) changed
>> > macro(EXYNOS_PIN_BANK_EINTG) to add offset. Eventually, this series(due
>> to
>> > 3rd patch, pinctrl: samsung: Add support for Exynos4x12) breaks
>> compilation
>> > without the commit. So if you don't have a plan to rebase samsung branch
>> of
>> > your pinctrl tree, I'd like to merge it in my tree. Is it ok to you?
>>
>> Sure tell me when you've merged it and I'll drop commit 1b6056d6
>> from my tree.
>>
>
> Thanks :-)
>
> (- some guys in Cc...)
>
> But having a problem, the 'it' means the commit 1b6056d6? If so, I couldn't
> cherry-pick only that because of dependency with other commits 40ba622 and
> 3a232ba.
>
> $ git cherry-pick -s 40ba622
> [next/dt-exynos4x12 3b1977c] pinctrl: samsung: Assing pin numbers
> dynamically
>  Author: Tomasz Figa <t.figa@samsung.com>
>  3 files changed, 62 insertions(+), 54 deletions(-)
>
> $ git cherry-pick -s 3a232ba
> [next/dt-exynos4x12 7fa08a4] pinctrl: samsung: Remove static pin
> enumerations
>  Author: Tomasz Figa <t.figa@samsung.com>
>  1 files changed, 96 insertions(+), 215 deletions(-)
>  rewrite drivers/pinctrl/pinctrl-exynos.h (66%)
>
> $ git cherry-pick -s 1b6056d
> [next/dt-exynos4x12 86010aa] pinctrl: samsung: Include bank-specific eint
> offset in bank struct
>  Author: Tomasz Figa <t.figa@samsung.com>
>  3 files changed, 30 insertions(+), 29 deletions(-)
>
> I could cherry-pick clearly with 2 more commits.
>
> Can you drop above 3 commits in your tree? If many conflicts happens during
> rebasing, how about that I merge your pinctrl/samsung branch into Samsung
> tree?...

Why not :-)

I have removed the samsung branch from my for-next to avoid
clashes.

So please bring the samsung branch into you tree and fix
everything up there.

Axel Lin has sent some tree-wide cleanups but let's hope they don't
hit samsung so much, or they will need to be postponed/dropped.

Yours,
Linus Walleij

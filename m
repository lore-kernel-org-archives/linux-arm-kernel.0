From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2011 09:20:43 +0200
Subject: [PATCH 0/6] spi/spi-pl022 fixes
In-Reply-To: <4E420144.4010001@st.com>
References: <cover.1312887860.git.viresh.kumar@st.com>
	<CACRpkdatTqnSMxKzhYo=EYpP21buN0tosx1Y1aVc7RLe58wfgg@mail.gmail.com>
	<4E420144.4010001@st.com>
Message-ID: <CAKnu2MoTQTYMa4JvWyr7sPMhPyziTtnLeZLySUYxcuQC2Vu-6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/10 viresh kumar <viresh.kumar@st.com>:
> On 08/10/2011 01:40 AM, Linus Walleij wrote:
>>
>> They all work perfectly well on top of v3.1-rc1, please use
>> mainline kernel tags as patch base if you can.
>
> Sure, can take care of this. But i have a doubt here,
> What if a patch on the same driver is applied after kernel tag.
> Shouldn't i rebase my patches on the latest commit available.

The basic assumption is that patches are orthogonal and apply
without conflicts, i.e. patch different parts of the kernel tree or
different lines in the same file.

Second assumption is that if patches do collide, the subsystem
maintainer can solve most conflicts, and is expected to do
so. Torvalds sets an example by requesting that subsystem
maintainers do not fixup conflicts between subsystems so he
can see them himself.

Then there are special cases when you get a strong
coupling between patches.

In these special cases, ask the subsystem maintainer what to
base the patches on. Usually it's some commit on the subsystem
tree rather than -next.

This is my understanding of how we work, maybe I should
patch Documentation/development-process/*, Arnd do you have
anything to add?

Thanks,
Linus Walleij

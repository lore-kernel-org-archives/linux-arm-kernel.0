From: olof@lixom.net (Olof Johansson)
Date: Sat, 19 Nov 2016 09:07:16 -0800
Subject: [GIT PULL] Allwinner late DT changes for 4.10
In-Reply-To: <CACRpkdbw3AUj510wPGFG55cKnOyEOX7Syz1BnJx-ygo1eAqzGg@mail.gmail.com>
References: <20161115210034.mwqnsggmmbzoav77@lukather>
 <20161119002733.GA15902@localhost>
 <CACRpkdbw3AUj510wPGFG55cKnOyEOX7Syz1BnJx-ygo1eAqzGg@mail.gmail.com>
Message-ID: <CAOesGMh_UXBQGtxbLHT7ABfp+V5xSJCjvj=N4vwRLuKFaujZ2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 19, 2016 at 7:28 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Nov 19, 2016 at 1:27 AM, Olof Johansson <olof@lixom.net> wrote:
>
>> Also, this won't work since this branch does not contain the required
>> pinctrl changes. If we merge this without basing it on those changes we lose
>> bisectability.
>
> I usually operate on the assumption that arch/*/boot/dts/* and drivers/*
> do not need to be boot-time bisectable sync:ed, because of the ambition
> to maintaining DTS files outside of the kernel in the long run, and at that
> point they would be versioned orthogonally anyways.
>
> On the other hand, that does look like a pipe dream, so maybe I should
> just stop pretending.

For new features/drivers/platforms that is definitely the case: Merge
code through the suitable tree and it'll come together when the code
is all merged.

For a cleanup it's a bit different, since you shouldn't regress and
break existing support on the individual branches. I.e. it's OK to not
make things work for the first time until all comes together, but
things that is already working shouldn't break.


-Olof

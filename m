From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 4 Apr 2017 11:57:51 +0200
Subject: [GIT PULL] mfd: exynos-lpass: Pinctrl dependency
In-Reply-To: <20170404095054.7m6nf6bxweskabuu@dell>
References: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
 <20170328154217.5405-1-krzk@kernel.org>
 <20170403101824.rpvkqzyigonyi77p@dell>
 <CAJKOXPeVOMBZxXeh7=oXbgnxSrUtHa86eAtP2BppY=G4Uygarg@mail.gmail.com>
 <20170404095054.7m6nf6bxweskabuu@dell>
Message-ID: <20170404095751.GA28977@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 10:50:54AM +0100, Lee Jones wrote:
> On Tue, 04 Apr 2017, Krzysztof Kozlowski wrote:
> 
> > On Mon, Apr 3, 2017 at 12:18 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > > On Tue, 28 Mar 2017, Krzysztof Kozlowski wrote:
> > >
> > >>
> > >> Hi Lee,
> > >>
> > >>
> > >> This is dependency for mfd/exynos-lpass driver changes from Marek Szyprowski.
> > >> That's a material for v4.12 and I will be pushing this later to Linus Walleij.
> > >
> > > This does not work, and *may* still break.
> > >
> > > The only way to guarantee the order of the patches is to have them
> > > *all* as part of the pull-request.  Not just some of them.
> > 
> > What do you mean exactly? If these two patches come through my tree
> > first, then everything will work fine because they do not break any
> > other stuff.
> > 
> > If you pull it and apply the rest on top, then it should also work
> > without problems because your history will contain everything needed
> > in proper order.
> > 
> > In both cases bisectability is preserved. Did I missed something?
> 
> Okay, so you're suggesting that I rebase MFD *on-top* of your PR.  That
> does work for me because I insist on being able to re-work my tree at
> any time.  However, be aware that some Maintainers do not work this
> way, thus *normally* you will have to send PR containing all of the
> dependant patches.

You could either rebased on top of this PR or merge it before applying
rest of patches. It does not matter because in both cases all dependant
patches will be after the dependency. Also in both cases you will be
sending them in your PR.

You can then rebase your stuff as well, keeping only the external
commits untouced and merged.

Really, that does not differ from all your stable immutable branches you
have been providing for other folks.


Best regards,
Krzysztof

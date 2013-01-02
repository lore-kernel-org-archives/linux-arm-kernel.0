From: olof@lixom.net (Olof Johansson)
Date: Wed, 2 Jan 2013 11:33:22 -0800
Subject: [PATCH v5 00/12] clk: exynos4: migrate to common clock framework
In-Reply-To: <CAJuYYwTbdEDkt41FsJUOt3wq7rq9XHDhMari56GG5T8S1dF7=A@mail.gmail.com>
References: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
 <20121230052953.GB20903@quad.lixom.net>
 <CAJuYYwTbdEDkt41FsJUOt3wq7rq9XHDhMari56GG5T8S1dF7=A@mail.gmail.com>
Message-ID: <20130102193322.GA6583@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 30, 2012 at 09:35:16PM -0800, Thomas Abraham wrote:
> On 29 December 2012 21:29, Olof Johansson <olof@lixom.net> wrote:
> > On Sat, Dec 29, 2012 at 04:33:29PM -0800, Thomas Abraham wrote:
> >> Changes since v4:
> >> - Rebased to linux-3.8-rc1.
> >>
> >> Changes since v3:
> >> - Includes changes suggested by Tomasz Figa <tomasz.figa@gmail.com>
> >>
> >> This patch series migrates the Samsung Exynos4 SoC clock code to adopt the
> >> common clock framework. The use of Samsung specific clock structures has
> >> been removed and all board support code has been updated. imx-style of
> >> clock registration and lookup has been adopted for device tree based
> >> exynos4 platforms.
> >
> > I'd prefer to see if exynos4 and 5 were kept common here, and both transitioned
> > at the same time. Especially since there are no legacy boards for exynos5, it
> > would mean you could have a very clean transition there. What's the plan to
> > follow up with 5?
> 
> Ok. I have been looking into Exynos4 since Mr. Kim was already onto
> Exynos5 common clock. Sure, we could do a cleaner Exynos4/5 common
> clock series for v3.9. That would let both exynos4/5 to be built
> together which otherwise this patch series would not allow.

Great, that sounds good. Regressing exynos 4+5 builds would definitely be a bad
thing. In other words, it makes sense to hold off merging the exynos4 pieces
until the 5 counterparts are ready.

> > What are the plans to remove legacy board files on exynos4 at this time
> > and switch them to DT-only? You could do it gradually like Stephen Warren
> > did on Tegra, with hooks that call out to some of the legacy code, but
> > configure the board through device tree and do away with the classic
> > machine descriptors, etc.
> 
> I did try this sometime back for exynos4210 based origen board. But
> did not make much progress since certain portions require the older
> samsung gpiolib support and exynos4210 mainline device tree support
> has migrated to newer pinctrl framework. There is some work here to do
> and I will work with Mr. Kim on this.

Great, thanks.


-Olof

From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 30 Sep 2010 13:43:53 +0200
Subject: [PATCH 7/7] ARM: S5PC210: I2C{3, 4, 5, 6, 7} device support
In-Reply-To: <AANLkTik9Q7e=nzOmKsxEBeeJn-5JcQpKJfTSfGqLB21G@mail.gmail.com>
References: <20100930044859.GA16923@july>
	<000b01cb6067$99850240$cc8f06c0$%seo@samsung.com>
	<AANLkTinC9U3mehOVGWSM26TjMVyx9o6fBgLrXUKQmOcb@mail.gmail.com>
	<AANLkTik9Q7e=nzOmKsxEBeeJn-5JcQpKJfTSfGqLB21G@mail.gmail.com>
Message-ID: <00e201cb6094$c52391a0$4f6ab4e0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, September 30, 2010 8:50 AM Jassi Brar wrote:

> On Thu, Sep 30, 2010 at 3:27 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> > On Thu, Sep 30, 2010 at 3:20 PM, Jeongbae Seo <jeongbae.seo@samsung.com> wrote:
> >> Kyungmin wrote:
> >>> From: Kyungmin Park <kyungmin.park@samsung.com>
> >>>
> >>> S5PC210 support more I2C devices than previous SoCs.
> >>> And to prevent the wrong usage use the s5p prefix instead of s3c.
> >>>
> >>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >>> ---
> >>>  arch/arm/mach-s5pv310/Kconfig            |   15 +++++++
> >>>  arch/arm/mach-s5pv310/Makefile           |    5 ++
> >>>  arch/arm/mach-s5pv310/setup-i2c3.c       |   25 +++++++++++
> >>>  arch/arm/mach-s5pv310/setup-i2c4.c       |   25 +++++++++++
> >>>  arch/arm/mach-s5pv310/setup-i2c5.c       |   25 +++++++++++
> >>>  arch/arm/mach-s5pv310/setup-i2c6.c       |   25 +++++++++++
> >>>  arch/arm/mach-s5pv310/setup-i2c7.c       |   25 +++++++++++
> >>>  arch/arm/plat-s5p/Kconfig                |   25 +++++++++++
> >>>  arch/arm/plat-s5p/Makefile               |    5 ++
> >>>  arch/arm/plat-s5p/dev-i2c3.c             |   67
> >>> ++++++++++++++++++++++++++++++
> >>>  arch/arm/plat-s5p/dev-i2c4.c             |   67
> >>> ++++++++++++++++++++++++++++++
> >>>  arch/arm/plat-s5p/dev-i2c5.c             |   67
> >>> ++++++++++++++++++++++++++++++
> >>>  arch/arm/plat-s5p/dev-i2c6.c             |   67
> >>> ++++++++++++++++++++++++++++++
> >>>  arch/arm/plat-s5p/dev-i2c7.c             |   67
> >>> ++++++++++++++++++++++++++++++
> >>>  arch/arm/plat-samsung/include/plat/iic.h |    5 ++
> >>>  15 files changed, 515 insertions(+), 0 deletions(-)
> >>>  create mode 100644 arch/arm/mach-s5pv310/setup-i2c3.c
> >>>  create mode 100644 arch/arm/mach-s5pv310/setup-i2c4.c
> >>>  create mode 100644 arch/arm/mach-s5pv310/setup-i2c5.c
> >>>  create mode 100644 arch/arm/mach-s5pv310/setup-i2c6.c
> >>>  create mode 100644 arch/arm/mach-s5pv310/setup-i2c7.c
> >>>  create mode 100644 arch/arm/plat-s5p/dev-i2c3.c
> >>>  create mode 100644 arch/arm/plat-s5p/dev-i2c4.c
> >>>  create mode 100644 arch/arm/plat-s5p/dev-i2c5.c
> >>>  create mode 100644 arch/arm/plat-s5p/dev-i2c6.c
> >>>  create mode 100644 arch/arm/plat-s5p/dev-i2c7.c
> >>>
> >>
> >> Hi Kyungmin,
> >>
> >> We are considering another way not to make additional new i2c dev files.
> >> In my opinion, this patch looks not bad but we'd better make an effort to
> >> avoid having the more similar file.
> >
> > Actually I also it's not good approach, but as there's no comment or
> > discuss about this I send the patches.
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2010-August/022615.html
> >
> > If you have good method or approaches, I'm welcome.
> 
> First, these are device definitions and gpio set callbacks and
> shouldn't take much
> of space. So, perhaps these all could be built upon single I2C support
> selection.
> 
> Second, if we must build them conditionally, how about having all in
> one file with
> each device's definition and callback surrounded by corresponding ifdef ?
> That would alteast save us file-count.

I don't think this is a good idea. IMHO we should now follow the current style
of defining platform devices and the convert all at once. Mixing style always
causes a lot of confusion.

We should however agree on the new way of creating devices asap, as everyone
can notice that the current style is not the best for advanced socs like
C210/V310. This would save the time later when we would need to merge patches
for different styles of devices.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center

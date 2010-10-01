From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 01 Oct 2010 07:28:54 +0200
Subject: [PATCH 7/7] ARM: S5PC210: I2C{3, 4, 5, 6, 7} device support
In-Reply-To: <AANLkTikvsxXF+iXcfzLoMM+_2pr5zd1sYvhu1EVoBh+f@mail.gmail.com>
References: <20100930044859.GA16923@july>
	<000b01cb6067$99850240$cc8f06c0$%seo@samsung.com>
	<AANLkTinC9U3mehOVGWSM26TjMVyx9o6fBgLrXUKQmOcb@mail.gmail.com>
	<AANLkTik9Q7e=nzOmKsxEBeeJn-5JcQpKJfTSfGqLB21G@mail.gmail.com>
	<00e201cb6094$c52391a0$4f6ab4e0$%szyprowski@samsung.com>
	<AANLkTikvsxXF+iXcfzLoMM+_2pr5zd1sYvhu1EVoBh+f@mail.gmail.com>
Message-ID: <00ed01cb6129$8d1e2eb0$a75a8c10$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, October 01, 2010 1:52 AM Jassi Brar wrote:

> On Thu, Sep 30, 2010 at 8:43 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> >> >> We are considering another way not to make additional new i2c dev files.
> >> >> In my opinion, this patch looks not bad but we'd better make an effort to
> >> >> avoid having the more similar file.
> >> >
> >> > Actually I also it's not good approach, but as there's no comment or
> >> > discuss about this I send the patches.
> >> > http://lists.infradead.org/pipermail/linux-arm-kernel/2010-August/022615.html
> >> >
> >> > If you have good method or approaches, I'm welcome.
> >>
> >> First, these are device definitions and gpio set callbacks and
> >> shouldn't take much
> >> of space. So, perhaps these all could be built upon single I2C support
> >> selection.
> >>
> >> Second, if we must build them conditionally, how about having all in
> >> one file with
> >> each device's definition and callback surrounded by corresponding ifdef ?
> >> That would alteast save us file-count.
> >
> > I don't think this is a good idea. IMHO we should now follow the current style
> > of defining platform devices and the convert all at once. Mixing style always
> > causes a lot of confusion.
>
> You mean to keep defining every controller in in a dedicated file ?

Yes, what's the problem with many files? The i2c patches are ready, they match the
way the other Samsung devices are defined in mainline kernel. It imho really important
to have a common style across the same chip family to make the code easier to understand
for someone new.

> If yes, my second option is still better, IMO.
> If no, please explain what do you mean by current style.

Well, postponing a merge of such simple code as i2c device definition is imho the
worst solution. Especially because the new style / framework still has not been agreed
yet, although a few proposals have been made a long time ago.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center

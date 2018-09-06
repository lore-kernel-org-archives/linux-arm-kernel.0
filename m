From: ndesaulniers@google.com (Nick Desaulniers)
Date: Thu, 6 Sep 2018 09:39:51 -0700
Subject: [PATCH v6 00/18] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <CAAeHK+wStsNwh2oKv-KCG4kx5538FuDMQ6Yw2X=sK5LPrw2DZg@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com>
 <20180905141032.b1ddaab53d1b2b3bada95415@linux-foundation.org>
 <20180906100543.GI3592@arm.com>
 <CAAeHK+wStsNwh2oKv-KCG4kx5538FuDMQ6Yw2X=sK5LPrw2DZg@mail.gmail.com>
Message-ID: <CAKwvOdk=F=kja-ZznrifTO8EASmPF0CoTPWbFxpMqLk-_KGEEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 6, 2018 at 4:06 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Thu, Sep 6, 2018 at 12:05 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Sep 05, 2018 at 02:10:32PM -0700, Andrew Morton wrote:
> >> On Wed, 29 Aug 2018 13:35:04 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
> >>
> >> > This patchset adds a new mode to KASAN [1], which is called KHWASAN
> >> > (Kernel HardWare assisted Address SANitizer).
> >>
> >> We're at v6 and there are no reviewed-by's or acked-by's to be seen.
> >> Is that a fair commentary on what has been happening, or have people
> >> been remiss in sending and gathering such things?
> >
> > I still have concerns about the consequences of merging this as anything
> > other than a debug option [1]. Unfortunately, merging it as a debug option
> > defeats the whole point, so I think we need to spend more effort on developing
> > tools that can help us to find and fix the subtle bugs which will arise from
> > enabling tagged pointers in the kernel.
>
> I totally don't mind calling it a debug option. Do I need to somehow
> specify it somewhere?
>
> Why does it defeat the point? The point is to ease KASAN-like testing
> on devices with limited memory.

I don't disagree with using it strictly for debug.  When I say I want
the series for Pixel phones, I should have been clearer that my intent
is for a limited pool of internal testers to walk around with KHWASAN
enabled devices; not general end users.  It's hard enough today to get
anyone to test KASAN/ASAN on their "daily driver" due to the memory
usage and resulting performance.

We don't ship KASAN or KUBSAN on by default to end users (nor plan
to); it's used strictly for fuzzing through syzkaller (or by brave
"dogfooders" on the internal kernel teams).  KHWASAN would let these
dogfooders go from being brave to fearless.

-- 
Thanks,
~Nick Desaulniers

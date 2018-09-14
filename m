From: will.deacon@arm.com (Will Deacon)
Date: Fri, 14 Sep 2018 16:28:26 +0100
Subject: [PATCH v6 00/18] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <CAAeHK+wStsNwh2oKv-KCG4kx5538FuDMQ6Yw2X=sK5LPrw2DZg@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com>
 <20180905141032.b1ddaab53d1b2b3bada95415@linux-foundation.org>
 <20180906100543.GI3592@arm.com>
 <CAAeHK+wStsNwh2oKv-KCG4kx5538FuDMQ6Yw2X=sK5LPrw2DZg@mail.gmail.com>
Message-ID: <20180914152825.GC6236@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 01:06:23PM +0200, Andrey Konovalov wrote:
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

Ok, sorry, I completely misunderstood you earlier on then! For some reason
I thought you wanted this on by default.

In which case, I'm ok with the overall idea as long as we make the caveats
clear in the Kconfig text. In particular, that enabling this option may
introduce problems relating to pointer casting and comparison, but can
offer better coverage and lower memory consumption than a fully
software-based KASAN solution.

Will

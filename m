From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 16 Oct 2014 16:59:35 +0900
Subject: [GIT PULL 2/2] Samsung defconfig updates for v3.18
In-Reply-To: <CABxcv==HK5F5vv7g7XXBLofTVxx9Q8ZYj6bPfeMS7rWKTMb5pg@mail.gmail.com>
References: <543DB158.7030303@samsung.com>
 <CAOesGMgRBq93diDmA-21UYkFQTZu+LiF9gV+A==GS5uGW9n-Vg@mail.gmail.com>
 <1413380267.4565.1.camel@collabora.co.uk>
 <00e601cfe8dc$abf25bb0$03d71310$@kernel.org>
 <CABxcv==HK5F5vv7g7XXBLofTVxx9Q8ZYj6bPfeMS7rWKTMb5pg@mail.gmail.com>
Message-ID: <014e01cfe917$20adbb90$620932b0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas wrote:
> 
> Hello Kukjin,
> 
Hi,

> On Thu, Oct 16, 2014 at 3:01 AM, Kukjin Kim <kgene@kernel.org> wrote:
> > Sjoerd Simons wrote:
> >> > On Tue, 2014-10-14 at 23:32 -0700, Olof Johansson wrote:
> >> > On Tue, Oct 14, 2014 at 4:27 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> >> > >   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> >> > > tags/samsung-defconfig
> >> > >
> >> > > for you to fetch changes up to 508423bebcda29eb0ba7c627f895387dad7cdcd6:
> >> > >
> >> > >   ARM: exynos_defconfig: enable USB gadget support (2014-09-25 18:20:18
> >> > > +0900)
> >> >
> >> > Merged, thanks.
> >>
> >> Hrm, enabling USB gadget support will actually regress USB on Exynos
> >> peach boards and Arndale Octa without some of the DT fixes that landed
> >> in armsoc next/late branch. Specifically:
> >>
> >> 5c42acdbffff9bab595482b966b22ab5e2f6f359
> >> dbb62ef9ade6e92737d3fac199665b8b7c455959
> >>
> > Yeah...I've missed it. Sorry.
> >
> >> Might be good to cherry-pick those into for-next at this point (they're
> >> rather trivial)
> >>
> > So...Olof, can you please cherry pick them into arm-soc/fixes? Or shall I send
> > pull-request for them again?
> >
> 
+ Arnd, Olof and regarding MLs

> There are other bugfixes for 3.18 that ended in next/late so it would
> be good if you do a new pull request to include those as well.
> 
> The commits (with hashes from linux-next) are:
> 
> 3f3d046 ARM: dts: Remove display timings node from exynos5250-snow
> dd12ac7 ARM: dts: Fix chip select GPIO on exynos5250-smdk5250

> c04c92e ARM: dts: Add rtc_src clk for s3c-rtc on exynos5250-snow
> 8bd43b6 ARM: dts: Add rtc_src clk for s3c-rtc on exynos Peach boards
> 
I checked its dependent clock patches have been merged into mainline just now.
As you know, the patches blocked dt patches in this time :( Anyway, I'll try
to send a pull-request with including above patches tonight.

Thanks for your gentle reminder.

Olof, I think it makes sense because it is related fixes for 3.18 ;)

Sorry for late noise...

Thanks,
Kukjin

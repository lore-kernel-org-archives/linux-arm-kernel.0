From: tony@atomide.com (Tony Lindgren)
Date: Wed, 2 Apr 2014 08:31:04 -0700
Subject: [PATCH 0/4] ARM: OMAP: raw read and write endian fix
In-Reply-To: <533BE311.7050900@linaro.org>
References: <1387822234-11167-1-git-send-email-taras.kondratiuk@linaro.org>
 <CAArO44vC4WKGHSqHX3+Mo5+jcNuyJLkh94+SPd4H+aZYAroYzw@mail.gmail.com>
 <20140108003927.GJ5074@atomide.com> <5332AD89.8030802@linaro.org>
 <533BE311.7050900@linaro.org>
Message-ID: <20140402153104.GA12234@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Taras Kondratiuk <taras.kondratiuk@linaro.org> [140402 03:18]:
> On 03/26/2014 12:35 PM, Taras Kondratiuk wrote:
> > On 01/08/2014 02:39 AM, Tony Lindgren wrote:
> >> * Taras Kondratiuk <taras.kondratiuk@linaro.org> [131223 10:20]:
> >>> On 23 December 2013 20:10, Taras Kondratiuk <taras.kondratiuk@linaro.org> wrote:
> >>>> This series does trivial replacement of __raw_xxx functions with xxx_relaxed
> >>>> endian-neutral variants in 'mach-omap2' and 'plat-omap' directories.
> >>>> Some code here most probably won't be used in BE mode (like debug-leds for
> >>>> OMAP1 boards), but changes are made anyway to remove __raw_xxx() functions
> >>>> completely and simplify future grep'ing for new __raw_xxx() entries.
> >>
> >> Sorry for the delay on these, applying into omap-for-v3.14/be.
> >> These are trivial, and it's actually nice that you left out the
> >> assembly related changes as those should be acked by the PM
> >> people in case there are some issues dealing with the ROM code
> >> etc.
> > 
> > Hi Tony,
> > 
> > It seems omap-for-v3.14/be didn't get into 3.14-rc8.
> > Is there any issue with them?
> 
> This series conflicts now with clock changes which got into 3.14.
> Resolution is trivial - just skip conflicting changes.
> omap2_clk_{real,writel} already uses {readl,writel}_relaxed inside.
> Do I need to push an updated series?

Sorry looks like I forgot to merge this branch. I think my plan
was to wait for the clock changes to get merged first..

So yeah, it's probably best that you repost the series after -rc1
is out so we have the conflicting parts cleared. That way the
changes are tested to work for your BE series :)

Regards,

Tony

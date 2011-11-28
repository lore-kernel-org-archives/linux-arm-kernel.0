From: coelho@ti.com (Luciano Coelho)
Date: Mon, 28 Nov 2011 12:18:10 +0200
Subject: [PATCH 3/3] omap: board-sdp4430: declare support for
 MMC_PM_KEEP_POWER
In-Reply-To: <CAB3XZEfS4XN8sXf=r6s2cqOMnsSwLBsRLva61bQK4R-ZZnHPsA@mail.gmail.com>
References: <1321970539-7104-1-git-send-email-eliad@wizery.com>
 <1321970539-7104-3-git-send-email-eliad@wizery.com>
 <CAKd1q9pv5hMSpazYiZpmoowV52GvE7gFK5zUJSGpKhNkDZGuVg@mail.gmail.com>
 <CAB3XZEenx7L07BYmrHGt0h9ZAY-LOpWXL+in0vs7XOoeBf_LUw@mail.gmail.com>
 <1322471324.6502.32.camel@cumari> <4ED353C5.7030704@compulab.co.il>
 <1322474290.6502.53.camel@cumari>
 <CAB3XZEfS4XN8sXf=r6s2cqOMnsSwLBsRLva61bQK4R-ZZnHPsA@mail.gmail.com>
Message-ID: <1322475490.6502.56.camel@cumari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-11-28 at 12:12 +0200, Eliad Peller wrote: 
> On Mon, Nov 28, 2011 at 11:58 AM, Luciano Coelho <coelho@ti.com> wrote:
> > On Mon, 2011-11-28 at 11:26 +0200, Igor Grinberg wrote:
> >> On 11/28/11 11:08, Luciano Coelho wrote:
> >> > I may do it for panda later on, if I get the time to test it.  For
> >> > beagle, it doesn't really apply, because the wl12xx support is
> >> > out-of-tree, unfortunately. :(
> >>
> >> If I understood correctly, you want to change all the
> >> board files supporting the wl12xx wifi chip to have this
> >> capability set, right?
> >> Isn't this immediately affects the power consumption in
> >> sleep state?
> >> Shouldn't this be runtime controllable?
> >> I bet there are many applications that do not care about WoW,
> >> but do care about the power consumption.
> >> How does this change affect them?
> >
> > Good point, I don't know. :) Probably Eliad has the answer for that.
> >
> see the discussion regarding patch [2/3] - we only declare here
> support for this capability, but it's disabled by default.

Great, thanks! :) I now also understand the difference between the
pm_flags and pm_caps. :)

So, back to where we started, we should add the capability to all boards
that define the MMC capabilities of the wl12xx chip.  No matter who will
do it. :)

-- 
Cheers,
Luca.

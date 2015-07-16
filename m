From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 16 Jul 2015 10:37:27 -0700
Subject: [PATCH] input: ambakmi: Fix system PM by converting to modern
 callbacks
In-Reply-To: <CAPDyKFqu-BJLyP0aDDmZHjAUub=AZyA0YtTRhkZi=roHMaHcXA@mail.gmail.com>
References: <1429008108-29295-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFrhC1MCmOfoweztNtzk-Spwhj1uj7-sz3UtJhT_bHDQ+g@mail.gmail.com>
 <20150522164909.GA40101@dtor-ws>
 <CAPDyKFqu-BJLyP0aDDmZHjAUub=AZyA0YtTRhkZi=roHMaHcXA@mail.gmail.com>
Message-ID: <20150716173727.GA32571@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 10:48:06AM +0200, Ulf Hansson wrote:
> On 22 May 2015 at 18:49, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On Fri, May 22, 2015 at 04:37:12PM +0200, Ulf Hansson wrote:
> >> On 14 April 2015 at 12:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> > The legacy system PM support has long time ago been dropped from the
> >> > AMBA bus. Align to that by converting to the modern system PM
> >> > callbacks.
> >> >
> >> > Fixes: 26825cfd90f9 (ARM: 7914/1: amba: Drop legacy PM support ...)
> >> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>
> >> What happened with this one? Can we queue it for 4.2?
> >
> > I was hoping that Russel could give it a spin since he has the
> > relevant hardware.
> >
> 
> Hmm, as there are still no progress could we give it a try and queue
> it to get some test in linux-next? I think the patch is trivial and it
> would be nice to get it queued as a fix.

Yep. I removed #ifdef CONFIG_PM_SLEEP guard in favor of __maybe_unused
and applied.

Thanks.

-- 
Dmitry

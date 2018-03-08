From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Mar 2018 16:43:18 +0000
Subject: [PATCH v2] arm64/debug: Fix registers on sleeping tasks
In-Reply-To: <CAD=FV=X4_AQFBxWpinDj5F9DUckC02dQ_2QPFQRs34e5_b00bQ@mail.gmail.com>
References: <20180305234309.233226-1-dianders@chromium.org>
 <382abcdd-5264-0c0c-282f-d1f52ecff8e3@linaro.org>
 <CAD=FV=X4_AQFBxWpinDj5F9DUckC02dQ_2QPFQRs34e5_b00bQ@mail.gmail.com>
Message-ID: <20180308164318.GE9573@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 08:41:59AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Thu, Mar 8, 2018 at 8:19 AM, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > On 05/03/18 23:43, Douglas Anderson wrote:
> >>
> >> This is the equivalent of commit 001bf455d206 ("ARM: 8428/1: kgdb: Fix
> >> registers on sleeping tasks") but for arm64.  Nuff said.
> >>
> >> ...well, perhaps I could also add that task_pt_regs are userspace
> >> registers and that's not what kgdb is supposed to be reporting.  We're
> >> supposed to be reporting kernel registers.
> >>
> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> >
> > I hacked together a (still very immature) kgdb test suite[1] around the turn
> > of the year. Whilst its not quite solid enough for me to recommend others
> > deploy it except out of curiosity... so I haven't yet started yelling about
> > test suite failures except in the privacy of my own head.
> >
> > However I can confirm that this patch fixes one of the test suite failures I
> > haven't had time to blame allocate yet!
> >
> > So...
> > Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Thanks for your testing!  ...I'll have to check out your test suite soon.
> 
> 
> > BTW is this something that should Cc: stable?
> 
> It wouldn't hurt if this made it back to stable on a best-effort
> approach.  The problem has been there since the beginning, so it's not
> like it's fixing a regression that cropped up in a specific version.
> ...but it does fix a bug, so probably Cc stable makes sense.  I guess
> I'd leave it up to the maintainer that applies the patch?

I've already put this into -next, so I don't really want to rebase just for
this. If you think it's important, please send to stable at vger.kernel.org
once it's landed in mainline.

Will

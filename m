From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 May 2015 22:51:22 +0200
Subject: [PATCH v3 0/2] clk: improve handling of orphan clocks
In-Reply-To: <CAMAWPa9nDJzz_1D7FVnMO3PGAZ6PnmBKoL_iEvHFMDzQND6Wbw@mail.gmail.com>
References: <22709390.NTAlubMgNB@diego> <55440EDA.4030905@codeaurora.org>
 <CAMAWPa_n+59+v+x3fKkmdtW1wMJF7kqtTjLLowmv1xwGWprYJw@mail.gmail.com>
 <554BD33D.7050907@codeaurora.org> <20150508100247.GQ11057@lukather>
 <55528046.4030107@codeaurora.org> <20150513130304.GA4004@lukather>
 <7hiobw8s31.fsf@deeprootsystems.com>
 <20150513201426.GH4004@lukather>
 <CAMAWPa9nDJzz_1D7FVnMO3PGAZ6PnmBKoL_iEvHFMDzQND6Wbw@mail.gmail.com>
Message-ID: <20150513205122.GK4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 01:44:50PM -0700, Kevin Hilman wrote:
> On Wed, May 13, 2015 at 1:14 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Wed, May 13, 2015 at 07:33:54AM -0700, Kevin Hilman wrote:
> >> Maxime Ripard <maxime.ripard@free-electrons.com> writes:
> >>
> >> > On Tue, May 12, 2015 at 03:35:50PM -0700, Stephen Boyd wrote:
> >> >> On 05/08/15 03:02, Maxime Ripard wrote:
> >> >> > On Thu, May 07, 2015 at 02:03:57PM -0700, Stephen Boyd wrote:
> >> >> >> On 05/07/15 08:17, Kevin Hilman wrote:
> >> >> >>> On Fri, May 1, 2015 at 4:40 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> >> >> >>>> On 05/01/15 15:07, Heiko St?bner wrote:
> >> >> >>>>> Am Freitag, 1. Mai 2015, 13:52:47 schrieb Stephen Boyd:
> >> >> >>>>>
> >> >> >>>>>>> Instead I guess we could hook it less deep into clk_get_sys, like in the
> >> >> >>>>>>> following patch?
> >> >> >>>>>> It looks like it will work at least, but still I'd prefer to keep the
> >> >> >>>>>> orphan check contained to clk.c. How about this compile tested only patch?
> >> >> >>>>> I gave this a spin on my rk3288-firefly board. It still boots, the clock tree
> >> >> >>>>> looks the same and it also still defers nicely in the scenario I needed it
> >> >> >>>>> for. The implementation also looks nice - and of course much more compact than
> >> >> >>>>> my check in two places :-) . I don't know if you want to put this as follow-up
> >> >> >>>>> on top or fold it into the original orphan-check, so in any case
> >> >> >>>>>
> >> >> >>>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
> >> >> >>>>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> >> >> >>>> Thanks. I'm leaning towards tossing your patch 2/2 and replacing it with
> >> >> >>>> my patch and a note that it's based on an earlier patch from you.
> >> >> >>> It appears this has landed in linux-next in the form of 882667c1fcf1
> >> >> >>> clk: prevent orphan clocks from being used.  A bunch of boot failures
> >> >> >>> for sunxi in today's linux-next[1] were bisected down to that patch.
> >> >> >>>
> >> >> >>> I confirmed that reverting that commit on top of next/master gets
> >> >> >>> sunxi booting again.
> >> >> >>>
> >> >> >>>
> >> >> >> Thanks for the report. I've removed the two clk orphan patches from
> >> >> >> clk-next. Would it be possible to try with next-20150507 and
> >> >> >> clk_ignore_unused on the command line?
> >> >> > This makes it work, but it's not really an option.
> >> >> >
> >> >>
> >> >> Hmm.. I thought it didn't fix it for Kevin. Confused.
> >> >
> >> > I'm too, but it does fix things here.
> >>
> >> To be more precise on what I tested.  I used next-20150507 and tested on
> >> 4 different sunxi platforms.  First test was "normal" commandline,
> >> second was with clk_ignore_unused appended:
> >>
> >>   - cubie: fail, fail
> >>   - cubie2: fail, fail
> >>   - bananpi: fail, pass
> >>   - cubietruck: fail, pass
> >>
> >> So it seems to have some effect, but by itself, doesn't fix the issue.
> >
> > It's very odd, I actually tried with a cubie2 here...
> >
> > I'm booting on an initramfs and not MMC though, but I can't see how
> > that can be related to our issue...
> 
> I'm booting an initramfs too.

Then I don't know :)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/31eee124/attachment.sig>

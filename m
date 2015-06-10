From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 10 Jun 2015 09:45:39 +0200
Subject: [PATCH v2] mtd: nand: Sunxi calculate timing cfg
In-Reply-To: <5577E783.8050900@ultimaker.com>
References: <1433849498-3270-1-git-send-email-r.spliet@ultimaker.com>
 <20150609142308.0fd0952a@bbrezillon> <5576E7C2.10604@ultimaker.com>
 <20150609162007.7b19e8e2@bbrezillon>
 <5577E783.8050900@ultimaker.com>
Message-ID: <20150610094539.111f9baf@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roy,

On Wed, 10 Jun 2015 09:30:11 +0200
Roy Spliet <r.spliet@ultimaker.com> wrote:

> Hey Boris!
> 
> Op 09-06-15 om 16:20 schreef Boris Brezillon:
> > On Tue, 09 Jun 2015 15:18:58 +0200
> > Roy Spliet<r.spliet@ultimaker.com>  wrote:
> >
> >
> >>   >> +
> >>   >> +static s32 sunxi_nand_lookup_timing(const s32 *lut, lut, u32
> >> period, u32 clk_period)
> >>   > I'm not sure the period name is appropriate here, what you're actually
> >>   > passing is the timing you're expecting.
> >>   > How about renaming it 'min_timing'
> >>
> >> What it encodes is the minimum or maximum time or delay for given timing
> >> parameter in picoseconds. Given this definition, I think period actually
> >> describes the parameter better than "min_timing". Alternatively, I could go
> >> for period_ps or perhaps timing_period_ps (with matching clk_period_ps).
> > Hm, I don't agree here. From my POV, a period is something used to
> > describe cyclic operations. If you take a clk, the period encodes the
> > time required a clk cycle (a rising and a falling edge).
> > Here the timings you're passing are not cyclic at all.
> For the sake of argument: within a cyclic event (wave theory) you are 
> quite right with
> this definition: the period describes the time to complete one cycle (or 
> oscillation).
> However, in English[1] a period is simply a length of time, carrying no 
> further
> specification about any recurrence of events.
> Having said that, you're the person who still has to look at this code 
> three weeks from
> now. I personally find "timing" a confusing name because it is more 
> abstract than
> what the value holds (the interval/period/duration of a memory "state"), 
> but if you find
> that clearer, it's your final call!

You're right about the English definition of period, however, what
bothers me here is that the clk_period is actually representing the
time of clk cycle, while the period argument is not related at all
with a cyclic event, and this can lead misinterpretations.
Anyway, this is just a detail (but I'd still prefer duration over
period ;-)).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

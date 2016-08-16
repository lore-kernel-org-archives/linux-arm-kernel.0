From: kbeldan@baylibre.com (Karl Beldan)
Date: Tue, 16 Aug 2016 23:20:29 +0000
Subject: [PATCH 3/4] ARM: dts: da850-lcdk: Add NAND to DT
In-Reply-To: <57AB15B3.1050907@ti.com>
References: <20160809171518.22690-1-kbeldan@baylibre.com>
 <20160809171518.22690-4-kbeldan@baylibre.com>
 <57AAE67D.4000404@ti.com> <20160810090417.GE16481@gobelin>
 <57AAF472.7000804@ti.com> <20160810111944.GA31616@gobelin>
 <57AB15B3.1050907@ti.com>
Message-ID: <20160816232029.GA31105@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 05:23:23PM +0530, Sekhar Nori wrote:
> On Wednesday 10 August 2016 04:49 PM, Karl Beldan wrote:
> > On Wed, Aug 10, 2016 at 03:01:30PM +0530, Sekhar Nori wrote:
> >> On Wednesday 10 August 2016 02:34 PM, Karl Beldan wrote:
> >>> On Wed, Aug 10, 2016 at 02:01:57PM +0530, Sekhar Nori wrote:
> >>>> On Tuesday 09 August 2016 10:45 PM, Karl Beldan wrote:
> >>>>> This adds DT support for the NAND connected to the SoC AEMIF.
> >>>>> The parameters (timings, ecc) are the same as what the board ships with
> >>>>> (default AEMIF timings, 1bit ECC) and improvements will be handled in
> >>>>> due course.
> >>>>
> >>>> I disagree that we need to be compatible to the software that ships with
> >>>> the board. Thats software was last updated 3 years ago. Instead I would
> >>>> concern with what the hardware supports. So, if the hardware can support
> >>>> 4-bit ECC, I would use that.
> >>>>
> >>> I am not saying we _need_ to be compatible.
> >>
> >> Alright then, please drop references to what software the board ships
> >> with in the commit message and in the patch itself.
> >>
> > 
> > I hadn't seen this comment before sending v2.
> > 
> >>>
> >>>> If driver is broken for 4-bit ECC, please fix that up first.
> >>>>
> >>> Since this issue is completely separate from my DT improvements
> >>> I'll stick to resubmitting the series, applying my LCDK changes to the
> >>> EVM too, besides you'll be able to compare the behavior without ECC
> >>> discrepancies.
> >>> I took note that you are likely to not apply without the ECC fix.
> >>
> >> Yeah, I would not like to apply with 1-bit ECC now and then change to
> >> 4-bit ECC soon after.
> >>
> > 
> > Both mityomapl138 from mainline and hawkboard from TI's BSP release
> > include the comment:
> > - "4 bit mode is not supported with 16 bit NAND"
> > It is not clear whether they imply that the HW has issues or if it's SW
> 
> At least the TRM says "The EMIFA supports 4-bit ECC on 8-bit/16-bit NAND
> Flash.". And then the TRM goes on to describe how 4-bit ECC is supposed
> to work for 16-bit NAND. I could not find any errata related to this in
> the errata document.
> 
> > only, but 4-bits ECC is a different matter and I hope you'll integrate
> > the current changes prior to tackling it.
> 
> Lets apply everything together. This is a new feature, not a bug fix.
> There is no need to rush it. Also, for the NAND part on LCDK, per the
> micron datasheet, minimum of 4-bit ECC is needed.
> 

FYI my patches are related to a small contracting work spanning 20 days
amounting to 15 real days (from scratch).  ATM my SoW not only doesn't
include this 'new feature' but excludes it. So I cannot promise I'll
look into it, though it shouldn't be too big a thing.
It seemed clear that you wanted to squeeze it with the rest, but after
setting things up for the EVM and observing mainline was broken with
4bits ECC on an 8bits NAND I thought it was impossible nobody hadn't
noticed it .. so I dug in the mail archive, only to find there had
already been some alerts raised some months ago on the list, so I picked
up my next item.

> I will take a look at other patches in this series.
> 

Ok, thanks.

Rgds, 
Karl

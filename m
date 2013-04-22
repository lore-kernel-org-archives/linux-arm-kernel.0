From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Apr 2013 21:11:45 +0200
Subject: [PATCH RESEND] ARM: EXYNOS: no more support non-DT for EXYNOS SoCs
In-Reply-To: <51756E98.9040606@samsung.com>
References: <51642dab.e844440a.0ad1.ffffc13f@mx.google.com>
 <516571BC.9030909@samsung.com> <51756E98.9040606@samsung.com>
Message-ID: <201304222111.45653.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 April 2013, Kukjin Kim wrote:
> On 04/10/13 23:05, Kukjin Kim wrote:
> > On 04/10/13 22:55, Arnd Bergmann wrote:
> >> On Wednesday 10 April 2013, Sylwester Nawrocki wrote:
> >>> Hmm, it turns out we are still actively using some boards based on
> >>> Exynos4210 EVT0 SoCs. And since it seems unlikely the patches from
> >>> Tomasz [1] adding basic DT support for those will get merged for
> >>> 3.10, it would be a bit inconvenient to remove the ATAGS support
> >>> now, leaving Exynos4210 Rev. 0 not supported at all.
> >>
> >> I still have hope to get those included.
> >>
> > I agree and I asked Tomasz to re-send universal dt patch.
> >
> Hi Arnd and Olof,
> 
> Is it possible to send one more pull-request for this and something like 
> dt patches for exynos?

I think it's too late for that now, let's just fix the broken pieces
now and do the minimum amount of patches on top of what we have:

* Thomas Abraham's fix for the clk code
* Tomasz Figa's patch to restore Universal C210
* Whatever is needed to get USB working again on Arndale
* Anything else that comes up that is really a bug fix.
* Getting the PWM and ADC drivers working with DT, that can
  easily be done.
* Possibly a patch to mark CONFIG_EXYNOS_ATAGS as broken,
  if you think that helps.

but not:

* The entire series to rework the PWM clock from Tomasz
* The entire series to remove ATAGS support on Exynos
* Any other non-bugfix patches

	Arnd

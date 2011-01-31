From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 31 Jan 2011 20:58:29 +0530
Subject: [linux-pm] [PATCH] i2c: OMAP: fix static suspend vs. runtime
	suspend
In-Reply-To: <Pine.LNX.4.44L0.1101311010580.1931-100000@iolanthe.rowland.org>
References: <1a4ad626f3cb73267847e8ac7bd47545@mail.gmail.com>
	<Pine.LNX.4.44L0.1101311010580.1931-100000@iolanthe.rowland.org>
Message-ID: <266a2f0ec446d693cf9583681ca346e0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Alan Stern [mailto:stern at rowland.harvard.edu]
> Sent: Monday, January 31, 2011 8:43 PM
> To: Rajendra Nayak
> Cc: Kevin Hilman; Ben Dooks; linux-i2c at vger.kernel.org;
linux-pm at lists.linux-foundation.org; linux-
> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [linux-pm] [PATCH] i2c: OMAP: fix static suspend vs.
runtime suspend
>
> On Mon, 31 Jan 2011, Rajendra Nayak wrote:
>
> > Can you elaborate a bit more on how/why runtime PM transitions
> > are disabled during system suspend, and how is it taken care
> > of that a runtime resume of a device works however a subsequent
> > runtime (re)suspend does not?
>
> I'll answer for Kevin.  This is done by the PM core, in order to
> prevent runtime power transitions from interfering with a system power
> transition.  The PM core increments the device's usage_count; this
> prevents the device from being runtime-suspended but it allows
> runtime-resume calls to go through.

Thanks, I did remember seeing the pm_runtime_get_noresume()
in dpm_prepare(). Just did not correlate it was the same Kevin
was trying to say.

Regards,
Rajendra

>
> Alan Stern

From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 5 Jul 2012 16:06:11 +0200
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <4FF592A9.5050706@linaro.org>
References: <20120705094541.GK4111@opensource.wolfsonmicro.com>
 <4FF57EA9.7060107@linaro.org>
 <20120705120600.GT4111@opensource.wolfsonmicro.com>
 <4FF58571.2090807@linaro.org>
 <20120705122947.GY4111@opensource.wolfsonmicro.com>
 <4FF58B68.5000703@linaro.org>
 <20120705124549.GD4111@opensource.wolfsonmicro.com>
 <4FF58ED6.40106@linaro.org>
 <20120705130306.GI4111@opensource.wolfsonmicro.com>
 <4FF592A9.5050706@linaro.org>
Message-ID: <20120705140611.GB18200@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, Jul 05, 2012 at 02:12:09PM +0100, Lee Jones wrote:
> On 05/07/12 14:03, Mark Brown wrote:
> >On Thu, Jul 05, 2012 at 01:55:50PM +0100, Lee Jones wrote:
> >>On 05/07/12 13:45, Mark Brown wrote:
> >
> >>>Right, so what I'm saying is that what I'd expect unless there's
> >>>something unusual going on is that you wouldn't be doing the separate
> >>>registration of the AB8500 here and would instead be passing the
> >>>platform data for the AB8500 through in the same way you pass the DT
> >>>data through.
> >
> >>Then were would you register it, if not here?
> >
> >Same place as for DT.
> 
> That is a possibility, but the idea is to reduce code in the
> platform area, not add to it. We'd also need a completely separate
> platform_data structure to the one we use for platform registration,
> as much of it has now been moved into Device Tree. The regulators
> are a good example of this, but there's also GPIO information which
> is no longer relevant etc.
> 
> I do believe that registering the AB8500 from the DB8500 is
> appropriate though, for the simple reason that the AB8500 is a
> sub-device to the DB8500. I think this is the correct thing to do.
I agree with you here, and I thus see no reasons why we should have a
different code path for DT and !DT cases.


> But anyway, as I said before, that ship has sailed. We _already_ do
> this. All this patch does is prevent the AB8500 from being
> registered twice when DT is not enabled.
Sure, and it does exactly that. But this does look like a workaround rather
than an actual fix. And Mark is right about showing the wrong example with
this kind of patches for other MFD drivers.
I'd prefer seeig the !DT support removed for now until you can find a proper
and common solution for both DT and !DT cases.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 16 Jul 2012 14:38:09 +0200
Subject: [PATCH 1/1] mfd: ab8500: Clean-up the last two ab8500 related DT
 match tables
In-Reply-To: <4FFC722E.2020303@linaro.org>
References: <1341578598-9307-1-git-send-email-lee.jones@linaro.org>
 <20120710091304.GU15345@sortiz-mobl> <4FFC4A23.5000107@linaro.org>
 <20120710165518.GG15345@sortiz-mobl> <4FFC722E.2020303@linaro.org>
Message-ID: <20120716123809.GC20652@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, Jul 10, 2012 at 08:19:26PM +0200, Lee Jones wrote:
> On 10/07/12 18:55, Samuel Ortiz wrote:
> >Hi Lee,
> >
> >On Tue, Jul 10, 2012 at 05:28:35PM +0200, Lee Jones wrote:
> >>On 10/07/12 11:13, Samuel Ortiz wrote:
> >>>Hi Lee,
> >>>
> >>>On Fri, Jul 06, 2012 at 01:43:18PM +0100, Lee Jones wrote:
> >>>>A patch was recently submitted to stop all ab8500 devices from
> >>>>being registered through Device Tree. Instead, only the db8500
> >>>>will be DT:ed and the rest will continue to be registered via
> >>>>the MFD API, as they always were.
> >>>>
> >>>>Two patches have recently been applied which enable Device Tree
> >>>>probing; one for rtc-ab8500 and the other for ponkey-ab8500.
> >>>>These two need to be removed to prevent double-probing these
> >>>>devices with Device Tree is enabled.
> >>>>
> >>>>Cc: Samuel Ortiz <sameo@linux.intel.com>
> >>>>Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >>>>---
> >>>>  drivers/input/misc/ab8500-ponkey.c |    8 --------
> >>>>  drivers/rtc/rtc-ab8500.c           |    6 ------
> >>>>  2 files changed, 14 deletions(-)
> >>>I don't know against which tree you generated those patches, but none of those
> >>>2 of_device_id arrays are in my for-next branch. So I can't apply this patch.
> >>
> >>I can rebase them on anything of your choosing.
> >>
> >>What is your for-next branch based on?
> >On Linus' tree. And the of_device_id arrays are not there.
> 
> Ah, that's why.
> 
> These are patches based on the -next tree.
> 
> The code we adapt here isn't in Mainline yet.
>
> I can wait and send them in the back-end of the merge window, or
> -rc1 instead?
Yes, I can send it as a post rc1 patch.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

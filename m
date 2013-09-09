From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 09 Sep 2013 08:23:50 -0700
Subject: [PATCH] ARM: OMAP2+: am335x-bone*: add DT for BeagleBone Black
In-Reply-To: <1378736961-21005-1-git-send-email-koen@dominion.thruhere.net>
 (Koen Kooi's message of "Mon, 9 Sep 2013 16:29:21 +0200")
References: <1378736961-21005-1-git-send-email-koen@dominion.thruhere.net>
Message-ID: <87zjrm81dl.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Koen Kooi <koen@dominion.thruhere.net> writes:

> The BeagleBone Black is basically a regular BeagleBone with eMMC and HDMI added,
> so create a common dtsi both can use.
>
> IMPORTANT: booting the existing am335x-bone.dts will blow up the HDMI transceiver
> after a dozen boots with an uSD card inserted because LDO will be at 3.3V instead
> of 1.8.
>
> MMC support for AM335x still isn't in, so only the LDO change has been added.
>
> Cc: stable at vger.kernel.org
>
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> Tested-by: Tom Rini <trini@ti.com>
> Tested-by: Matt Porter <matt.porter@linaro.org>

I guess the subject should've included v5?  Also, if this is to be
stable material, it will likely need rework since I don't think it will
apply cleanly to older trees due to DT churn.

Anyways, for this patch...

Acked-by: Kevin Hilman <khilman@linaro.org>

Even though I've probably already fried my HDMI transciever due to using
the original DTS a lot more than a dozen times.  (and to TI: yes, I'd
accept a new BB black as a sympathy gift.)  ;)

Also, I tested this on both BBW and BBW:

Tested-by: Kevin Hilman <khilman@linaro.org>

Benoit, assuming this looks good to you, can you queue this for v3.12-rc
please?   It applies to Linus' HEAD today (which has most of arm-soc
merged), so it should apply cleanly on top of all your stuff.

Kevin

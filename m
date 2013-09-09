From: matt.porter@linaro.org (Matt Porter)
Date: Mon, 9 Sep 2013 09:31:01 -0400
Subject: [PATCHv3] ARM: OMAP2+: am335x-bone*: add DT for BeagleBone Black
In-Reply-To: <1378638746-10627-1-git-send-email-koen@dominion.thruhere.net>
References: <1378638746-10627-1-git-send-email-koen@dominion.thruhere.net>
Message-ID: <20130909133059.GD10973@ohporter.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 08, 2013 at 01:12:26PM +0200, Koen Kooi wrote:
> The BeagleBone Black is basically a regular BeagleBone with eMMC and HDMI added,
> so create a common dtsi both can use.
> 
> IMPORTANT: booting the existing am335x-bone.dts will blow up the HDMI transceiver 
> after a dozen boots with an uSD card inserted because LDO will be at 3.3V instead
> of 1.8. 
> 
> MMC support for AM335x still isn't in, so only the LDO change has been added.
> 
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>

Tested-by: Matt Porter <matt.porter@linaro.org>

Works fine for me on tip and 3.11. I did notice a regression in musb (worked
on 3.11, now failing to probe but this is not related to your new dts as it
happens on am335x-bone.dts too, assuming merge window volatility). One nit,
git-am picked up a whitespace error on that extra line at EOF so you should
trim that out.

Only thing is...for a clear bug like this that will destroy hardware, it
should be marked Cc: stable at vger.kernel.org to be picked up in stable.

-Matt

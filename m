From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 24 Oct 2015 14:26:21 +0200
Subject: [PATCH 0/4] Patches to fix remote wakeup on rk3288 dwc2 "host"
 port
In-Reply-To: <1445624891-31680-1-git-send-email-dianders@chromium.org>
References: <1445624891-31680-1-git-send-email-dianders@chromium.org>
Message-ID: <1633226.9pFzvpSks6@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 23. Oktober 2015, 11:28:07 schrieb Douglas Anderson:
> The "host1" port (AKA the dwc2 port that isn't the OTG port) on rk3288
> has a hardware errata that causes everything to get confused when we get
> a remote wakeup.  It appears that the "port reset" bit that's in the USB
> phy (located in the rk3288 GRF) fixes things up and appears safe to do.
> 
> This series of patches exports the "port reset" from the PHY and then
> hooks it up to dwc2 through a quirk.
> 
> I've tested this series atop a bit of a conglomeration of Heiko's github
> "somewhat stable" branch (v4.3-rc3-876-g6509232) but with Greg KH's
> usb-next merged in.

I've been involved in the earlier revisions already, so this version already 
implements the review-comments I had. I've also gave this a spin on 4.3-rc6 
with usb-next merged in on a rk3288-firefly, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>


If the first two patches get picked up, I'll pick the two dts patches 
afterwards.


Thanks
Heiko

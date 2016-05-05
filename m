From: briannorris@chromium.org (Brian Norris)
Date: Wed, 4 May 2016 18:11:12 -0700
Subject: [PATCH] ARM: dts: rockchip: move rk3288 edp phy under the GRF
In-Reply-To: <4275673.EbRsbqkhH8@diego>
References: <1640976.sZtsTTlDpl@diego>
 <4275673.EbRsbqkhH8@diego>
Message-ID: <20160505011112.GA131923@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 03:56:27PM +0200, Heiko Stuebner wrote:
> Am Samstag, 16. April 2016, 02:49:14 schrieb Heiko St?bner:
> > The edp-phy control is a part of the General Register Files and
> > with a recent patch in 4.6 the phy driver can now also handle this
> > correctly, so move the dts node under the GRF as well.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> the change in the phy-driver has made it into Greg's usb tree as fix for 4.6, 
> so I've picked this patch for 4.7 now.

Not sure if it's intentional, but the phy binding change (which is in
4.6) broke the DP support in 4.6/rk3288.dtsi, and this patch is
necessary to bring it back. Shouldn't this DTS change have gone to 4.7
too? Or (when convincing ourselves we're not breaking the DT ABI here),
could we just claim that eDP wasn't supported in 4.6, and 4.7 will just
be bug-fixing the rk3288 DTS?

Brian

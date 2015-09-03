From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 04 Sep 2015 00:01:35 +0200
Subject: [PATCH] ARM: dts: Add ddc i2c reference to veyron
In-Reply-To: <CAD=FV=WkFPitTsagQa+94DAWujzYECVqk7fO+OUdrfFq3bWTuQ@mail.gmail.com>
References: <1441229148-12095-1-git-send-email-dianders@chromium.org>
 <CAD=FV=WkFPitTsagQa+94DAWujzYECVqk7fO+OUdrfFq3bWTuQ@mail.gmail.com>
Message-ID: <5450060.vCTDljrI7r@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 3. September 2015, 14:00:26 schrieb Doug Anderson:
> Hi,
> 
> On Wed, Sep 2, 2015 at 2:25 PM, Douglas Anderson <dianders@chromium.org> 
wrote:
> > The ddc-i2c-bus property was missing from the veyron dtsi file since
> > downstream the ddc-i2c-bus was still being specified in rk3288.dtsi and
> > nobody noticed when the veyron dtsi was sent upstream.  Add it.
> > 
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > Note: I noticed that this was wrong but I don't currently have
> > graphics up and running on upstream on veyron.  Posting this anyway
> > since it's pretty clear that it's needed.  If someone else wants to
> > try it out that'd be nice, otherwise I'll put it on my list to figure
> > out how to get myself setup for graphics upstream.  ;)
> 
> OK, I've used Heiko's "somewhat stable" branch to test this against
> something very close to mainline.

for people playing along, that is [0]. Essentially bleeding edge mainline + 
some backports from other maintainer trees +the last bits in the works, like 
the eDP support.

> Without my patch I can't read the HDMI EDID.  With my patch I can.  :)

The change follows the current dt-binding in the kernel for the (rockchip-
variant of the) dw_hdmi, so if nobody keeps protesting loudly, I'd like to 
pick this up to get the hdmi on Veyron devices going.

And I guess we'll remove this again (also in the other boards), once the 
dw_hdmi-internal i2c stuff is included - so this should be temporary as Rob 
hoped.


Heiko


[0] https://github.com/mmind/linux-rockchip/tree/v4.2-rockchip-somewhat-stable

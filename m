From: briannorris@chromium.org (Brian Norris)
Date: Wed, 14 Dec 2016 17:18:24 -0800
Subject: [PATCH 3/3] arm64: dts: rockchip: add clk-480m for ehci and ohci
 of rk3399
In-Reply-To: <20161215004737.GA32652@google.com>
References: <1481710301-1454-1-git-send-email-zhengxing@rock-chips.com>
 <1481710301-1454-4-git-send-email-zhengxing@rock-chips.com>
 <CAD=FV=UU4JdRjRgEvc_wxprvi6bo46+jd=x2m2QzOe4uJmuRPA@mail.gmail.com>
 <20161215004737.GA32652@google.com>
Message-ID: <20161215011821.GA44014@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 04:47:38PM -0800, Brian Norris wrote:
> On Wed, Dec 14, 2016 at 04:10:38PM -0800, Doug Anderson wrote:
> > On Wed, Dec 14, 2016 at 2:11 AM, Xing Zheng <zhengxing@rock-chips.com> wrote:
> > > From: William wu <wulf@rock-chips.com>
> > >
> > > We found that the suspend process was blocked when it run into
> > > ehci/ohci module due to clk-480m of usb2-phy was disabled.

One more thing: why is the USB2 PHY relevant to the OHCI controller? And
if it is relevant, why isn't there a PHY phandle for it in
usb_host0_ohci and usb_host1_ohci in rk3399.dtsi? As it stands, your
patch is hacking in USB2 clock references for OHCI, but you're not
actually managing the PHY there at all. Seems like you'd want to do
all-or-nothing if there's a functional dependency between the OHCI
controllers and the USB2 PHYs.

Brian

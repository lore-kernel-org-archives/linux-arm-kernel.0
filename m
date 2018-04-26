From: dianders@chromium.org (Doug Anderson)
Date: Thu, 26 Apr 2018 08:29:17 -0700
Subject: [PATCH v3 6/6] arm64: dts: rockchip: Specify override mode for
 kevin panel
In-Reply-To: <20180426120528.GA11985@ulmo>
References: <20180208174855.55620-1-seanpaul@chromium.org>
 <20180208174855.55620-7-seanpaul@chromium.org>
 <CAD=FV=WGU+s015DQbNeWHkpqpHLFz+9AjHKAd0N3HWag0p5FWA@mail.gmail.com>
 <20180426120528.GA11985@ulmo>
Message-ID: <CAD=FV=U-CL6msCicDhE28huONe0T_ChE+FKZ1CkEJOK=WKryGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 26, 2018 at 5:05 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> If you've got an EDID you should be relying on the EDID to provide the
> timings. No need to have any timings in the DT in that case.

The problem that's specifically trying to be solved by Sean's series
is when we have to use timings other than the one suggested by the
EDID.  Specifically:

* On many Rockchip SoCs there is only one "extra" PLL available.  This
extra PLL can only be used by one of the two displays (eDP for
internal panel or HDMI/DP for external display).  The other display
has to use one of the "shared" PLLs in the system.  These PLLs have
their rate set at boot and aren't changed.

* In order to provide maximum flexibility to connect external
displays, we always want the "extra" PLL dedicated to the external
display port.  Then we can make lots of pixel clocks.

* We work with device and display manufacturers to figure out a pixel
clock that is achievable with the shared PLLs and that has valid
timings.  This is the the pixel clock that was used when testing EMI,
etc.  It is the one that should be used.

* Panel manufacturers agreed that this pixel clock was good to use,
but we didn't get an updated EDID that suggested this mode.  It's my
understanding that panels were already available and it didn't really
make sense to program in an EDID to work around a certain board.



-Doug

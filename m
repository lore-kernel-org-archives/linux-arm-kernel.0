From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Thu, 06 Sep 2018 07:07:19 +0200
Subject: [linux-sunxi] [PATCH v4 11/11] arm64: dts: allwinner: a64: Enable
 HDMI output on A64 boards w/ HDMI
In-Reply-To: <CAMty3ZAVr_d+Rwry_DMWY221OC+YSWmReNm-TXzYWgpd1s68+w@mail.gmail.com>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180905075136.chumwosx76o2n66l@flea>
 <CAMty3ZAVr_d+Rwry_DMWY221OC+YSWmReNm-TXzYWgpd1s68+w@mail.gmail.com>
Message-ID: <1794260.muFTeCcfyt@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jagan,

Dne sreda, 05. september 2018 ob 09:57:54 CEST je Jagan Teki napisal(a):
> On Wed, Sep 5, 2018 at 1:21 PM, Maxime Ripard <maxime.ripard@bootlin.com> 
wrote:
> > On Wed, Sep 05, 2018 at 12:56:03PM +0530, Jagan Teki wrote:
> >> On Tue, Sep 4, 2018 at 10:10 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> >> > From: Jagan Teki <jagan@amarulasolutions.com>
> >> > 
> >> > Enable all necessary device tree nodes and add connector node to device
> >> > trees for all supported A64 boards with HDMI.
> >> > 
> >> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >> > [Icenowy: squash all board patches altogether and change supply name]
> >> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> > ---
> >> > Changes in v4:
> >> > - Rebase some device trees.
> >> > Changes in v3,1:
> >> > - Squash all enablement patches altogether.
> >> > - Change supply name to match DT binding & driver change.
> >> > Changes for v3:
> >> > - Enable all pipeline components
> >> > Changes for v2:
> >> > - none
> >> > 
> >> >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 34 +++++++++++++++++++
> >> >  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 34 +++++++++++++++++++
> >> >  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 34 +++++++++++++++++++
> >> >  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 34 +++++++++++++++++++
> >> >  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 34 +++++++++++++++++++
> >> >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 34 +++++++++++++++++++
> >> >  6 files changed, 204 insertions(+)
> >> 
> >> Tested-by: Jagan Teki <jagan@amarulasolutions.com> # BPI-M64, OPI-Win,
> >> A64-Olinuxino, NPI-A64
> >> 
> >> Pine64 boards look unable by saying
> >> [drm] Cannot find any crtc or sizes
> >> 
> >> May be someone can confirm, it.
> > 
> > Then we should drop the pine64 additions until someone figures it out,
> > as it has been already discussed.
> 
> That is fine, but If anyone have pine64 can confirm this.

What is your monitor default resolution and more importantly, what is it's 
pixel clock?

Pine64 has U-Boot support for DE2/HDMI, which has some pixel clock issues 
which can influence Linux, unfortunately. At the time, there wasn't enough 
knowledge to do it properly. I plan to update it after A64 DE2/HDMI support is 
finished in kernel.

Meanwhile, can you test if it works for you either with disabled DE2/HDMI in 
U-Boot or if you apply this patch to Linux:
https://github.com/jernejsk/linux-1/commit/
019121f953229ca2d624ac39300289a24e5389a1

Best regards,
Jernej

From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Aug 2018 17:23:01 +0800
Subject: [PATCH 6/6] ARM: imx_v6_v7_defconfig: Select
 CONFIG_DRM_PANEL_SEIKO_43WVF1G
In-Reply-To: <20180821090848.GC31070@dragon>
References: <1532119161-16597-1-git-send-email-festevam@gmail.com>
 <1532119161-16597-6-git-send-email-festevam@gmail.com>
 <CAOMZO5AycMPm4+THSHW02=Nnce+QEyQ4CJR9Jp6xyET00n_8+A@mail.gmail.com>
 <20180821090848.GC31070@dragon>
Message-ID: <20180821092300.GA31569@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2018 at 05:08:50PM +0800, Shawn Guo wrote:
> On Mon, Jul 23, 2018 at 10:57:22AM -0300, Fabio Estevam wrote:
> > Hi Shawn,
> > 
> > On Fri, Jul 20, 2018 at 5:39 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > > From: Fabio Estevam <fabio.estevam@nxp.com>
> > >
> > > imx6sl-evk, imx6sll-evk and imx6sx-sdb boards use a Seiko 43WVF1G panel.
> > >
> > > Now that the DRM mxsfb driver is the one selected by default, let's
> > > also select CONFIG_DRM_PANEL_SEIKO_43WVF1G so that these boards continue
> > > to have a working display by default.
> > >
> > > Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> > 
> > I understand you have already submitted the imx 4.19 material to Olof
> > and he has already merged it.
> > 
> > Without this series we will have many NXP development boards without
> > functional display in 4.19 by default due to the drm mxsfb conversion
> > in defconfig, which would not be a very good user experience.
> > 
> > I would like to kindly ask you to consider applying this series to 4.19 as well.
> 
> I guess only the last two defconfig patches are necessary to keep those
> boards getting functional display for 4.19, no?

Okay, just found that only the generic panel-lvds driver will parse
those timing parameters from DT.

I will try to send the series for 4.19 inclusion.

Shawn

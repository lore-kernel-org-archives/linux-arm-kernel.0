From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Apr 2015 22:37:55 +0800
Subject: [PATCH] ARM: dts: imx53: add support for USB armory board
In-Reply-To: <20150427132658.GB11598@core.inversepath.com>
References: <1429882425-24514-1-git-send-email-andrej@inversepath.com>
 <CAOMZO5BR=ODT6aBsbPJy5Dt9ZF4t9_R7Comqw4G8m2DUz6kumw@mail.gmail.com>
 <20150427132658.GB11598@core.inversepath.com>
Message-ID: <20150427143753.GB1788@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 27, 2015 at 03:26:58PM +0200, Andrej Rosano wrote:
> > > +&vpu {
> > > +       status = "okay";
> > > +};
> > 
> > VPU is already enabled in imx53.dtsi.
> 
> There is no "status" defined for vpu in imx53.dtsi, also imx53-qsb-common.dtsi
> explicitly enable it.

No status equals to status = "okay".  We have status = "disabled" in
<soc>.dtsi and explicitly enable it by changing status to "okay" for
devices which have pin out on board.  For devices like VPU, DMA which is
completely SoC internal, we simply do not use status and have them
always enabled.

Shawn

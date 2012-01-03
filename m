From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 09:10:15 +0000
Subject: [PATCH] ARM: imx6q: add support for IRAM
In-Reply-To: <20111226134129.GA9014@S2100-06.ap.freescale.net>
References: <1324898123-13973-1-git-send-email-jason.chen@linaro.org>
 <20111226134129.GA9014@S2100-06.ap.freescale.net>
Message-ID: <20120103091015.GD2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2011 at 09:41:30PM +0800, Shawn Guo wrote:
> On Mon, Dec 26, 2011 at 07:15:23PM +0800, Jason Chen wrote:
> > Signed-off-by: Jason Chen <jason.chen@linaro.org>
> > Signed-off-by: Eric Miao <eric.miao@linaro.org>
> > ---
> >  arch/arm/boot/dts/imx6q.dtsi    |    7 +++++++
> >  arch/arm/mach-imx/Kconfig       |    1 +
> >  arch/arm/mach-imx/clock-imx6q.c |    3 ++-
> >  arch/arm/mach-imx/mach-imx6q.c  |   17 +++++++++++++++++
> >  4 files changed, 27 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> > index 263e8f3..01646b8 100644
> > --- a/arch/arm/boot/dts/imx6q.dtsi
> > +++ b/arch/arm/boot/dts/imx6q.dtsi
> > @@ -80,6 +80,13 @@
> >  		};
> >  	};
> >  
> > +	ocram at 00900000 {
> > +		compatible = "fsl,imx6q-iram";
> 
> It should have nothing specific to imx6q, and could be "fsl,iram".
> Then we can have some common code across different SoCs to match it.

Why is this even specific to fsl?  Isn't it something that could be
specified in a totally generic way?

As I showed with my original set of sram patches, there is not much
specific about this on-board RAM: what is specific is how a SoC uses
it, and that's up to the rest of the SoC code.

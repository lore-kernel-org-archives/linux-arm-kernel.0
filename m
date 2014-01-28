From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Jan 2014 20:33:02 +0800
Subject: [PATCH 2/2] ARM: dts: imx6sl-evk: Add audio support
In-Reply-To: <CAOMZO5BWfrjxJr=f=0hHwQNuJcQDeLSJi=u6Fci44EctKMSCHQ@mail.gmail.com>
References: <1390443213-14061-1-git-send-email-festevam@gmail.com>
 <1390443213-14061-2-git-send-email-festevam@gmail.com>
 <20140128121211.GK20583@S2101-09.ap.freescale.net>
 <CAOMZO5BWfrjxJr=f=0hHwQNuJcQDeLSJi=u6Fci44EctKMSCHQ@mail.gmail.com>
Message-ID: <20140128123258.GB20595@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 10:14:55AM -0200, Fabio Estevam wrote:
> On Tue, Jan 28, 2014 at 10:12 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> >> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> >> index 95bb37b..04cf457 100644
> >> --- a/arch/arm/boot/dts/imx6sl.dtsi
> >> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> >> @@ -236,6 +236,7 @@
> >>                                              <&sdma 38 1 0>;
> >>                                       dma-names = "rx", "tx";
> >>                                       fsl,fifo-depth = <15>;
> >> +                                     fsl,ssi-dma-events = <38 37>;
> >
> > Do you still need this custom property?
> 
> I can get rid of it.
> 
> Should I remove from the other SoCs as well?

We have the requirement that a newer kernel must work with all the older
DTBs.  But I haven't heard too much about the opposite - a newer DTB
needs to work with all the older kernel.  If that's case, we can remove
it from other SoCs as well, since the latest kernel already moves to
generic DMA bindings.

Shawn

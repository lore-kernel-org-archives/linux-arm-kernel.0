From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 30 Mar 2016 20:09:58 +0800
Subject: [PATCH v4] ARM: dts: vf610-zii-dev: Add ZII development board.
In-Reply-To: <dad27c3a958ae97869c606e9e02e2d7b@agner.ch>
References: <1459100733-21552-1-git-send-email-andrew@lunn.ch>
 <56F84FAB.6010005@gmail.com> <20160327223603.GA21605@lunn.ch>
 <dad27c3a958ae97869c606e9e02e2d7b@agner.ch>
Message-ID: <20160330120958.GG28207@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 27, 2016 at 03:48:21PM -0700, Stefan Agner wrote:
> >> > +&uart0 {
> >> > +	pinctrl-names = "default";
> >> > +	pinctrl-0 = <&pinctrl_uart0>;
> >> > +	status = "okay";
> >> > +	dmas = <>;
> >> > +	dma-names = "";
> >>
> >> Why is this dma stuff here ?
> > 
> > We have seen corruption of the serial transmit stream, when the DMA is
> > being used. As a workaround, we disable DMA.
> > 
> 
> For the Colibri VF50/VF61 we used this method too to disable the DMA
> (clearing dma-names). I guess using the device tree deleting
> capabilities would be the more elegant way to do this.
> 
> We have seen such issues too, the DMA implementation of the LPUART
> driver seems to be racy... We are working on fixing that.

In this case, shouldn't the DMA support be disabled in driver before the
issue gets fixed?  I'm saying that we shouldn't manipulate device tree
(i.e.  hardware description) to work around Linux device driver issue.

Shawn

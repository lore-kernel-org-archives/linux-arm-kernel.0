From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 6 Jan 2014 20:43:00 +0800
Subject: [PATCH] ARM: imx: Explicitly pass the active level of the PHY
 reset
In-Reply-To: <20140106111428.GF27432@n2100.arm.linux.org.uk>
References: <1388750156-23208-1-git-send-email-festevam@gmail.com>
 <20140103120712.GE25079@S2101-09.ap.freescale.net>
 <20140104054702.GA6243@quad.lixom.net>
 <CAOesGMhDUZ6WVCoh50nNYZt+WMQvaWupHLHdjBz68kUaoPxnjQ@mail.gmail.com>
 <20140106022419.GA26128@S2101-09.ap.freescale.net>
 <20140106111428.GF27432@n2100.arm.linux.org.uk>
Message-ID: <20140106124258.GA31158@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 11:14:28AM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 06, 2014 at 10:24:23AM +0800, Shawn Guo wrote:
> > This is a typical example that we did not implement device tree
> > bindings perfectly right in the first place, and we have to live with it
> > forever.  If someday there is board design using an active high PHY
> > reset, we basically have to introduce another property for it.
> 
> Yes and no.  That third number in the property is always zero at present,
> right?  If so, just define zero to mean "the default level of reset"
> which would be the -rc6 behaviour.
> 
> Then you can define non-zero values to mean "explicitly state the level".

This is not nice either, because the third number in *-gpios property is
already defined by gpio bindings: 

  Documentation/devicetree/bindings/gpio/gpio.txt
  Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt

Shawn

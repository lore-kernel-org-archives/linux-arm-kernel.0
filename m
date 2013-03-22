From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 21:04:54 +0000
Subject: [PATCH v4 0/5] move s3c24xx-irq to drivers/irqchip and add dt
 support
In-Reply-To: <201303221843.37668.heiko@sntech.de>
References: <201303221843.37668.heiko@sntech.de>
Message-ID: <201303222104.54225.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Heiko St?bner wrote:
> As suggested by Rob Herring move back to get the parent releationship from dt
> like in the first versions, but set the handler from the interrupt property
> rather than from a specific list.
> 
> This version also implements (hopefully correctly) an idea from him and
> Arnd Bergmann to have the parent relationship not described in the controller
> node but the device nodes instead.
> 
> Therefore the main controller continues to use a two-cell descriptor to set
> hwirq and trigger type but the sub-controller switches to a three-cell
> descriptor where the third bit describes the hwirq of its parent irq in the
> main controller.
> 
> As a result a serial node would then look like:
>         serial at 50000000 {
>                 compatible = "samsung,s3c2410-uart";
>                 reg = <0x50000000 0x4000>;
>                 interrupt-parent = <&subintc>;
>                 interrupts = <0 4 28>, <1 4 28>;
>         };
> 
> Tested on a s3c2416-based board.
> 
> As it depends on changes already pending for 3.10 it should probably go thru
> the samsung tree.

Hi Heiko,

I should probably read the original discussion thread again. I already commented
on the binding here, but I may have missed something important that led to
it being the way it is now.

	Arnd

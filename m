From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 24 Sep 2015 18:27:19 +0200
Subject: [PATCH] ARM: at91/dt: pullup dbgu rx instead of tx
In-Reply-To: <5604154E.6050404@lysator.liu.se>
References: <1443105855-15738-1-git-send-email-peda@lysator.liu.se>
 <20150924144753.GY4287@piout.net> <5604154E.6050404@lysator.liu.se>
Message-ID: <20150924162719.GZ4287@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/09/2015 at 17:22:54 +0200, Peter Rosin wrote :
> I just noticed that other ports have the same problem in sama5d3.dtsi. E.g.
> 
> 	uart1 {
> 		pinctrl_uart1: uart1-0 {
> 			atmel,pins =
> 				<AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_NONE   /* conflicts with TWD0, ISI_VSYNC */
> 				 AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;      /* conflicts with TWCK0, ISI_HSYNC */
> 		};
> 	};
> 
> Given that the original bug I found spread all over the map, it seems
> like someone was confused when the pull-ups were originally added.
> Someone (else?) at Atmel needs to audit this so that pull-ups are
> added on the rx-pins instead of the tx-pins.
> 

Sure, that is the plan!
Thanks again for the report.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

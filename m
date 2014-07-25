From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Fri, 25 Jul 2014 10:36:45 +0200
Subject: [PATCH] ARM: at91: at91sam9x5: sets NPCS0 (PA14) back to GPIO
In-Reply-To: <20140725083053.GD9532@piout.net>
References: <1405074175-22444-1-git-send-email-voice.shen@atmel.com>
 <53D10C50.50305@aksignal.cz> <20140724162645.4e19c26c@bbrezillon>
 <53D12103.3020103@aksignal.cz> <20140724175848.44f5da10@bbrezillon>
 <53D1F5D0.1080006@aksignal.cz> <20140725083053.GD9532@piout.net>
Message-ID: <20140725103645.7fbf5b63@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Fri, 25 Jul 2014 10:30:54 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Hi,
> 
> On 25/07/2014 at 08:14:40 +0200, Ji?? Prchal wrote :
> > I'm using custom board. My spi node:
> > 			spi0: spi at f0000000 {
> 
> You should override the pinctrl here as you are using gpios for the cs.
> 				pinctrl-0 = <&pinctrl_spi0_custom>;

I guess you meant:
			pinctrl-0 <&pinctrl_spi0 &pinctrl_spi0_custom>;

I suggested the same thing, however I'm pretty sure this is not the
source of the problem. As I said, gpio_request already mux the
associated pin to GPIO function.

Best Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

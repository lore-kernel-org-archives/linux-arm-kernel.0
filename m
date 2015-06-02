From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 2 Jun 2015 19:04:35 +0200
Subject: [PATCH v2 2/2] clk: at91: add Flexcom clock
In-Reply-To: <62cb26952d0688c6f37ad84d253d5302818a20ae.1433264017.git.cyrille.pitchen@atmel.com>
References: <cover.1433264017.git.cyrille.pitchen@atmel.com>
 <62cb26952d0688c6f37ad84d253d5302818a20ae.1433264017.git.cyrille.pitchen@atmel.com>
Message-ID: <20150602190435.4698a4db@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyrille,

On Tue, 2 Jun 2015 18:57:19 +0200
Cyrille Pitchen <cyrille.pitchen@atmel.com> wrote:

> This driver supports the new Atmel Flexcom. The Flexcom is a wrapper which
> integrates one SPI controller, one I2C controller and one USART. Only one
> function can be enabled at a time. This driver selects the function once for
> all, when the Flexcom is probed, according to the value of the new
> "atmel,flexcom-mode" device tree property.
> 
> This driver has chosen to present the Flexcom to the system as a clock so the
> implementation is seamless for the existing Atmel SPI, I2C and USART drivers.

Could detail a bit more why you chose to represent this flexcom IP as
a clock device ?

I don't like to use this 'DT should represent real hardware' argument,
but to me, it looks like you're trying to use a false hardware
representation to avoid changing the peripheral drivers code, which is
wrong since the DT is supposed to represent the hardware blocks.

How about representing the flexcom as an MFD instead ?

Best Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

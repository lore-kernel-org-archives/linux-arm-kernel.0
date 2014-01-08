From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Jan 2014 11:40:14 +0100
Subject: [PATCH v4 1/5] mfd: omap-usb-host: Update DT clock binding
 information
In-Reply-To: <52CD2807.9000200@ti.com>
References: <1389161742-10533-1-git-send-email-rogerq@ti.com>
 <4812867.NuB3hNkV9d@wuerfel> <52CD2807.9000200@ti.com>
Message-ID: <4840680.vVGZYBJBID@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 January 2014 15:57:19 Roger Quadros wrote:
> It is a clock gate defined like so in the DT clock data
> 
> on OMAP4
>         init_60m_fclk: init_60m_fclk {
>                 #clock-cells = <0>;
>                 compatible = "ti,divider-clock";
>                 clocks = <&dpll_usb_m2_ck>;
>                 reg = <0x0104>;
>                 ti,dividers = <1>, <8>;
>         };
> 
> on OMAP5
>         l3init_60m_fclk: l3init_60m_fclk {
>                 #clock-cells = <0>;
>                 compatible = "ti,divider-clock";
>                 clocks = <&dpll_usb_m2_ck>;
>                 reg = <0x0104>;
>                 ti,dividers = <1>, <8>;
>         };
> 
> So you can see that it is the same thing with a different name.

Right, but init_60m_fclk is the name of the clock output of the
divider here, which is /not/ what you should put in the "clock-names"
property of the consumer. The clock input name should reflect what
the clock is used for instead.

	Arnd

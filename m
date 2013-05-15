From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 May 2013 16:10:22 +0200
Subject: [RFC PATCHv3 2/6] arm: Add device trees for TI-Nspire
In-Reply-To: <1368332581-94691-3-git-send-email-dt.tangr@gmail.com>
References: <1368332581-94691-1-git-send-email-dt.tangr@gmail.com>
 <1368332581-94691-3-git-send-email-dt.tangr@gmail.com>
Message-ID: <201305151610.23145.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 12 May 2013, Daniel Tang wrote:
> +
> +                       timer0: timer at 900C0000 {
> +                               reg = <0x900C0000 0x1000>;
> +
> +                               clocks = <&timer_clk>;
> +                               clock-names = "timer_clk";
> +                       };
> +
> +                       timer1: timer at 900D0000 {
> +                               reg = <0x900D0000 0x1000>;
> +                               interrupts = <19>;
> +
> +                               clocks = <&timer_clk>;
> +                               clock-names = "timer_clk";
> +                       };


> +                               clocks = <&apb_pclk>;
> +                               clock-names = "apb_pclk";
> +                       };

Why do you provide "clock-names" here? Do those devices have multiple
clock inputs? It's normally easier to just use the default clock
input.

	Arnd

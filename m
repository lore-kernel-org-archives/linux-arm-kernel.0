From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Oct 2015 22:49:12 +0100
Subject: [PATCH v2] arm64: dts: Added syscon-reboot node for FSL's LS2085A
 SoC
In-Reply-To: <1446066584-3738-1-git-send-email-German.Rivera@freescale.com>
References: <1446066584-3738-1-git-send-email-German.Rivera@freescale.com>
Message-ID: <3919319.0f6zV1T7g0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 October 2015 16:09:44 J. German Rivera wrote:
> +       rst_ccsr: rstccsr at 1E60000 {
> +               compatible = "syscon";
> +               reg = <0x0 0x1E60000 0x0 0x10000>;
> +       };
> +
> 

What does 'rstccsr' stand for? Is this by chance a reset controller?

If so, we probably want a real driver for it rather than just a
syscon.

	Arnd

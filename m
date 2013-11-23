From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 23 Nov 2013 18:57:46 +0100
Subject: Fwd: [PATCH 7/8] watchdog: davinci: add "clocks" property
In-Reply-To: <527A28E8.4010204@ti.com>
References: <1383680783-12114-8-git-send-email-ivan.khoronzhuk@ti.com>
 <527A28E8.4010204@ti.com>
Message-ID: <201311231857.47104.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 November 2013, ivan.khoronzhuk wrote:
> @@ -7,6 +7,10 @@ Required properties:
>  
>  - reg : Should contain WDT registers location and length
>  
> +- clocks: phandle reference to the controller clock.
> +         Required only for Keystone arch.
> +         See clock-bindings.txt
> +
>  Optional properties:
>  
>  - timeout-sec:         Contains the watchdog timeout in seconds

I think it should really be listed under "Optional properties" and the
reference to Keystone removed. Note how the binding would need
to change otherwise if another platform started to use the clock, which
is a little silly.

	Arnd

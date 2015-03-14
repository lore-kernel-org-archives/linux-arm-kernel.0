From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Mar 2015 22:25:03 +0100
Subject: [PATCH 05/10] ARM: zx: bring up the secondary core
In-Reply-To: <1426333785-3952-6-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <1426333785-3952-6-git-send-email-jun.nie@linaro.org>
Message-ID: <2076674.uPo0q8sg2C@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 March 2015 19:49:40 Jun Nie wrote:
> +
> +       /*
> +        * This is really belt and braces; we hold unintended secondary
> +        * CPUs in the holding pen until we're ready for them.  However,
> +        * since we haven't sent them a soft interrupt, they shouldn't
> +        * be there.
> +        */
> +       write_pen_release(cpu);
> +
> 

Why do you need the holding pen on this platform? Is there a firmware
bug or just missing hardware support for proper SMP power management?

	Arnd

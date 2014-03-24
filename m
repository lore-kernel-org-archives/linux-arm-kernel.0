From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Mar 2014 11:38:21 +0000
Subject: [PATCH 7/8] tty/serial: add arm64 semihosting earlycon
In-Reply-To: <1395436128-11244-8-git-send-email-robherring2@gmail.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <1395436128-11244-8-git-send-email-robherring2@gmail.com>
Message-ID: <20140324113821.GF3850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 09:08:47PM +0000, Rob Herring wrote:
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 81bdd52..e96e2ba 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -888,6 +888,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  		uart[8250],mmio,<addr>[,options]
>  		uart[8250],mmio32,<addr>[,options]
>  		pl011,<addr>
> +		smh
>  			Start an early, polled-mode console on a serial port
>  			at the specified I/O port or MMIO address. 8250
>  			MMIO inter-register address stride is either 8-bit

Same comment as per a previous patch, "smh" does not take any parameters
at all here.

> --- /dev/null
> +++ b/drivers/tty/serial/earlycon-arm-semihost.c
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + * Author: Catalin Marinas <catalin.marinas@arm.com>

Nitpick: author should be Mark Zyngier <marc.zyngier@arm.com> as per
commit 0492f72508184 (arm64: early_printk: add support for FastModel
console output)

-- 
Catalin

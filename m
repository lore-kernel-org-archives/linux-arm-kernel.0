From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Dec 2012 20:00:11 +0000
Subject: [PATCH v2 3/6] ARM: psci: add devicetree binding for describing
 PSCI firmware
In-Reply-To: <1355762141-29616-4-git-send-email-will.deacon@arm.com>
References: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
 <1355762141-29616-4-git-send-email-will.deacon@arm.com>
Message-ID: <201212172000.11850.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 December 2012, Will Deacon wrote:
> +
> + - function-base : The base ID from which the functions are offset.
> +
> +Main node optional properties:
> +
> + - cpu_suspend   : Offset of CPU_SUSPEND ID from function-base
> +
> + - cpu_off       : Offset of CPU_OFF ID from function-base
> +
> + - cpu_on        : Offset of CPU_ON ID from function-base
> +
> + - migrate       : Offset of MIGRATE ID from function-base

What is the benefit of the "function-base" property over just having
32 bit IDs for each function. For all I can tell, the interface does
not rely on the numbers to be consecutive, so removing the function-base
attribute would make the binding simpler as well as more flexible.

	Arnd

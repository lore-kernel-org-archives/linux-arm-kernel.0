From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Jul 2011 08:44:14 +0100
Subject: [PATCH 4/7] ARM: EXYNOS4: Support early wakeup while entering
	sleep mode
In-Reply-To: <017d01cc378a$c017edf0$4047c9d0$%kim@samsung.com>
References: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
	<1308732405-16664-5-git-send-email-kgene.kim@samsung.com>
	<20110622145715.GS23234@n2100.arm.linux.org.uk>
	<007401cc3242$48947160$d9bd5420$%kim@samsung.com>
	<20110624093750.GD23234@n2100.arm.linux.org.uk>
	<20110624102246.GF23234@n2100.arm.linux.org.uk>
	<017d01cc378a$c017edf0$4047c9d0$%kim@samsung.com>
Message-ID: <20110701074414.GD21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2011 at 10:03:48AM +0900, Kukjin Kim wrote:
> Russell thanks.
> 
> How do you think to add following for handling failure of cpu_suspend?
> 
> +	mov	r0, #-1

No.  -1 is not an error code, and I refuse to create functions which
use an explicit -1 as a return code to indicate failure.

The code is designed so that the called finisher function can return
a valid errno value.

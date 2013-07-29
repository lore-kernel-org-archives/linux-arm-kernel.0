From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Jul 2013 14:26:24 +0100
Subject: ZTEXTADDR
In-Reply-To: <CANEcUBWQgoEQ2nrzV4F-dbPzQQYW1NqFwGxwGMOBzo3g-aAuug@mail.gmail.com>
References: <CANEcUBWQgoEQ2nrzV4F-dbPzQQYW1NqFwGxwGMOBzo3g-aAuug@mail.gmail.com>
Message-ID: <20130729132624.GJ24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 09:12:58PM +0800, zhaobin xv wrote:
> hi
>    I see some blogs aboot ZTEXTADDR
> in linux 2.4.18 :
> in kernel/arch/arm/boot/Makefile?
>  ifeq ($(CONFIG_ARCH_S3C2410),y)
> ZTEXTADDR = 0x30008000
> ZRELADDR = 0x30008000
> endif
> but
> in linux 2.6. :
> in kernel/arch/arm/boot/Makefile:
> ZTEXTADDR = 0
> 
> 
> I want to know why to change?
> ZTEXTADDR is link addr or phs addr?

ZTEXTADDR is mostly irrelevant now for everyone who places the kernel
image in RAM, because the entire thing is position independent.

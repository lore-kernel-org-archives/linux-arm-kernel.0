From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 May 2012 09:23:07 +0000
Subject: [PATCH 2/2] ARM: mmp: add io head file
In-Reply-To: <1336360249-29963-2-git-send-email-haojian.zhuang@gmail.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <1336360249-29963-2-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <201205070923.07418.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 May 2012, Haojian Zhuang wrote:
> +#ifndef __ARCH_MMP_IO_H
> +#define __ARCH_MMP_IO_H
> +
> +#define IO_SPACE_LIMIT 0xffffffff
> +
> +#define __io(a)                ((a) & IO_SPACE_LIMIT)
> +
> +#endif

NAK

If you don't have ISA or PCI devices, don't define these.

More importantly, never define them to an incorrect value. This
definition will cause an oops by NULL pointer dereferences for any
access to ISA devices such as writing to /dev/port, or loading a
module that probes the ISA ports.

	Arnd

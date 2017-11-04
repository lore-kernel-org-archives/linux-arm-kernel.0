From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 4 Nov 2017 12:36:32 +0100
Subject: [patch v11 1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <1509724449-26221-2-git-send-email-oleksandrs@mellanox.com>
References: <1509724449-26221-1-git-send-email-oleksandrs@mellanox.com>
 <1509724449-26221-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <20171104113632.GC24583@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 05:54:06PM +0200, Oleksandr Shamray wrote:
> diff --git a/include/uapi/linux/jtag.h b/include/uapi/linux/jtag.h
> new file mode 100644
> index 0000000..0b25a83
> --- /dev/null
> +++ b/include/uapi/linux/jtag.h
> @@ -0,0 +1,117 @@
> +/*
> + * JTAG class driver
> + *
> + * Copyright (c) 2017 Mellanox Technologies. All rights reserved.
> + * Copyright (c) 2017 Oleksandr Shamray <oleksandrs@mellanox.com>
> + *
> + * Released under the GPLv2/BSD.
> + * SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause

Minor nit, this should go on the first line of the .h file now, to match
the rest of the kernel (just happened, not your fault.)

Also, uapi files are not just GPLv2, they have the userspace exception,
so this should just be:
	SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
no need to add any BSD stuff to it at all.

thanks,

greg k-h

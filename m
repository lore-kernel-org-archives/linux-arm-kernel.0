From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 26 Nov 2018 20:19:46 +0100
Subject: [PATCH 2/4] arm64: hyperv: Add support for Hyper-V as a hypervisor
In-Reply-To: <20181122031059.16338-2-kys@linuxonhyperv.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-2-kys@linuxonhyperv.com>
Message-ID: <20181126191946.GB32208@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 03:10:57AM +0000, kys at linuxonhyperv.com wrote:
> --- /dev/null
> +++ b/arch/arm64/hyperv/hv_hvc.S
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Using SPDX is good, but:

> +
> +/*
> + * Microsoft Hyper-V hypervisor invocation routines
> + *
> + * Copyright (C) 2018, Microsoft, Inc.
> + *
> + * Author : Michael Kelley <mikelley@microsoft.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.

No need for these two paragraphs at all.  If you add them now, someone
will just come along later and rip them out.  Please don't include them
in the first place.

Not to mention the first paragraph doesn't make sense, think about
"which" version 2 the FSF published (hint, there was 5 or 7 or so...)
That's why we have one in the kernel tree for everyone to rely on.

thanks,

greg k-h

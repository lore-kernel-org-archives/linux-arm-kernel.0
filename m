From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 25 Jul 2012 12:23:59 -0300
Subject: [PATCH v2 3/3] ARM: imx_v6_v7_defconfig: Select MXS_DMA
In-Reply-To: <CAMiH66EA4O0s8hfXkr_SJ56+q7eZ8w0=3C1r_C+m2Os1RxprmA@mail.gmail.com>
References: <1343215100-24005-1-git-send-email-festevam@gmail.com>
 <1343215100-24005-3-git-send-email-festevam@gmail.com>
 <CAMiH66EA4O0s8hfXkr_SJ56+q7eZ8w0=3C1r_C+m2Os1RxprmA@mail.gmail.com>
Message-ID: <CAOMZO5BfT+_7x4F96Kvqtq5STXxw2Y9CxbCCAc_UnZ-3wy0qxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2012 at 12:05 PM, Huang Shijie <shijie8@gmail.com> wrote:

> Is this patch needed? The mxs-dma only has one user, the gpmi-nand in mx6q.
> this patch makes the kernel built-in the mxs-dma, even the gpmi-nand
> is not enabled.

Well, as the driver currently stands: yes, it is needed.

Without CONFIG_MXS_DMA, the GPMI driver cannot even be built.

This is why I thought that 'select MXS_DMA' was the way to go, but
according to the thread you pointed me at, it was Nacked by Shawn.

Regards,

Fabio Estevam

From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 26 Jul 2012 10:24:41 +0800
Subject: [PATCH v2 3/3] ARM: imx_v6_v7_defconfig: Select MXS_DMA
In-Reply-To: <CAOMZO5BfT+_7x4F96Kvqtq5STXxw2Y9CxbCCAc_UnZ-3wy0qxg@mail.gmail.com>
References: <1343215100-24005-1-git-send-email-festevam@gmail.com>
 <1343215100-24005-3-git-send-email-festevam@gmail.com>
 <CAMiH66EA4O0s8hfXkr_SJ56+q7eZ8w0=3C1r_C+m2Os1RxprmA@mail.gmail.com>
 <CAOMZO5BfT+_7x4F96Kvqtq5STXxw2Y9CxbCCAc_UnZ-3wy0qxg@mail.gmail.com>
Message-ID: <CAMiH66FUxiw0B8iD5rYi=nUX0VYZBzOKifXKfTqd1RmSHhC80g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2012 at 11:23 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Jul 25, 2012 at 12:05 PM, Huang Shijie <shijie8@gmail.com> wrote:
>
>> Is this patch needed? The mxs-dma only has one user, the gpmi-nand in mx6q.
>> this patch makes the kernel built-in the mxs-dma, even the gpmi-nand
>> is not enabled.
>
> Well, as the driver currently stands: yes, it is needed.
>
> Without CONFIG_MXS_DMA, the GPMI driver cannot even be built.
But you have added "depend on MXS_DMA". So If you do not select the
mxs-dma, you can not see the
gpmi-nand.
that's why i think this patch is not needed.

Huang Shijie

>
> This is why I thought that 'select MXS_DMA' was the way to go, but
> according to the thread you pointed me at, it was Nacked by Shawn.
>
> Regards,
>
> Fabio Estevam

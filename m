From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 19 May 2017 14:07:28 -0300
Subject: [CFT] Always enable SMP mode on MP capable CPUs
In-Reply-To: <CAOMZO5Da2R2_t2nU+MdrJiSzvcBQKS4pwYS96r4UyfGc8DtWww@mail.gmail.com>
References: <20170518105209.GN22219@n2100.armlinux.org.uk>
 <CAOMZO5Da2R2_t2nU+MdrJiSzvcBQKS4pwYS96r4UyfGc8DtWww@mail.gmail.com>
Message-ID: <CAOMZO5Dc=i7UdQH=r5RRr_4GmyZZT+rh7BTNV4WbfqKvtVDfsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 3:09 PM, Fabio Estevam <festevam@gmail.com> wrote:

> I tested this patch on a mx6ul, which is CortexA7 UP using USB serial
> download mode.
>
> In this boot mode the ROM code does not set the SMP bit and I can
> notice a very slow boot progress with CONFIG_SMP=n with an original
> 4.12-rc1.
>
> With this patch applied it boots with the correct speed, so:

However the kernel still takes a long time to decompress when the
bootloader or ROM does not set the SMP bit.

After it decompress, then it boots quickly.

Should the SMP bit be set inside arch/arm/boot/compressed/head.S?

Thanks

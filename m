From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 13 Mar 2012 22:34:18 +0800
Subject: implementing "suspend to ram" on cortex A8 based on linux 3.0.8
In-Reply-To: <CAFawwkVuCTijwLr6UWVRh9XNGCt-8brr2f4aDrpM_YwkWSGP+A@mail.gmail.com>
References: <CAFawwkXQhyj+c8LEDnD7q4mXDJV2jYCAHV0tBrqxrEaNGk+_0w@mail.gmail.com>
 <CACNz9cVbULxVSGvo60V+JLL=15BDEaYwgd5k9ZMNu09Kfwz4WQ@mail.gmail.com>
 <CAFawwkWQd=y=kVm97UjSs37=-MRmJiy9f7sy8ChYzCHZ9Y-gyA@mail.gmail.com>
 <CAFawwkVuCTijwLr6UWVRh9XNGCt-8brr2f4aDrpM_YwkWSGP+A@mail.gmail.com>
Message-ID: <CAGsJ_4yDjDLSPwXubcecmCzpeJTwvGz30-awSAZfC+YtTwB_-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi yang,

? 2012?3?10? ??10:37?yang gqyang <hustgqyang@gmail.com> ???
> ?Thanks for your comment.
> ?Finally, i find out that i made a mistake. ?The uart(8250) have not been
> ?restore after resume, instead, it use the configuration got from boot. The
> ?uart have not been restored correctly, so that "ls" can not output result
> ?correctly resulting in it seems that the busybox can not work correctly.
> ?Now, i still have a question about the uart: why the "printk" can work
> ?correctly, but the "printf" not?
>
> ?Before this, i believe that the "printk" work correctly, then the uart
> ?work ok. but now, i ?need more reconsidaration about
> ?the relation between the "printk", "printf" and "uart".
> ?Can anyone give me some suggestion? Any comment is welcome, thanks a
> ?lot.

printk use "struct console" driver, it doesn't depend on a device node
for userspace.
printf actaully depends on uart_driver and a /dev/ttySx device node,
stdout and stderr are redirected to /dev/ttySx
uart is just a hardware which can be a tty or kernel console output.


>
>
-barry

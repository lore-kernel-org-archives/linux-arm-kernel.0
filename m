From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 17 Dec 2012 20:39:17 +0800
Subject: [PATCH] arm: vexpress: hook platform_data to clcd_pl11x by amba
 bus_notify
In-Reply-To: <1355747549.2978.5.camel@hornet>
References: <1355549964-12893-1-git-send-email-21cnbao@gmail.com>
 <1355747549.2978.5.camel@hornet>
Message-ID: <CAGsJ_4wiYWe9YcQx_H5bmMtAsV=V9em6n8bKXxnb29CisK_WiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/12/17 Pawel Moll <pawel.moll@arm.com>
>
> On Sat, 2012-12-15 at 05:39 +0000, Barry Song wrote:
> > From: Barry Song <Baohua.Song@csr.com>
> >
> > when using dtb to boot v2p-ca9, clcd probe will fail due to missed
> > the platform_data:
> > clcd-pl11x: probe of 10020000.clcd failed with error -22
> > this patch hooks the platform_data to clcd and make lcd of v2p-ca9
> > can work while booting vexpress by DTB.
> > Tested on qemu by "qemu-system-arm -M vexpress-a9 -m 512M -kernel
> > zImage -dtb ./vexpress-v2p-ca9.dtb"
> >
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> Thanks for your work, however there are some problems with your code,
> especially if you look at the changes being merged right now for 3.8
> kernel... The clocking implementation is completely changed (actually
> you should not need any extra CLCD information now), and as the auxdata
> for devices population is removed, you could use it instead of the -
> slightly strange to my taste - notifier-based solution.
>

 i see, i just tried to boot up your clcd on qemu using 3.7 release
and didn't take a look at your changes for 3.8.

> Now having said all that, I'm hoping to get comprehensive solution for
> DT-based VE display devices ready in time for 3.9, which will sort out
> the issue once for all.

well, look forward to see that. but as i said, i will use 3.7 for
these monthes, booting your board by dt and hope to back port yours to
my 3.7 later.

>
> Pawe?

-barry

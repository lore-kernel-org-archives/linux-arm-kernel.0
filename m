From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 21 Oct 2012 09:35:51 +0200
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <20121020141136.GA6433@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com>
Message-ID: <20121021073551.GA4735@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 20, 2012 at 04:27:19PM +0000, Paul Walmsley wrote:
> Here's the console log from the boot test here:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/20121017205513/boot/am335xbone/am335xbone_log.txt
> 
> And here's the kernel config and uImage+DTB from the boot test here:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/20121017205513/build/am33xx_only/
> 
> In terms of differences from your setup, looks like we have different 
> X-Loader and u-boot; it wouldn't surprise me if we have different kernel 
> configs too.

Paul,

You are using an obsolete u-boot and the "legacy" appended dtb
method. It was my understanding that that way is just a temporary hack
in case the boot loader does not support dtb.

Now that u-boot has the proper support, using the dtb method is the
"offical" boot method, AFAICT. At least, that is what people are
saying on the arm list. So I think that if you want to test whether a
particular board is booting correctly, it is more useful to try the
offical method.

People keep saying, the beaglebone works fine with v3.7-rc1, but it
isn't true. Now v3.7-rc2 is out, and the gpmc issue still has not been
fixed, and no one is doing anything about it either.

When I read your report, it gave me a much rosier picture than is
actually the case WRT the beaglebone.

Thanks,
Richard

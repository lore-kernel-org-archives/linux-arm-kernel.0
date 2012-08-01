From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Wed, 1 Aug 2012 11:16:15 +0530
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <20120801052947.GA2400@roeck-us.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <20120801033559.GB2323@roeck-us.net>
 <20120801045010.GC1672@S2100-06.ap.freescale.net>
 <201208010700.54829.marex@denx.de>
 <20120801052947.GA2400@roeck-us.net>
Message-ID: <CAM=Q2csm1m8DCd8__NAUCmk6AN=Czg_=nm4c3ervAgOhOtoMTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 1, 2012 at 10:59 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Aug 01, 2012 at 07:00:54AM +0200, Marek Vasut wrote:
>> Dear Shawn Guo,
>>
>> > On Tue, Jul 31, 2012 at 08:35:59PM -0700, Guenter Roeck wrote:
>> > > I think the call to spi_master_put() triggers the call to
>> > > spi_master_release(). If so, kfree() would not be needed at all, and the
>> > > documentation is wrong.
>> >
>> > Also those drivers calling kfree in probe.
>>
>> Looks like that to me ...
>>
> Doesn't seem to be far spread, fortunately. Only spi-davinci.c, spi-imx.c, and
> spi-omap2-mcspi.c

I have a  omapsdp I could patch spi-omap2-mcspi.c  file thanks for the catch.

>as far as I can see, plus the misleading comment in spi.c.
>
> Anyone up for writing some patches ? If not, I'll do it.
>
> Thanks,
> Guenter
>
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

From: anton@enomsg.org (Anton Vorontsov)
Date: Sun, 17 Feb 2013 17:02:07 -0800
Subject: [RFC] ARM: sa1100: collie-battery.c: include platform_device.h
 directly
In-Reply-To: <CAAQYJAt0CGi3ZLO8eoYj64Ay06Yry_w8A6aPHHH1tpeyp=Ns4g@mail.gmail.com>
References: <1361038560-3690-1-git-send-email-andrea.adami@gmail.com>
 <20130216230010.GG1741@lizard.sbx05280.losalca.wayport.net>
 <CAAQYJAt0CGi3ZLO8eoYj64Ay06Yry_w8A6aPHHH1tpeyp=Ns4g@mail.gmail.com>
Message-ID: <20130218010207.GA31969@lizard.gateway.2wire.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 01:13:46AM +0100, Andrea Adami wrote:
> On Sun, Feb 17, 2013 at 12:00 AM, Anton Vorontsov <anton@enomsg.org> wrote:
> > Hi Andrea,
> >
> > On Sat, Feb 16, 2013 at 07:16:00PM +0100, Andrea Adami wrote:
> >> Initial try to fix compilation error
> >
> > Things are a bit more complex...
> >
> >> linux/include/linux/mfd/mcp.h:22:16: error: field 'attached_device' has incomplete type
> >
> > You have to add #include <linux/device.h> into mfd/mcp.h. This will add
> > struct device and...
> >
> Bingo.Adding it solves all following errors, no need for further inclusions.
> 
> >> linux/include/linux/mfd/mcp.h:48:23: error: field 'drv' has incomplete type
> >
> > struct device_driver.
> >
> >> linux/include/linux/mfd/ucb1x00.h:137:17: error: field 'dev' has incomplete type
> >
> > Same here, the file ucb1x00.h needs #include <linux/device.h>.
> >
> Seems not needed, mcp.h is included by ucb1x00.h

Generally, we don't depend on indirect inclusions. But if it doesn't harm
anyhow so far, we may not bother with this.

Thanks,

Anton

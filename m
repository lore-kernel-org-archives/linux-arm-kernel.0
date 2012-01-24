From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 24 Jan 2012 22:01:33 +0900
Subject: [PATCH 3/3] S3C2443: add power domain for usb phy
In-Reply-To: <201201241131.01437.heiko@sntech.de>
References: <201201082156.44142.heiko@sntech.de>
 <201201241113.00387.heiko@sntech.de>
 <20120124101510.GH27414@legolas.emea.dhcp.ti.com>
 <201201241131.01437.heiko@sntech.de>
Message-ID: <02ff01ccda98$4c424f40$e4c6edc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Am Dienstag, 24. Januar 2012, 11:15:11 schrieb Felipe Balbi:
> > On Tue, Jan 24, 2012 at 11:13:00AM +0100, Heiko St?bner wrote:
> > > sorry for mail spam :-)
> > >
> > > Am Dienstag, 24. Januar 2012, 10:51:31 schrieb Felipe Balbi:
> > > > On Tue, Jan 24, 2012 at 10:50:14AM +0100, Heiko St?bner wrote:
> > > > > Hi Felipe,
> > > > >
> > > > > Am Dienstag, 24. Januar 2012, 10:38:32 schrieb Felipe Balbi:
> > > > > > Hi,
> > > > > >
> > > > > > On Sun, Jan 08, 2012 at 09:59:02PM +0100, Heiko St?bner wrote:
> > > > > > > The phy-power-handling is common to S3C2443/2416/2450, so
> > > > > > > introduce a s3c2443-pm-common.c to handle this for all of them.
> > > > > > >
> > > > > > > This makes it possible to remove the raw write to the
> > > > > > > PWRCFG-register from the s3c-hsudc driver.
> > > > > > >
> > > > > > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > > > >
> > > > > > I believe this doesn't really depend on previous patches (??) In
> > > > > > that
> > > > >
> > > > > > case, it can be carried with s3c's tree:
> > > > > it does depend on the previous patch [2/3], as the device power
> > > > > domain is controlled through the runtime-pm subsystem whose calls
> > > > > were added in it.
> > > >
> > > > then I will need proper acks to carry this patch.
> > >
> > > another possibility would be to have patch 2 and 3 get in through the
> > > samsung tree, as the majority of the change lies on this side (i.e.
> > > introducing a new file in plat-s3c24xx)
> >
> > yet another one, would be to defer patch 3/3 by one merge window ;-)
> 
> also fine by me ;-)
> 
> But let's see first what Kgene says.

Hi all,

Sorry for join lately on this.

I think we need to implement more pm domain for s3c24xx as well usbphy. So if Felipe is ok, I'd like to handle Heiko's 2nd and 3rd
patches in my tree. Of course, I need Felipe's ack before that.
BTW, frankly, I'm not sure we can finish supporting pm domain for all of s3c24xx for v3.4 :)

And, Heiko, I don't know why its name is -pm-common.c, how about just -pm.c like others? Yes, when all of s3c24xx can be supported
on that, just s3c24xx-pm.c would be better. But right now, s3c2443-pm.c is ok or we need to think about that again. Because as I
said, I'm doing merge s3c24xx directories and it's almost done.
And the form of subject would be 'ARM: S3C24XX: ...', actually there were discussions about that.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

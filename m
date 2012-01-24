From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Tue, 24 Jan 2012 14:27:21 +0100
Subject: [PATCH 3/3] S3C2443: add power domain for usb phy
In-Reply-To: <20120124130754.GR27414@legolas.emea.dhcp.ti.com>
References: <201201082156.44142.heiko@sntech.de>
 <02ff01ccda98$4c424f40$e4c6edc0$%kim@samsung.com>
 <20120124130754.GR27414@legolas.emea.dhcp.ti.com>
Message-ID: <201201241427.21939.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 24. Januar 2012, 14:07:56 schrieb Felipe Balbi:
> Hi,
> 
> On Tue, Jan 24, 2012 at 10:01:33PM +0900, Kukjin Kim wrote:
> > Heiko St?bner wrote:
> > > Am Dienstag, 24. Januar 2012, 11:15:11 schrieb Felipe Balbi:
> > > > On Tue, Jan 24, 2012 at 11:13:00AM +0100, Heiko St?bner wrote:
> > > > > sorry for mail spam :-)
> > > > > 
> > > > > Am Dienstag, 24. Januar 2012, 10:51:31 schrieb Felipe Balbi:
> > > > > > On Tue, Jan 24, 2012 at 10:50:14AM +0100, Heiko St?bner wrote:
> > > > > > > Hi Felipe,
> > > > > > > 
> > > > > > > Am Dienstag, 24. Januar 2012, 10:38:32 schrieb Felipe Balbi:
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > > > On Sun, Jan 08, 2012 at 09:59:02PM +0100, Heiko St?bner wrote:
> > > > > > > > > The phy-power-handling is common to S3C2443/2416/2450, so
> > > > > > > > > introduce a s3c2443-pm-common.c to handle this for all of
> > > > > > > > > them.
> > > > > > > > > 
> > > > > > > > > This makes it possible to remove the raw write to the
> > > > > > > > > PWRCFG-register from the s3c-hsudc driver.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > > > > > > 
> > > > > > > > I believe this doesn't really depend on previous patches (??)
> > > > > > > > In that
> > > > > > > 
> > > > > > > > case, it can be carried with s3c's tree:
> > > > > > > it does depend on the previous patch [2/3], as the device power
> > > > > > > domain is controlled through the runtime-pm subsystem whose
> > > > > > > calls were added in it.
> > > > > > 
> > > > > > then I will need proper acks to carry this patch.
> > > > > 
> > > > > another possibility would be to have patch 2 and 3 get in through
> > > > > the samsung tree, as the majority of the change lies on this side
> > > > > (i.e. introducing a new file in plat-s3c24xx)
> > > > 
> > > > yet another one, would be to defer patch 3/3 by one merge window ;-)
> > > 
> > > also fine by me ;-)
> > > 
> > > But let's see first what Kgene says.
> > 
> > Hi all,
> > 
> > Sorry for join lately on this.
> > 
> > I think we need to implement more pm domain for s3c24xx as well
> > usbphy. So if Felipe is ok, I'd like to handle Heiko's 2nd and 3rd
> > patches in my tree. Of course, I need Felipe's ack before that.
> > BTW, frankly, I'm not sure we can finish supporting pm domain for all
> > of s3c24xx for v3.4 :)
> 
> In that case, how about we take things slow ? I can carry pm-runtime
> patch (2/3) and by 3.5 or 3.6 you will only need to touch
> arch/arm/-related code.
> 
> If you guarantee that it won't make it in 3.4, I'm ok carrying
> pm-runtime patch as it won't break anything anyway (I suppose).

Seems reasonable to me. The pm-runtime patch does not break anything - it 
simply does nothing without either some runtime-pm functions or the power 
domain work.

So I would second that we handle the power domain stuff after Kgene got the 
mach directories merged for 3.4, i.e. drop the patch (3/3) for now and I will 
resubmit it when the time comes.


Heiko

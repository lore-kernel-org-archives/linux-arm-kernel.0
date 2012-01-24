From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Tue, 24 Jan 2012 11:13:00 +0100
Subject: [PATCH 3/3] S3C2443: add power domain for usb phy
In-Reply-To: <20120124095130.GA27414@legolas.emea.dhcp.ti.com>
References: <201201082156.44142.heiko@sntech.de>
 <201201241050.14405.heiko@sntech.de>
 <20120124095130.GA27414@legolas.emea.dhcp.ti.com>
Message-ID: <201201241113.00387.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sorry for mail spam :-)

Am Dienstag, 24. Januar 2012, 10:51:31 schrieb Felipe Balbi:
> On Tue, Jan 24, 2012 at 10:50:14AM +0100, Heiko St?bner wrote:
> > Hi Felipe,
> > 
> > Am Dienstag, 24. Januar 2012, 10:38:32 schrieb Felipe Balbi:
> > > Hi,
> > > 
> > > On Sun, Jan 08, 2012 at 09:59:02PM +0100, Heiko St?bner wrote:
> > > > The phy-power-handling is common to S3C2443/2416/2450, so introduce a
> > > > s3c2443-pm-common.c to handle this for all of them.
> > > > 
> > > > This makes it possible to remove the raw write to the PWRCFG-register
> > > > from the s3c-hsudc driver.
> > > > 
> > > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > 
> > > I believe this doesn't really depend on previous patches (??) In that
> > 
> > > case, it can be carried with s3c's tree:
> > it does depend on the previous patch [2/3], as the device power domain is
> > controlled through the runtime-pm subsystem whose calls were added in it.
> 
> then I will need proper acks to carry this patch.
another possibility would be to have patch 2 and 3 get in through the samsung 
tree, as the majority of the change lies on this side (i.e. introducing a new 
file in plat-s3c24xx)

Heiko

From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 11:47:41 -0600
Subject: [PATCH v3 2/2] usb: phy: Add keystone usb phy driver
In-Reply-To: <230CBA6E4B6B6B418E8730AC28E6FC7E0415C5F1@DFLE11.ent.ti.com>
References: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
 <1386627424-373-3-git-send-email-w-kwok2@ti.com>
 <20131210025405.GB20090@saruman.home> <52A72FE4.4020105@ti.com>
 <230CBA6E4B6B6B418E8730AC28E6FC7E0415C5F1@DFLE11.ent.ti.com>
Message-ID: <20131212174741.GD1939@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 11:20:54AM -0600, Kwok, WingMan wrote:
> > -----Original Message-----
> > From: Shilimkar, Santosh
> > Sent: Tuesday, December 10, 2013 10:15 AM
> > To: Balbi, Felipe
> > Cc: Kwok, WingMan; linux-usb at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; Greg Kroah-Hartman
> > Subject: Re: [PATCH v3 2/2] usb: phy: Add keystone usb phy driver
> > 
> > On Monday 09 December 2013 09:54 PM, Balbi, Felipe wrote:
> > > Hi,
> > >
> > > On Mon, Dec 09, 2013 at 05:17:04PM -0500, WingMan Kwok wrote:
> > >> +	ret = usb_add_phy_dev(&k_phy->usb_phy_gen.phy);
> > >> +	if (ret)
> > >> +		return ret;
> > >> +	k_phy->usb_phy_gen.phy.init = keystone_usbphy_init;
> > >> +	k_phy->usb_phy_gen.phy.shutdown = keystone_usbphy_shutdown;
> > >
> > > this *must* be initialized before adding the PHY to the subsystem. So
> > > these two lines must be moved before usb_add_phy_dev().
> > >
> > Make sense. Probably its good idea to repost the $subject patch with above
> > as well as other delay related comment.
> 
> Thanks.  I have updated my patch accordingly.  Please note that the same issue
> exists on drivers/usb/phy/phy-am335x.c also.  If you want, I can send a fix for that.

Will do, thanks for notifying me :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/99d347fa/attachment.sig>

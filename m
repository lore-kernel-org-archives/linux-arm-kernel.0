From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Jun 2012 14:48:05 +0300
Subject: [PATCH 06/17] i2c: omap: improve 1p153 errata handling
In-Reply-To: <20120614111746.GB31187@n2100.arm.linux.org.uk>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-7-git-send-email-balbi@ti.com>
 <20120614111746.GB31187@n2100.arm.linux.org.uk>
Message-ID: <20120614114804.GS13602@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 14, 2012 at 12:17:46PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 14, 2012 at 01:20:39PM +0300, Felipe Balbi wrote:
> > -static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
> > +static int errata_omap3_1p153(struct omap_i2c_dev *dev)
> >  {
> > -	unsigned long timeout = 10000;
> > +	unsigned long	timeout = 10000;
> > +	u16		stat;
> 
> Eww, no, not more of this "lets add tabs to align auto variable
> declarations".  This is detrimental when you add another variable whose
> type is longer than the current indentation - you have to reformat the
> entire block.
> 
> It's really not worth it.  Stick to just using one space, like the rest
> of the kernel code.  Like the code which Linus writes.  And thereby help
> to avoid future "pointless churn" whinges.

fair enough, no need to get so over the top like that, it's just a tab.
Will fix it.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/3663b33e/attachment.sig>

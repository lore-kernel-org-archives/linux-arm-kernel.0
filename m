From: balbi@ti.com (Felipe Balbi)
Date: Wed, 26 Jun 2013 00:00:44 +0300
Subject: [PATCH 1/4] usb: gadget: s3c-hsotg: Allow driver instantiation
 using device tree
In-Reply-To: <5782443.xpFZv1Saq0@flatron>
References: <1372174706-5459-1-git-send-email-t.figa@samsung.com>
 <1372174706-5459-2-git-send-email-t.figa@samsung.com>
 <20130625204632.GB9748@arwen.pp.htv.fi>
 <5782443.xpFZv1Saq0@flatron>
Message-ID: <20130625210044.GD9748@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 10:57:06PM +0200, Tomasz Figa wrote:
> On Tuesday 25 of June 2013 23:46:32 Felipe Balbi wrote:
> > On Tue, Jun 25, 2013 at 05:38:23PM +0200, Tomasz Figa wrote:
> > > This patch adds OF match table to the driver to allow instantiating it
> > > using device tree.
> > > 
> > > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > 
> > when will this driver get merged into dwc2 ?
> 
> What's dwc2? I can only see dwc3 in mainline kernel tree and it doesn't 
> seem to be compatible with s3c-hsotg.

drivers/staging/dwc2/

That's the same IP you're using Paul Zimmerman (now in Cc) is working
towards getting that out of staging. It currently has only host mode, so
plugging your code in there shouldn't be too difficult.

OTOH, it might be better to make your code a device-only version of dwc2
(drivers/usb/dwc2) and have Paul move his host side to that instead.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/9dd2db2c/attachment-0001.sig>

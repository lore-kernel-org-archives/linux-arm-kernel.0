From: artem.bityutskiy@intel.com (Bityutskiy, Artem)
Date: Thu, 2 Feb 2012 11:51:25 +0000
Subject: [PATCH v3] mtd/gpmi : add BBT support to gpmi nand driver
In-Reply-To: <20120131121007.GO2471@pengutronix.de>
References: <1328008316-27258-1-git-send-email-b32955@freescale.com>
 <20120131121007.GO2471@pengutronix.de>
Message-ID: <1328183611.28171.170.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-01-31 at 13:10 +0100, Wolfram Sang wrote:
> On Tue, Jan 31, 2012 at 07:11:56PM +0800, Huang Shijie wrote:
> > Add a new field to gpmi_nand_platform_data{}.
> > Make the BBT support to board specific.
> > 
> > Signed-off-by: Huang Shijie <b32955@freescale.com>
> 
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> I'd think you won't be able to mark blocks bad, though. Will send a
> patch in a minute. Please test.

Sorry, I have not read this and the previous related long threads, but
from the few first e-mails I got the impression that you are not aware
of the patch from Brian Norris where he modifies MTD BBT code so that it
will by default write bad block markers _both_ to the BBT and to OOB. It
sounds like you should hold on with this patch and wait when Brian's
patch gets in. Then you probably may just use the first version of this
patch.

The patch I referred to:
http://patchwork.ozlabs.org/patch/137154/

HTH.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/04619b00/attachment-0001.sig>
-------------- next part --------------
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 23 Sep 2013 22:06:46 +0200
Subject: [PATCH 4/4] RX-51: Add platform function and data for bq24150a
 charger
In-Reply-To: <20130923200008.GA21808@earth.universe>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309232116.19161@pali> <20130923200008.GA21808@earth.universe>
Message-ID: <201309232206.47391@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 September 2013 22:00:09 Sebastian Reichel wrote:
> On Mon, Sep 23, 2013 at 09:16:18PM +0200, Pali Roh?r wrote:
> > It is not as simple as it looks. This is reason why I
> > submited this patch long time after I submited bq2415x
> > driver.
> > 
> > Problem is that for rx51 is needed specific function which
> > connect to two drivers (bq2415x and isp1704) plus it call
> > specific rx51 board functions.
> > 
> > Something which cannot be in DT (unless DT support C/ASM
> > code).
> 
> mh could isp1704 driver expose the data via the regulator
> framework?

No, isp1704 is power supply driver and export data via power 
supply (sysfs) interface. It is not regulator but charger driver.

> Then the bq2415x chip can just use the regulator
> framework. This should make converting to DT easy (by giving
> the bq2415x chip the isp1704 as regulator) and uses existing
> standard interfaces.
> 
> > Patches for modem support are being prepared for upstreaming
> > :-) so after that it is up to you to create "call" script
> > as you want
> 
> I'm on it. RFC round will be sent out this week. It seems
> hwmod data is already finished, since i didn't get feedback
> for that patch :)
> 
> -- Sebastian

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/07adf26c/attachment.sig>

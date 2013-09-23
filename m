From: sre@ring0.de (Sebastian Reichel)
Date: Mon, 23 Sep 2013 22:47:15 +0200
Subject: [PATCH 4/4] RX-51: Add platform function and data for bq24150a
 charger
In-Reply-To: <201309232206.47391@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309232116.19161@pali> <20130923200008.GA21808@earth.universe>
 <201309232206.47391@pali>
Message-ID: <20130923204714.GB22995@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 10:06:46PM +0200, Pali Roh?r wrote:
> On Monday 23 September 2013 22:00:09 Sebastian Reichel wrote:
> > On Mon, Sep 23, 2013 at 09:16:18PM +0200, Pali Roh?r wrote:
> > > It is not as simple as it looks. This is reason why I
> > > submited this patch long time after I submited bq2415x
> > > driver.
> > > 
> > > Problem is that for rx51 is needed specific function which
> > > connect to two drivers (bq2415x and isp1704) plus it call
> > > specific rx51 board functions.
> > > 
> > > Something which cannot be in DT (unless DT support C/ASM
> > > code).
> > 
> > mh could isp1704 driver expose the data via the regulator
> > framework?
> 
> No, isp1704 is power supply driver and export data via power 
> supply (sysfs) interface. It is not regulator but charger driver.

well it does not charge the battery directly, but just provides a
power line with 5 Volt and a specified amount of current to the
system, doesn't it?

>From my POV this is a candiate for the regulator framework:

https://www.kernel.org/doc/Documentation/power/regulator/overview.txt

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/458b2b62/attachment.sig>

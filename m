From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 25 Sep 2017 10:05:11 +0200
Subject: bq27xxx: what is going on with MSLEEP() macro
Message-ID: <20170925080510.GA31768@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

0670c9b35 drivers/power/supply/bq27xxx_battery.c #define BQ27XXX_MSLEEP(i) usleep_range((i)*1000, (i)*1000+500)

Liam, is this really neccessary? Defining MSLEEP to be USLEEP_RANGE is
quite sneaky and confusing. Plus I don't believe we should be
usleep-ing for 25msec. Can we just replace it with regular msleep?

0670c9b35 drivers/power/supply/bq27xxx_battery.c         /* DO NOT read BQ27XXX_DM_CKSUM
here to verify it! That may cause NVM

Normal kernel style for multi-line comments is

/*
 * foo
 */

Can you fix those?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170925/bb21be4f/attachment.sig>

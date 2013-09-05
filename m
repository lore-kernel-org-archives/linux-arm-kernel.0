From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 5 Sep 2013 21:15:56 +0300
Subject: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support
 to the LRADC driver
In-Reply-To: <201309051251.39877.marex@denx.de>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
 <201309051216.18305.jbe@pengutronix.de>
 <20130905104256.GK6329@mwanda> <201309051251.39877.marex@denx.de>
Message-ID: <20130905181556.GU19256@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since I work in staging I review hundreds of churn patches per cycle.
One thing which helps me is my rename_rev.pl script (attached).

So if I get a patch like the one I'm about to send which introduces
lradc_reg_set/clear() functions, then I can do this:

cat diff | rename_rev.pl -ea 's/,\n/,/' | \
	rename_rev.pl -e 's/writel\((.*?),\s+lradc->base \+ (.*?) .*SET\)/lradc_reg_set(lradc, $1, $2)/' \
		      -e 's/writel\((.*?),\s+lradc->base \+ (.*?) .*CLR\)/lradc_reg_clear(lradc, $1, $2)/'

It simplifies the patch down to its most minimal form.

I should probably automate the first part which strips out some
line breaks...  I'll post a new version of rename_rev.pl to LKML soon.

regards,
dan carpenter

-------------- next part --------------
A non-text attachment was scrubbed...
Name: rename_rev.pl
Type: text/x-perl
Size: 4221 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130905/edde38f4/attachment.bin>

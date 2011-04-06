From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Wed, 6 Apr 2011 13:25:04 +0200
Subject: [PATCH 5/5] driver core: let dev_set_drvdata return int instead
	of void as it can fail
In-Reply-To: <20110406110623.GC13963@pengutronix.de>
References: <20110301153438.GB15633@suse.de>
	<1302081865-2962-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<BANLkTikVpacjh1EsQQoaQRN3j-kxxjr7qA@mail.gmail.com>
	<20110406110623.GC13963@pengutronix.de>
Message-ID: <BANLkTi=MjDqawZx=+fKjaAs5SPfGQDEgVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/6 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
> On Wed, Apr 06, 2011 at 11:36:46AM +0200, Micha? Miros?aw wrote:
>> 2011/4/6 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> > ---
>> > Hello,
>> >
>> > I wasn't sure what to return when dev_set_drvdata is called with
>> > dev=NULL. ?I choosed 0, but -EINVAL would be OK for me, too. What do you
>> > think?
>> Why not just BUG_ON(!dev)? Is there a case when you might call this
>> with dev==NULL that's not a driver bug?
> I think BUG_ON is too harsh. Will resend with -EINVAL.

Maybe just WARN_ON, then? Please? ;-)

Error return with no other visible sign is easy to miss for driver
writers. Big bad backtrace in dmesg on the other hand attracts
attention.

Best Regards,
Micha? Miros?aw

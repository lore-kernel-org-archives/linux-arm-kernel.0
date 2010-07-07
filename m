From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 07 Jul 2010 17:17:11 +0300
Subject: [PATCH v2] mtd/mxc_nand: don't call mtd->{suspend,resume}
	explicitly
In-Reply-To: <1276801147-4103-4-git-send-email-eric@eukrea.com>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>
	<1276801147-4103-2-git-send-email-eric@eukrea.com>
	<1276801147-4103-3-git-send-email-eric@eukrea.com>
	<1276801147-4103-4-git-send-email-eric@eukrea.com>
Message-ID: <1278512231.12733.23.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-06-17 at 20:59 +0200, Eric B?nard wrote:
> The mtd layer is responsible to call mtd->{suspend,resume}.  Doing it
> again in the driver is wrong and results in a warning:
> 
> 	nand_resume called for a chip which is not in suspended state
> 
> at resume time.  Removing the calls from the resume and suspend
> functions makes them empty allowing them to be deleted completely.
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Pushed to l2-mtd-2.6.git / dunno

-- 
Best Regards,
Artem Bityutskiy (????? ????????)

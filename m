From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Fri, 13 Aug 2010 10:58:26 +0200
Subject: [PATCH v2] mx35: Fix boot ROM hang in internal boot mode
In-Reply-To: <20100813081720.GA23898@pengutronix.de>
References: <20100811233721.GB6411@local>	<20100812055753.GB9763@pengutronix.de>	<20100812112938.GB8670@local>
	<20100812121504.GC8670@local>
	<20100813081720.GA23898@pengutronix.de>
Message-ID: <4C650932.7090209@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 13/08/2010 10:17, Uwe Kleine-K?nig a ?crit :
> On Thu, Aug 12, 2010 at 02:15:04PM +0200, Hans J. Koch wrote:
>> As a sidenote, it should be clear that this patch is a workaround for
>> a serious chip bug of the MX35.
>> From the things you wrote up to now it's possible that this is a
> bootloader issue, isn't it.
>
> I don't know exactly what "internal boot mode" means, but assuming the
> ROM code doesn't make any output to UART1 at least this clock smells
> like a bootloader problem.

internal bootmode is the mode where the CPU boots on the internal rom 
code which samples some GPIO to set the fuses and select which boot 
media to use. So ROM code is executed before loading the bootloader 
(barebox in my case) and that's where the CPU hangs.

I think we have the exact same problem using i.MX35 (and maybe also on 
i.MX51), but I need to find time to do more tests to confirm this.

Eric

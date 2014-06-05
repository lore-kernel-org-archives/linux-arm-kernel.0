From: chris@printf.net (Chris Ball)
Date: Thu, 05 Jun 2014 20:31:56 +0100
Subject: MMC is *still* broken...
In-Reply-To: <20140605183615.GG23430@n2100.arm.linux.org.uk> (Russell King's
 message of "Thu, 5 Jun 2014 19:36:15 +0100")
References: <20140605183615.GG23430@n2100.arm.linux.org.uk>
Message-ID: <86oay7noer.fsf@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, adding Ulf and Olof,

On Thu, Jun 05 2014, Russell King - ARM Linux wrote:
> drivers/mmc/core/core.c: In function 'mmc_card_power_up':
> drivers/mmc/core/core.c:1517:4: error: implicit declaration of
> function 'gpiod_set_value'
>
> I reported this back in April, and it's still present.  This makes me
> wonder if MMC is maintained.... and makes me wonder what the point
> of reporting bugs is if they just get ignored.

I don't recall your report.  I might have just failed to read it, but
doing a quick mail search only finds "Subject: randconfig failures -
MMC + trusted foundations" -- which was sent to linux-arm-kernel@, but
not CC'd to linux-mmc@ or to me.

Furthermore, this error does not exist in mmc-next or linux-next,
so it's unclear why or how the MMC maintainers would fix it.
drivers/mmc/core/core.c does not use gpiod_set_value() in these trees.

Presumably you're testing Olof's unmerged patch "mmc: add support for
power-on sequencing through DT".  If it needs to include more gpio
headers, that should be reported to Olof for a respin.

The patch has not been merged because we're still discussing the best
way forward on linux-mmc@, in the thread "RFC: representing sdio
devices oob interrupt, clks, etc. in device tree".  The most recent
message in the thread is from yesterday.

- Chris.
-- 
Chris Ball   <http://printf.net/>

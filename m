From: ladis@linux-mips.org (Ladislav Michl)
Date: Fri, 6 Jan 2017 18:39:44 +0100
Subject: [PATCH 1/6] ARM: dts: am335x-phycore-som: Update NAND partition
 table
In-Reply-To: <20170105175619.GA56877@google.com>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
 <1483627851-17996-2-git-send-email-t.remmet@phytec.de>
 <20170105153637.GA4310@atomide.com>
 <20170105171845.GK4310@atomide.com>
 <20170105175619.GA56877@google.com>
Message-ID: <20170106173944.t3jq7amga3j5ahe6@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 09:56:20AM -0800, Brian Norris wrote:
[snip]
> The best solution would be to try to migrate away from static device
> tree representations of partition info entirely. UBI volumes are best
> where possible. If not, then some other kind of on-flash data structures
> (along the lines of a GPT) with a corresponding MTD partition parser is
> an OK alternative. Unfortunately, there isn't any good standard format
> for this on MTD, so it's typically all custom -- and so people use the
> easiest approach: device tree. And it's even more difficult with NAND,
> which has reliability problems, especially with static data (e.g., read
> disturb).

Just as a side note, there is some work in this area:
https://www.mail-archive.com/u-boot at lists.denx.de/msg232759.html

> Anyway, the parser solution is helpful only if one can properly fix the
> "flag day" first. And it requires a little bit more work to be generally
> useful; I posted some work for this over a year ago, but bikeshedding
> brought it down.

Best regards,
	ladis

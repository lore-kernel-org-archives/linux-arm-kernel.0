From: b32955@freescale.com (Huang Shijie)
Date: Fri, 23 Aug 2013 14:26:28 +0800
Subject: [PATCH V1 3/5] mtd: m25p80: add the quad-read support
In-Reply-To: <20130822195559.GU26118@sirena.org.uk>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <1376885403-12156-4-git-send-email-b32955@freescale.com>
 <20130822193453.GB10038@ld-irv-0074.broadcom.com>
 <20130822195559.GU26118@sirena.org.uk>
Message-ID: <52170094.2030608@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?08?23? 03:55, Mark Brown ??:
> On Thu, Aug 22, 2013 at 12:34:53PM -0700, Brian Norris wrote:
>> On Mon, Aug 19, 2013 at 12:10:01PM +0800, Huang Shijie wrote:
>
>> Why can't this be detected at runtime? We added a "no fast read" flag to
>> the device table, so why not "dual/quad mode supported"? And believe it
>> or not, not all m25p80 users have device tree. So it isn't very logical
>> to tie this support to device-tree only.
>
Hi Brian:
My only question here is do we need to add some flags , such as "quad
read", to
the device table? If you think we need to, i will add a patch for it.

(Just as Brown said, when the DTS configurates the "m25p,quad-read"
property, it
means : Both the board and the NOR support the Quad read.)


>> What you're really missing from device-tree (and the SPI subystem in
>> general) is how to detect those SPI controllers which support dual and
>> quad mode transfers, and how to communicate that a particular SPI
>> transaction should be performed on 1 or 4 IO lines. We shouldn't have
>> this just hacked in via assumptions.
> That bit does need to be fixed in this driver, yes.  The SPI core now
> has quad mode support.
yes, i do not need these bits in this driver.


thanks
Huang Shijie

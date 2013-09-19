From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 19 Sep 2013 15:57:40 -0700
Subject: [GIT PULL] ARM: SoC fixes for 3.12-rc
In-Reply-To: <1379626776.753.164.camel@shinybook.infradead.org>
References: <20130919194752.GA19975@quad.lixom.net>
 <1379626776.753.164.camel@shinybook.infradead.org>
Message-ID: <CAN8TOE8j=oosn-5hAdqoTPcuW-sGvDAHd_nK6BZfJpxMwwpisQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 2:39 PM, Woodhouse, David
<david.woodhouse@intel.com> wrote:
> On Thu, 2013-09-19 at 12:47 -0700, Olof Johansson wrote:
>>
>> - A fix for build breakage in the MTD subsystem for some PXA devices.
>>   David Woodhouse has this patch in his for-next branch but has not been
>>   responding to our requests to send it up so here it is.
>>   I should have amended the commit message to describe the build failure for
>>   CONFIG_OF=n setups, but forgot and now it's down in the stack of commits.
>
> Thanks for pulling that in. Apologies for the screwup.

Speaking of such process issues: there's an outstanding patch for a
(small) memory leak that was introduced in the nand_base.c ONFI code
in 3.12-rc1. Can I expect you to attend to these sort of -rcX (where X
> 1) issues? Or should I send Linus the patch myself? I don't really
want it to wait around until 3.13-rc1 to go to -stable.

It's in l2-mtd.git (will need cherry-picked out of there) and ready
for the next linux-next:

commit b2bdf43fcc1d440d8f4e1d5c8c59bf2ca76204df
Author: Brian Norris <computersforpeace@gmail.com>
Date:   Mon Sep 16 17:59:20 2013 -0700

    mtd: nand: fix memory leak in ONFI extended parameter page

Brian

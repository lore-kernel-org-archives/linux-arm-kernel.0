From: mikedunn@newsguy.com (Mike Dunn)
Date: Tue, 27 Nov 2012 10:06:59 -0800
Subject: [PATCH] MTD: at91: atmel_nand: return bit flips for the PMECC
 read_page()
In-Reply-To: <50AD9E8E.7050402@atmel.com>
References: <1353474863-28430-1-git-send-email-josh.wu@atmel.com>
 <50ACA764.3030002@atmel.com> <50AD9E8E.7050402@atmel.com>
Message-ID: <50B50143.7080408@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2012 07:39 PM, Josh Wu wrote:
> Hi, Nicolas
> 
> On 11/21/2012 6:05 PM, Nicolas Ferre wrote:
>> On 11/21/2012 06:14 AM, Josh Wu :
>>>
>> Can we have more comment to figure out why it is needed please?
> 
> I will add following comment in the commit message in the v2 version.
> 
> Since the commit: 3f91e94f7f511de74c0d2abe08672ccdbdd1961c ("mtd: nand:
> read_page() returns max_bitflips ()")
> The ecc.read_page() method for nand drivers is changed to return the maximum
> number of bitflips instead of just returning 0.
> 
> And the nand.h is also explain that. I would like to adapt to it.


This patch avails the atmel_nand device of a change that was merged to the
kernel mtd code several months ago.  That change fixed a problem where higher
layers that use the -EUCLEAN return code to make judgements on block wear (e.g.
ubi) were marking blocks as bad when a normal number of bitflip corrections were
made.  The problem affected newer nands with greater ecc strength.  See the
entry on 'bitflip_threshold' in Documentation/ABI/testing/sysfs-class-mtd

Thanks,
Mike

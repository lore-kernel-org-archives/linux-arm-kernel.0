From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 25 Apr 2012 08:15:29 -0700
Subject: announcing the clk-next branch
In-Reply-To: <20120425124258.GY24211@n2100.arm.linux.org.uk>
References: <CAJOA=zOGSh3et4nxE=JdojL4uDjgt8o+oiOU4pmbM=oU2U6prA@mail.gmail.com>
 <20120425123828.GC3852@pengutronix.de>
 <20120425124258.GY24211@n2100.arm.linux.org.uk>
Message-ID: <CAJOA=zOpuX3ccKWGf5h-L0ibjujYeSe1v8bz8oMEkYLQT=rPmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 5:42 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Apr 25, 2012 at 02:38:28PM +0200, Sascha Hauer wrote:
>> On Tue, Apr 24, 2012 at 06:32:20PM -0700, Turquette, Mike wrote:
>> > Hi all,
>> >
>> > The clock patches that I have signed-off on and picked from the list
>> > are all rebased on top of 3.4-rc4. ?They can be found here:
>> >
>> > git://git.linaro.org/people/mturquette/linux.git clk-next
>>
>> Thanks Mike!
>>
>> >
>> > If the branch is missing anything that I have ACK'd then please let me know.
>>
>> You haven't acked it, but for i.MX I need two patches from Viresh I'd
>> like to base on:
>>
>> [PATCH V3 1/8] CLKDEV: Add helper routines to allocate and add clkdevs for given struct clk *
>> [PATCH V3 2/8] clk: add a fixed factor clock
>>
>> Also I need the patch implementing managed clk_get which currently sits
>> in Russells tree.
>
> Well, some of this stuff is already committed in my tree. ?There's total
> confusion at the moment over who's looking after clk API stuff - I'm
> listed as the official maintainer for linux/clk.h and clkdev, but Mike
> is clearly the guy doing all the common stuff.
>
> What would not be a good idea is to have the same patches committed
> independently into two different trees.

What is the best solution here?

I can base my branch on top of one of yours if the goal is to have
clk-next be a one-stop-shop for folks trying to port their platforms
over to the new struct clk.

On the other hand maybe the platform folks that are trying to convert
to struct clk should just base their work on top of your for-next
branch and my clk-next, merged locally.

In the mean time I'll go through my branch today and see which patches
collide with ones you have already merged.  My branch is quite small
(less than two dozen patches) so removing collisions will be easy.

Regards,
Mike

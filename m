From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 Apr 2014 13:42:50 -0600
Subject: [PATCH 1/5] ARM: defconfigs: add MTD_SPI_NOR (new dependency
 for M25P80)
In-Reply-To: <20140429190603.GB9418@norris-Latitude-E6410>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
 <1397719309-2022-2-git-send-email-computersforpeace@gmail.com>
 <535A8FC9.8040707@wwwdotorg.org>
 <20140429190603.GB9418@norris-Latitude-E6410>
Message-ID: <536000BA.4000101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2014 01:06 PM, Brian Norris wrote:
> Hi Stephen,
> 
> On Fri, Apr 25, 2014 at 10:39:37AM -0600, Stephen Warren wrote:
>> On 04/17/2014 01:21 AM, Brian Norris wrote:
>>> These defconfigs contain the CONFIG_M25P80 symbol, which is now
>>> dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to the
>>> relevant defconfigs.
>>>
>>> At the same time, drop the now-nonexistent CONFIG_MTD_CHAR symbol.
...
>> I think this should be split it up so that each defconfig can go through
>> the tree that owns it to avoid conflicts. If you repost split up, I can
>> apply the tegra_defconfig change to the Tegra tree.
> 
> OK, I'll try to split it up. Is ARM unique in tracking defconfigs in
> separate trees? I assume MIPS, PowerPC, and Blackfin won't require the
> same splitting? I'd like to avoid 31 patches when <20 could suffice.

Sorry, I have no idea how the other arches handle defconfigs:-(

I guess you could also just see if arm-soc (arm@kernel.org) will take
this patch, and deal with any merge conflicts that arise when they merge
all the sub-arch defconfig changes. I CC'd them to find out if they
think that's a better idea.

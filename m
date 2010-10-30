From: ben-linux@fluff.org (Ben Dooks)
Date: Sat, 30 Oct 2010 23:18:52 +0100
Subject: [PATCH] ARM: orion5x/kirkwood/mv78xx0: fix MPP configuration
	corner cases
In-Reply-To: <alpine.LFD.2.00.1010290007070.6603@xanadu.home>
References: <1287907960-31563-1-git-send-email-mike@compulab.co.il>
	<alpine.LFD.2.00.1010290007070.6603@xanadu.home>
Message-ID: <4CCC99CC.6050808@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/10/10 05:12, Nicolas Pitre wrote:
> On Sun, 24 Oct 2010, Mike Rapoport wrote:
> 
>> Wrong MPP configuration would cause <cpu>_mpp_conf loop	infinitely
>> because the mpp list iterator would not be incremented.
>>
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---
>>  arch/arm/mach-kirkwood/mpp.c |    5 +++--
>>  arch/arm/mach-mv78xx0/mpp.c  |    5 +++--
>>  arch/arm/mach-orion5x/mpp.c  |    5 +++--
>>  3 files changed, 9 insertions(+), 6 deletions(-)
> [...]
> 
> Instead of adding gotos, could you simply replace the 
> "while (*mpp_list)" loop with "for ( ; *mpp_list; mpp_list++)" ?

you'd have to remove the mpp_list++, but this would be in my
view a nicer solution avoiding gotos and any re-occurence of
this in the future.

-- 
Ben

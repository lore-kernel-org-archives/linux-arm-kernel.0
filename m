From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 Apr 2014 10:17:01 -0600
Subject: [PATCH 51/97] ARM: l2c: remove platforms/SoCs setting early BRESP
In-Reply-To: <20140429000224.GA31083@verge.net.au>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerG4-0001X4-Ic@rmk-PC.arm.linux.org.uk>
 <20140429000224.GA31083@verge.net.au>
Message-ID: <535FD07D.5070801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 06:02 PM, Simon Horman wrote:
> On Mon, Apr 28, 2014 at 08:30:32PM +0100, Russell King wrote:
>> Since we now automatically enable early BRESP in core L2C-310 code when
>> we detect a Cortex-A9, we don't need platforms/SoCs to set this bit
>> explicitly.  Instead, they should seek to preserve the value of bit 30
>> in the auxiliary control register.
>>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> I would prefer if this patch was broken out into individual patches
> for each board or SoC file and that they were then picked up
> by their respective platform maintainers.
> 
> Likewise for patch 66/97. Although it is only for shmobile
> I would prefer it broken out.

There are far too many dependencies in this series to break out the
board file patches to be merged separately; it'd take either a whole
bunch of kernel releases to merge it all that way, or a twisty maze of
tiny topic branches cross-merged all over the place. Neither option is
realistic.

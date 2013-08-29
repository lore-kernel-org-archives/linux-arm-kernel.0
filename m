From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Thu, 29 Aug 2013 14:52:18 +0530
Subject: [PATCH 1/3] ARM: AM33xx: hwmod: Add RNG module data
In-Reply-To: <alpine.DEB.2.02.1308281845560.22040@utopia.booyaka.com>
References: <1375777984-6267-1-git-send-email-lokeshvutla@ti.com>
 <1375777984-6267-2-git-send-email-lokeshvutla@ti.com>
 <alpine.DEB.2.02.1308281845560.22040@utopia.booyaka.com>
Message-ID: <521F12CA.8010608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,
On Thursday 29 August 2013 12:18 AM, Paul Walmsley wrote:
> Hi
> 
> On Tue, 6 Aug 2013, Lokesh Vutla wrote:
> 
>> Add RNG hwmod data for AM33xx SoC.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> 
> I tried to queue this one, but it caused AM33xx boots to hang.  
> Thought it might be related to the patch ordering -- seems to me that 
> the clock change patch needed to come before this patch -- but if I 
> recall correctly, both BeagleBone and BeagleBone-LT still hung. 
This is because register address space is not passed in hwmod_data as it
is passed from dt. So we need to include 3/3 patch in this series to boot.

Ill fix this sparse warning and post a v2.

PS: Probe for this driver will be failed even after this. Support for this version
of rng ip is already posted and pushed into cryptodev-2.6 tree.

Thanks and regards,
Lokesh
> 
> Also, this patch created a sparse warning.
> 
> Could you take another look at this patch?  Maybe try basing off of this 
> tag:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.12/omap-prcm-hwmod
> 
> Fix the sparse problem, and see if the patch boots for you?
> 
> thanks
> 
> 
> - Paul
> 

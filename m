From: s-anna@ti.com (Suman Anna)
Date: Mon, 23 Mar 2015 11:30:13 -0500
Subject: [PATCH 0/2] Couple of DRA7 hwmod patches on Timers
In-Reply-To: <alpine.DEB.2.02.1503211939340.2512@utopia.booyaka.com>
References: <1426539294-28375-1-git-send-email-s-anna@ti.com>
 <alpine.DEB.2.02.1503211939340.2512@utopia.booyaka.com>
Message-ID: <55103F95.5070100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

>> Following are couple of DRA7 hwmod patches for the GPTimers.
>> Patches based on 4.0-rc1.
>>
>> The first patch adds the data for timers 13 through 16, the DT
>> nodes are already present, and when enabled without the hwmod
>> data triggers a l3_noc interrupt and hangs the kernel boot [1].
>> The boot hang can also be fixed by checking the return status
>> of pm_runtime_get_sync() in the OMAP dmtimer probe, I will post
>> a separate fix for that.
>>
>> Second patch is a minor fix.
> 
> Thanks.  Sounds like the first one should go in for v4.0-rc fixes, and the 
> second one can wait for v4.1?  
> 
> If so then could you repost the first fix to include the description of 
> why it should go in early in the patch description ("the DT nodes are 
> already present, and when enabled without the hwmod data triggers a l3_noc 
> interrupt and hangs the kernel boot").  That should avoid anyone 
> questioning why it would go in as a v4.0-rc fix at this point, and should 
> help the -stable crew out.

Actually, both of them can be queued for v4.1. Tony has already sent a
pull request with the fixes [1] in the driver. The driver fixes will
scale for all SoCs, so will fix this boot issue as well if anyone tries
to enable these timers.

regards
Suman

[1] http://marc.info/?l=linux-omap&m=142661461902725&w=2

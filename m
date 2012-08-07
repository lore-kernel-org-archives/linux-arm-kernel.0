From: khilman@ti.com (Kevin Hilman)
Date: Tue, 07 Aug 2012 14:46:50 -0700
Subject: nfsroot problems with v3.6-rc1 on 37xx EVM and dynamic off-mode
In-Reply-To: <alpine.DEB.2.00.1208031340310.28888@utopia.booyaka.com> (Paul
 Walmsley's message of "Fri, 3 Aug 2012 14:20:07 -0600 (MDT)")
References: <alpine.DEB.2.00.1208031340310.28888@utopia.booyaka.com>
Message-ID: <87boim1ik5.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Paul Walmsley <paul@pwsan.com> writes:

> NFS is broken on 37xx EVM with v3.6-rc1 after return from off-mode with 
> dynamic idle.  System suspend ("echo mem > /sys/power/state") with 
> off-mode enabled seems to work fine.
>
> No obvious ideas here as to what could have broken this.  It worked in 
> v3.5-rc2 + my omap_fixes_a_3.5rc at least:
>
> http://www.pwsan.com/omap/bootlogs/20120617/omap_fixes_a_3.5rc__52a5ae406dadef781bfcf3a641dae2064e9697ff/37xxevm_bootlog.txt
>
> After that, it's hard to tell when this problem started occurring, since 
> CORE stopped entering low-power states on OMAP3 on >= v3.5-rc3.

I see the same thing with vanilla v3.6-rc1, but it worked in my pm-cur
branch which has a few fixes that I'm queuing for v3.6-rc.  Tracking it
down, it seems the revert patch I just sent out[1] fixes this problem,
but I'm still a bit puzzled as to why.

Can you try v3.6-rc1 + that revert[1] to see if that fixes the problem
for you as well?

Thanks,

Kevin

[1] http://marc.info/?l=linux-omap&m=134437239010649&w=2

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 May 2015 11:14:47 +0100
Subject: [PATCH] arm: Don't use memblock limit for the lowmem bound
In-Reply-To: <1431399221-25337-1-git-send-email-labbott@fedoraproject.org>
References: <1431399221-25337-1-git-send-email-labbott@fedoraproject.org>
Message-ID: <20150514101447.GW2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 07:53:41PM -0700, Laura Abbott wrote:
> From: Laura Abbott <labbott@redhat.com>
> 
> The memblock limit is currently used in find_limits
> to find the bounds for ZONE_NORMAL. The memblock
> limit may need to be rounded down a PMD size to ensure
> allocations are fully mapped though. This has the side
> effect of reducing the amount of memory in ZONE_NORMAL.
> Since we generally want to optimize for more lowmem, fix
> this by using arm_lowmem_limit to calculate the bounds.
> This what is used for actually mapping lowmem anyway.
> 
> Before:
> # cat /proc/zoneinfo | grep managed
>         managed  62920
> 
> After:
> # cat /proc/zoneinfo | grep managed
>         managed  63336
> 
> 
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Ok.  -> patch system please.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

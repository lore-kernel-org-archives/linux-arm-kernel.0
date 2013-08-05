From: horms@verge.net.au (Simon Horman)
Date: Mon, 5 Aug 2013 17:50:16 +0900
Subject: [PATCH 00/13] ARM: shmobile: Rework ->init_time() /
 shmobile_timer_init()
In-Reply-To: <20130731190110.31796.96552.sendpatchset@w520>
References: <20130731190110.31796.96552.sendpatchset@w520>
Message-ID: <20130805085013.GD13274@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 04:01:10AM +0900, Magnus Damm wrote:
> ARM: shmobile: Rework ->init_time() / shmobile_timer_init()
> 
> [PATCH 01/13] ARM: shmobile: Use default ->init_time() on r8a73a4
> [PATCH 02/13] ARM: shmobile: Use default ->init_time() on r8a7740
> [PATCH 03/13] ARM: shmobile: Use default ->init_time() on r8a7778
> [PATCH 04/13] ARM: shmobile: Use default ->init_time() on r8a7779
> [PATCH 05/13] ARM: shmobile: Use default ->init_time() on Bockw
> [PATCH 06/13] ARM: shmobile: Use default ->init_time() on Bockw DT ref
> [PATCH 07/13] ARM: shmobile: Use default ->init_time() on Armadillo DT ref
> [PATCH 08/13] ARM: shmobile: Use default ->init_time() on APE6EVM
> [PATCH 09/13] ARM: shmobile: Use default ->init_time() on APE6EVM DT ref
> [PATCH 10/13] ARM: shmobile: Use default ->init_time() on Marzen DT ref
> [PATCH 11/13] ARM: shmobile: Use default ->init_time() on KZM9G DT ref
> [PATCH 12/13] ARM: shmobile: Use clocksource_of_init() on r8a7790
> [PATCH 13/13] ARM: shmobile: Remove unused shmobile_init_time()
> 
> Set ->init_time() to NULL to use the default ARM behaviour which
> happens to be clocksource_of_init(). Also, replace the call to
> shmobile_time_init() with clocksource_of_init(). Finally, remove
> shmobile_init_time() that now is unused.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue these up for v3.12 in the cleanup3 branch.

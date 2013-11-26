From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 26 Nov 2013 16:40:22 -0500
Subject: [PATCH] clocksource: armada-370-xp: Register sched_clock after
 the counter reset
In-Reply-To: <1385500814-15058-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1385500814-15058-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131126214022.GQ2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 06:20:14PM -0300, Ezequiel Garcia wrote:
> This commit registers the sched_clock _after_ the counter reset
> (instead of before). This removes the timestamp 'jump' in kernel
> log messages.
> 
> Before this change:
> 
> [    0.000000] sched_clock: 32 bits at 25MHz, resolution 40ns, wraps every 171798691800ns
> [    0.000000] Initializing Coherency fabric
> [    0.000000] Aurora cache controller enabled
> [    0.000000] l2x0: 16 ways, CACHE_ID 0x00000100, AUX_CTRL 0x1a696b12, Cache size: 1024 kB
> [  163.507447] Calibrating delay loop... 1325.05 BogoMIPS (lpj=662528)
> [  163.521419] pid_max: default: 32768 minimum: 301
> [  163.526185] Mount-cache hash table entries: 512
> [  163.531095] CPU: Testing write buffer coherency: ok
> 
> After this change:
> 
> [    0.000000] sched_clock: 32 bits at 25MHz, resolution 40ns, wraps every 171798691800ns
> [    0.000000] Initializing Coherency fabric
> [    0.000000] Aurora cache controller enabled
> [    0.000000] l2x0: 16 ways, CACHE_ID 0x00000100, AUX_CTRL 0x1a696b12, Cache size: 1024 kB
> [    0.016849] Calibrating delay loop... 1325.05 BogoMIPS (lpj=662528)
> [    0.030820] pid_max: default: 32768 minimum: 301
> [    0.035588] Mount-cache hash table entries: 512
> [    0.040500] CPU: Testing write buffer coherency: ok
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Nobody has ever complained about the 'jump' in the timestamp, so maybe
> this is a stupid and useless change.

Correcting something that's wrong is never useless nor stupid.

>  drivers/clocksource/time-armada-370-xp.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

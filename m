From: nm@ti.com (Nishanth Menon)
Date: Thu, 11 Oct 2012 15:17:35 -0500
Subject: [PATCH] Boottime: A tool for automatic measurement of
 kernel/bootloader boot time
In-Reply-To: <1349966545-19340-1-git-send-email-lee.jones@linaro.org>
References: <1349966545-19340-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20121011201735.GA15313@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:42-20121011, Lee Jones wrote:
> From: Jonas Aaberg <jonas.aberg@stericsson.com>
> 
> The overhead is very low and the results will be found under
> sysfs/bootime, as well as detailed results in debugfs under
> boottime/. The bootgraph* files are compatible with
> scripts/bootgraph.pl. The reason for this patch is to provide
> data (sysfs/boottime) suitable for automatic testcases as
> well as help for developers to reduce the boot time (debugfs).
Tried master:
250d8 Merge branch 'i2c-embedded/for-next' of git://git.pengutronix.de/git/wsa/linux
and v3.6-rc7
with omap2plus_defconfig + CONFIG_BOOTTIME enabled:

init/boottime.c:47:9: error: ?cpu_usage_stat? defined as wrong kind of tag
init/boottime.c:47:24: error: array type has incomplete element type
init/boottime.c: In function ?boottime_mark_core?:
init/boottime.c:127:313: error: ?struct kernel_stat? has no member named ?cpustat?
init/boottime.c:128:311: error: ?struct kernel_stat? has no member named ?cpustat?
init/boottime.c:129:313: error: ?struct kernel_stat? has no member named ?cpustat?
init/boottime.c:130:310: error: ?struct kernel_stat? has no member named ?cpustat?

if it depended on some other patch or a specific maintainer branch,
it was'nt clear.
-- 
Regards,
Nishanth Menon

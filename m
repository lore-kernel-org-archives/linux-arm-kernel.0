From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 30 Jun 2011 14:38:52 +0900
Subject: [PATCH] arm: platsmp: Allow secondary cpu hotplug with maxcpus=1
In-Reply-To: <1309372300-28911-1-git-send-email-sboyd@codeaurora.org>
References: <1309372300-28911-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20110630053851.GC22023@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 11:31:39AM -0700, Stephen Boyd wrote:
> If an ARM system has multiple cpus in the same socket and the
> kernel is booted with maxcpus=1, secondary cpus are possible but
> not present due to how platform_smp_prepare_cpus() is called.
> Fix this by always calling platform_smp_prepare_cpus() as long as
> max_cpus is non-zero (0 means no SMP) to allow platform code to
> decide if any non-boot cpus are present in the system. Since
> all current platform code doesn't support physical hotplug we
> have a situation where possible == present and thus we can
> simply copy the possible map to the present map.
> 
> With this patch it's possible to boot an ARM system with
> maxcpus=1 on the command line and then hotplug in secondary cpus
> via sysfs. This is more in line with how x86 works with maxcpus=1
> on the command line.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Paul Mundt <lethal@linux-sh.org>

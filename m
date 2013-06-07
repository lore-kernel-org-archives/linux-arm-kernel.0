From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 07 Jun 2013 15:28:38 -0600
Subject: [PATCH] ARM: tegra: disable nonboot CPUs when reboot
In-Reply-To: <51B22CDC.4080200@wwwdotorg.org>
References: <1370597810-1153-1-git-send-email-josephl@nvidia.com>
 <51B20DF1.3030207@wwwdotorg.org>
 <20130607181846.GL8111@mudshark.cambridge.arm.com>
 <51B22CDC.4080200@wwwdotorg.org>
Message-ID: <51B25086.6020209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2013 12:56 PM, Stephen Warren wrote:
...
> [1] Perhaps the issue is why ipi_send_stop() calls down into 
> tegra_cpu_kill() rather than tegra_cpu_die(), since die() is what
> should be run on the killed CPU, and kill() on the killing CPU?

Scratch that; I don't think it's calling down to /either/; I was
confused. It seems like it /should/ call cpu_die() though, at least if
hotplug is enabled, right?

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 Jan 2013 11:28:07 -0700
Subject: [PATCH 4/4] irqchip: gic: Perform the gic_secondary_init() call
 via CPU notifier
In-Reply-To: <1358963974-5496-5-git-send-email-catalin.marinas@arm.com>
References: <1358963974-5496-1-git-send-email-catalin.marinas@arm.com>
 <1358963974-5496-5-git-send-email-catalin.marinas@arm.com>
Message-ID: <51002BB7.2000603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2013 10:59 AM, Catalin Marinas wrote:
> All the calls to gic_secondary_init() pass 0 as the first argument.
> Since this function is called on each CPU when starting, it can be done
> in a platform-independent way via a CPU notifier registered by the GIC
> code.

Tegra part,
Acked-by: Stephen Warren <swarren@nvidia.com>

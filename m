From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 18 Jul 2012 18:01:31 +0300
Subject: [PATCH] ARM: tegra: make tegra_cpu_reset_handler_enable() __init
In-Reply-To: <1340053310-20855-1-git-send-email-swarren@wwwdotorg.org>
References: <1340053310-20855-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120718150130.GV9437@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 11:01:50PM +0200, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This solves a section mismatch warning. I hadn't noticed this before,
> because my compiler was inlining tegra_cpu_reset_handler_enable() inside
> tegra_cpu_reset_handler_init(), which is already __init, but I switched
> compilers and it stopped doing that.

Why does this generate a section mismatch warning? I see why calling a
a __init marked function from a non __init marked function is a problem, but
the opposite should be ok no?

Cheers,

Peter.

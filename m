From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Jun 2014 15:10:25 -0600
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
In-Reply-To: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <53ADDDC1.2080603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 10:58 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> These drivers are closely coupled and need to be moved as a whole. One
> reason for moving them out of arch/arm/mach-tegra is to allow them to be
> shared with 64-bit ARM.

Aside from any discussions re: splitting out cpuidle, power domains, ...
into separate subsystem directories, this patch looks conceptually fine
to me.

That said, given that I think arch/arm64 isn't going to have mach-*
directories or machine descriptors, I wonder how all this code is going
to be invoked at boot. arch/arm/mach-tegra/tegra.c calls a bunch of
these functions at boot right now. So, it seems like moving the code so
that it can compile in both places is only part of the solution? Are we
going to have an arm64-specific SoC driver that binds to the SoC
compatible in order to initialize everything? If so, I wonder if the
same can work for arch/arm so everything works the same way?

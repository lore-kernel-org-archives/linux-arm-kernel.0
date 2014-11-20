From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 19 Nov 2014 16:33:32 -0800
Subject: [PATCH 0/3] PM / Domains: Add initial PM clock support to genpd
In-Reply-To: <1416405638-18812-1-git-send-email-ulf.hansson@linaro.org> (Ulf
 Hansson's message of "Wed, 19 Nov 2014 15:00:35 +0100")
References: <1416405638-18812-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7hk32qu2w3.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> It's quite common for PM domains to use PM clocks. Typically from SOC specific
> code, the per device PM clock list is created and pm_clk_suspend|resume() are
> invoked to handle clock gating/ungating.
>
> A step towards consolidation is to integrate PM clock support into genpd, which
> is what this patchset does.
>
> In this initial step, the calls to the pm_clk_suspend|resume() are handled
> within genpd, but the per device PM clock list still needs to be created from
> SOC specific code. It seems reasonable to have gendp to handle that as well, but
> that left to future patchsets to address.

I think we need to get rid of the SoC specific code already.  For
example, we're already seeing SoCs where the arm32 core is being
replaced by an arm64 core but the other IPs, and power-domain logic is
staying more or less the same.  

> It's not every users of genpd that are keen on using PM clocks thus we need
> to provide this a configuration option for genpd.

Or more likely, probably some compatible string, or property in the
domain node.  Grygorii, Arnd and myself were discussing this elsewhere
in the context of the TI Keystone2 PM domain support[1].

Kevin

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304099.html

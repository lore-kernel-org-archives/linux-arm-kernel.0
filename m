From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Apr 2013 11:52:46 -0600
Subject: [PATCH v9 00/14] Tegra114 clockframework
In-Reply-To: <1365000110-8916-1-git-send-email-pdeschrijver@nvidia.com>
References: <1365000110-8916-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <515C6C6E.6060302@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 08:40 AM, Peter De Schrijver wrote:
> This is the nineth version of the Tegra114 clockframework. It is based on the
> next-20130320-fixed branch of
> git://nv-tegra.nvidia.com/user/swarren/linux-2.6.git,

That's not a particularly useful base; these patches won't be applied to
linux-next, but rather to Tegra's for-3.10/clk branch, with the clock
for-next tree merged in to pick up "clk: add table lookup to mux".

> http://patchwork.ozlabs.org/patch/229972/ and

That is "clk: tegra: Don't enable PLLs during early boot". That was
rejected. I assume this isn't really needed given your changelog entry
"Fixed clock initialization for audio", but rather my "clk: tegra: defer
application of init table" should be applied instead?

> http://patchwork.ozlabs.org/patch/229978/ and

For reference, that is "clk: add table lookup to mux", which is in the
clock for-next tree.

> http://patchwork.ozlabs.org/patch/233415/

That is Joseph's "clocksource: tegra: enable arch_timer". Is this
actually a dependency, or an optimization, or ...?

Rob Herring objected to that patch since it isn't necessary if his
series "ARM arch, sp804 and integrator timer CLKSRC_OF support" is applied.

If I apply just your (Peter's) CCF series without Joseph's or Rob's
patches, will everything still work, or is this a hard dependency to
create a working system?

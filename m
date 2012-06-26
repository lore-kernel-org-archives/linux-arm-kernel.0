From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Jun 2012 17:16:07 -0600
Subject: [PATCH 3/3] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <20120626230235.GX30406@opensource.wolfsonmicro.com>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <1340406842-27135-3-git-send-email-swarren@wwwdotorg.org>
 <1963397.cqAXgGafFs@ax5200p> <20120624110306.GA16455@sirena.org.uk>
 <4FEA3942.9040906@wwwdotorg.org>
 <20120626230235.GX30406@opensource.wolfsonmicro.com>
Message-ID: <4FEA42B7.9060802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2012 05:02 PM, Mark Brown wrote:
> On Tue, Jun 26, 2012 at 04:35:46PM -0600, Stephen Warren wrote:
> 
>> So I think this sm0 (and the sm1) entry might actually be
>> correct; sm0 feeds vdd_core and sm1 feeds vdd_cpu. These rails
>> have DVFS and hence the voltage can vary. I guess I should change
>> the regulator-name in these cases to something more useful than
>> the very first signal name on the schematics too.
> 
> Even if they feed these supplies are they capable of varying on
> this board if they're shared with other things?  This is one of the
> common issues with constraints...  But generally if the supply
> covers more than one thing the idiomatic thing is to list them all
> separated by / or something.

These two supplies aren't shared, it's just that the signal on the
schematic ends up being named different things in different places; on
the regulator page it's named vdd_sm0, but on some other page it gets
renamed vdd_core.

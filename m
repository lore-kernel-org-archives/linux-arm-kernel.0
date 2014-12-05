From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 05 Dec 2014 03:14:54 +0100
Subject: [PATCH V4 0/3] PM / Domains: Add initial PM clock support to genpd
In-Reply-To: <1417434623-31301-1-git-send-email-ulf.hansson@linaro.org>
References: <1417434623-31301-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <4377493.dchgvn3k6f@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 01, 2014 12:50:20 PM Ulf Hansson wrote:
> Changes in v4:
> 	-Applied acks/tested by tags.
> 	-Change name of define, affects all patches.
> 
> Changes in v3:
> 	-Fixed comments from Rafael for patch 1.
> 	-Change name of define, affects all patches.
> 
> Changes in v2:
> 	-Small fixes in patch 1.
> 
> 
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
> 
> It's not every users of genpd that are keen on using PM clocks thus we need
> to provide this a configuration option for genpd.
> 
> In patch 2 and patch 3, we convert some of the SH-MOBILE SOCs to start using the
> new PM clock support in genpd.
> 
> 
> Ulf Hansson (3):
>   PM / Domains: Initial PM clock support for genpd
>   ARM: shmobile: Convert to genpd flags for PM clocks for r8a7779
>   ARM: shmobile: Convert to genpd flags for PM clocks for R-mobile

All queued up for 3.19-rc1, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Sep 2013 12:05:23 -0600
Subject: [PATCH 05/12] clk: tegra: add header for common tegra clock IDs
In-Reply-To: <1379515331-19427-6-git-send-email-pdeschrijver@nvidia.com>
References: <1379515331-19427-1-git-send-email-pdeschrijver@nvidia.com>
 <1379515331-19427-6-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <524082E3.8070801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 08:40 AM, Peter De Schrijver wrote:
> Many clocks are common between several Tegra SoCs. Define an enum to list
> them so we can move them to separate files which can be shared between
> SoCs. Each SoC specific file will provide an array with the common clocks
> which are present on the SoC and their DT binding ID.

So, this enum is purely something internal to the driver, and is in no
way related to the DT binding clock IDs, nor the HW peripheral clock
register bits, and finally is a union of all extant clocks across all chips?

If so, I suppose it's OK to make an enum for this. If not, the same
comments I had re: trying to unify the DT binding clock IDs would apply
here; if there's no architectural guarantee that the clock IDs will be
kept the same across all future chips, assuming they are the same seems
dangerous...

From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Sat, 16 Aug 2014 01:45:13 +0300
Subject: [PATCH 1/6] clk: tegra: don't abort clk init on error
In-Reply-To: <53CE9C5F.1030005@wwwdotorg.org>
References: <1405437890-6468-1-git-send-email-pdeschrijver@nvidia.com>
 <1405437890-6468-2-git-send-email-pdeschrijver@nvidia.com>
 <53CE9C5F.1030005@wwwdotorg.org>
Message-ID: <20140815224513.GM1626@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 07:16:15PM +0200, Stephen Warren wrote:
> On 07/15/2014 09:24 AM, Peter De Schrijver wrote:
> > Just continue initializing clocks if there's an error on one of them. This
> > is useful if there's a mistake in the inittable, because the system could
> > hang if clk_disable_unused() disables some of the critical clocks in this
> > table.
> 
> If there's a problem in the init table, we should simply fix it instead
> of working around it.
> 

Yes, ofcourse. However today we silently stop processing the init_table if a
clock cannot be found. That doesn't sound right either to me and makes detecting
wrong entries in the table more complex than it should be.

> At the very least, we need to WARN on this rather than just ignoring
> problems.

Cheers,

Peter.

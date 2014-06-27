From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 27 Jun 2014 15:19:54 +0300
Subject: [PATCH] clk: tegra: export clock names for debugging
In-Reply-To: <53AC41B0.40307@wwwdotorg.org>
References: <1403797705-26910-1-git-send-email-pdeschrijver@nvidia.com>
 <53AC41B0.40307@wwwdotorg.org>
Message-ID: <20140627121954.GR3679@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 05:52:16PM +0200, Stephen Warren wrote:
> On 06/26/2014 09:48 AM, Peter De Schrijver wrote:
> > When writing a module for testing or debugging purposes, there is no way to
> > get hold of clk handles. This patch solves this by exposing all valid clocks
> > as clkdev's for the virtual device tegra-clk-debug.
> 
> This is to support clk_get_sys()?
> 

Yes.

> I guess this seems fine, so feel free to apply it, but I slightly wonder
> why not just include this change as part of the presumably local and
> never-to-be-upstreamed test/dev module?

The idea is to allow local debug modules to get hold of the struct clk *. I
don't think that's possible without using clk_get_sys()?

Cheers,

Peter.

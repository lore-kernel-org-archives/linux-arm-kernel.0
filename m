From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Feb 2013 13:31:51 +0800
Subject: [PATCH 1/1] ARM: dt: add header to define tegra20 clocks
In-Reply-To: <511D24D4.6070805@wwwdotorg.org>
References: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
 <1360823899-17846-1-git-send-email-hdoyu@nvidia.com>
 <511D24D4.6070805@wwwdotorg.org>
Message-ID: <20130219053148.GC3108@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 10:54:28AM -0700, Stephen Warren wrote:
> On 02/13/2013 11:38 PM, Hiroshi Doyu wrote:
> > To replace magic number in "clocks = <&tegra_car 28>;"
> 
> I like the concept here; I was thinking about doing this today, but you
> beat me to it:-) Feel free to create the Tegra30 header too, and modify
> all the *.dts* files.
> 
> To address other comments in this thread: Yes, I think that we will want
> to modify the clock driver to include this header to avoid
> duplication/errors (that will require adjusting Linux's include path),
> and also remove the list of IDs from the binding document; it can just
> refer the the new header by name and cause the header to *be* part of
> the binding document.

I like it, since doing so will help us hijack kernel to have dts stay
in the tree rather than going to a separate repository :)

Seriously, is maintaining dts in a separate repository still a plan?
If yes, we will have duplication problem someday anyway.

For reason of it, I vote for having dts stay in the kernel tree.

Shawn

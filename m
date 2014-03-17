From: horms@verge.net.au (Simon Horman)
Date: Mon, 17 Mar 2014 12:44:02 +0900
Subject: [PATCH] ARM: shmobile: lager-reference: Work around core clock
 issues
In-Reply-To: <87mwgpv9vo.wl%kuninori.morimoto.gx@gmail.com>
References: <1395022736-2921-1-git-send-email-horms+renesas@verge.net.au>
 <87mwgpv9vo.wl%kuninori.morimoto.gx@gmail.com>
Message-ID: <20140317034400.GC9297@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 16, 2014 at 07:26:07PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> very tiny comment
> 
> > Due to issues with runtime PM clock management, clocks not explicitly
> > managed by their drivers may not be enabled at all, or be inadvertently
> > disabled by the clk_disable_unused() late initcall.
> > 
> > Until this is fixed, add a temporary workaround, calling
> > shmobile_clk_workaround() with enable == true.
> > 
> > For now this enables the clocks for: ether, msiof1, qspi_mod, and
> > thermal. More clocks can be added if needed.
> > 
> > Based on work for the koelsch board by eert Uytterhoeven.
> 
> I guess
> 
> - Based on work for the koelsch board by eert Uytterhoeven.
> + Based on work for the koelsch board by Geert Uytterhoeven.

Thanks! I'll fix that.

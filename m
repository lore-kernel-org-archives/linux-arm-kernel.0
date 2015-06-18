From: mturquette@linaro.org (Michael Turquette)
Date: Thu, 18 Jun 2015 13:52:36 -0700
Subject: [PATCH v2] clk: mvebu: flag the crypto clk as CLK_IGNORE_UNUSED
In-Reply-To: <20150618214729.41acfb07@bbrezillon>
References: <1434470179-20835-1-git-send-email-boris.brezillon@free-electrons.com>
 <55816094.2020208@free-electrons.com> <20150618183654.25948.26168@quantum>
 <20150618214729.41acfb07@bbrezillon>
Message-ID: <20150618205236.9112.20427@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris Brezillon (2015-06-18 12:47:29)
> Hi Mike,
> 
> On Thu, 18 Jun 2015 11:36:54 -0700
> Michael Turquette <mturquette@linaro.org> wrote:
> 
> > Quoting Gregory CLEMENT (2015-06-17 04:57:08)
> > > Hi Mike, Stephen,
> > > 
> > > On 16/06/2015 17:56, Boris Brezillon wrote:
> > > > The crypto SRAM, used by the armada 370 cpuidle code to workaround a bug
> > > > in the BootROM code, requires the crypto clk to be up and running.
> > > > Flag the crypto clk as IGNORE_UNUSED until we add the proper
> > > > infrastructure to define the crypto SRAM in the DT and reference the crypto
> > > > clk in this SRAM node.
> > > > 
> > > > Reported-by: Kevin Hilman <khilman@linaro.org>
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > Tested-by: Kevin Hilman <khilman@linaro.org>
> > > > Fixes: 29e623475c50267ee3aaa49ebb6cbe107bce8d2a ("clk: mvebu: add
> > > > missing CESA gate clk").
> > > > Cc: <stable@vger.kernel.org> #4.1
> > > 
> > > Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > > 
> > > Would it possible to apply this fix on 4.1-rc8 ?
> > 
> > Hi Gregory,
> > 
> > I'm a bit confused by this. This patch fixes "clk: mvebu: add missing
> > CESA gate clk", right? That patch lives in clk-next. It was not pushed
> > to Linus' tree yet via a -fixes branch.
> > 
> > Thus I can just apply this patch to clk-next and the problem should be
> > resolved in clk-next, no?
> 
> Yes. I've tagged this patch as applicable on stable 4.1 in case it
> didn't make it in the next -rc (which should be the last one before
> 4.1 is released).

Applied to clk-next.

Regards,
Mike

> I don't know if it's a good practice, but I've had several fixes which
> missed the targeted release in the past, and tagging them as stable
> helps in getting the patches applied afterwards.
> 
> > 
> > Furthermore, I do not have 29e623475c50267ee3aaa49ebb6cbe107bce8d2a
> > anywhere in my tree. I'm not sure where this sha1 hash came from.
> 
> Oops, I mixed the commit hash in my local branch and the one in clk-next
> (4d52b2acefdfceae0e47ed08324a96f511dc80b1).
> 
> Best Regards,
> 
> Boris
> 
> -- 
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

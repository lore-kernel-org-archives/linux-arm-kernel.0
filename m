From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 15 Dec 2014 17:18:33 -0800
Subject: [PATCH] clk: Really fix deadlock with mmap_sem
In-Reply-To: <20141212232626.GY11285@n2100.arm.linux.org.uk>
References: <1418425456-19364-1-git-send-email-sboyd@codeaurora.org>
 <20141212230543.GX11285@n2100.arm.linux.org.uk>
 <20141212232416.20398.58297@quantum>
 <20141212232626.GY11285@n2100.arm.linux.org.uk>
Message-ID: <20141216011833.29014.70449@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Russell King - ARM Linux (2014-12-12 15:26:26)
> On Fri, Dec 12, 2014 at 03:24:16PM -0800, Mike Turquette wrote:
> > Quoting Russell King - ARM Linux (2014-12-12 15:05:43)
> > > On Fri, Dec 12, 2014 at 03:04:16PM -0800, Stephen Boyd wrote:
> > > > Commit 6314b6796e3c (clk: Don't hold prepare_lock across debugfs
> > > > creation, 2014-09-04) forgot to update one place where we hold
> > > > the prepare_lock while creating debugfs directories. This means
> > > > we still have the chance of a deadlock that the commit was trying
> > > > to fix. Actually fix it by moving the debugfs creation outside
> > > > the prepare_lock.
> > > > 
> > > > Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
> > > 
> > > Please use "Russell King <rmk+kernel@arm.linux.org.uk>" rather than this
> > > address, thanks.
> > 
> > Applied to clk-next and fixed up the email address locally.
> 
> Please make sure it gets into stable kernels too as v3.18 suffers from
> this bug, thanks.

Final version of this in my tree removes lockdep_assert (not mentioned
in commitlog and had a bug in it), adds Cc: stable and Thomas's
reviewed-by.

Regards,
Mike

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.

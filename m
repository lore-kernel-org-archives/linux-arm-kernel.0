From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 24 Sep 2011 18:39:09 +0800
Subject: [PATCH v2 2/2] ARM: smp_scu: remove __init annotation from
	scu_enable()
In-Reply-To: <20110923204955.GV17169@n2100.arm.linux.org.uk>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<1315288107-14689-3-git-send-email-shawn.guo@linaro.org>
	<20110917083236.GB26572@S2100-06.ap.freescale.net>
	<20110922150359.GB15024@S2100-06.ap.freescale.net>
	<20110923204955.GV17169@n2100.arm.linux.org.uk>
Message-ID: <20110924103908.GA16175@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 09:49:55PM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 22, 2011 at 11:04:01PM +0800, Shawn Guo wrote:
> > On Sat, Sep 17, 2011 at 04:32:37PM +0800, Shawn Guo wrote:
> > > On Tue, Sep 06, 2011 at 01:48:27PM +0800, Shawn Guo wrote:
> > > > When Cortex-A9 MPCore resumes from Dormant or Shutdown modes,
> > > > SCU needs to be re-enabled.  This patch removes __init annotation
> > > > from function scu_enable(), so that platform resume procedure can
> > > > call it to re-enable SCU.
> > > > 
> > > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > > ---
> > > 
> > > Hi Russell,
> > > 
> > > Do you have any comment on this patch?  Can I put it into patch tracker?
> > > 
> > Ping x 2.
> > 
> > As imx6q suspend support depends on this patch, I really need to know
> > if you will merge it.  Otherwise, I will probably have to copy the code
> > into imx6q platform code just like exynos4 is doing.
> 
> It's fine.
> 
I'm unsure about this comment.  Does it mean that the patch looks fine
for being merged, or it's fine to duplicate the code in imx6q platform?

-- 
Regards,
Shawn

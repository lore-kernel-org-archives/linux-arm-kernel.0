From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 17:07:18 +0800
Subject: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl support
In-Reply-To: <20120510084403.GA3908@opensource.wolfsonmicro.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-4-git-send-email-richard.zhao@freescale.com>
 <20120509160005.GG3955@opensource.wolfsonmicro.com>
 <20120510003532.GG2982@b20223-02.ap.freescale.net>
 <20120510063904.GB17875@S2101-09.ap.freescale.net>
 <20120510084403.GA3908@opensource.wolfsonmicro.com>
Message-ID: <20120510090715.GF17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 09:44:04AM +0100, Mark Brown wrote:
> On Thu, May 10, 2012 at 02:39:06PM +0800, Shawn Guo wrote:
> > On Thu, May 10, 2012 at 08:35:33AM +0800, Richard Zhao wrote:
> 
> > > It's based on your for-next. But for working, it depends on
> > > pinctl/for-next.
> 
> > Mark, may I have your ack to have it go through arm-soc?  I will ask
> > Arnd pull your sound/for-v3.5 branch into arm-soc as a dependency.
> > You need to ensure the branch will not be rebased.
> 
> for-3.5 is the entire undifferentiated blob of ASoC stuff, it's not
> really suitable for merging elsewhere.  It won't actually get rebased
> but the idea of merging it into other trees doesn't seem terribly
> clever, it'd make having topic branches in arm-soc a bit of a joke and
> if you pull it right now you'll get problems in -next due to the the
> ux500 stuff.
> 
Pulling it into arm-soc as a dependency only means we will have it as
a base for other branches that depend on.  It does not change anything
about how the branch flows to Linus.  Arnd will only send those arm-soc
branches that depend on sound/for-3.5 after it gets merged by Linus.

> What does "working" mean in this context - what happens without the
> pinctl changes?

It will break all the imx-audmux users that haven't got any pinctrl
states defined for imx-audmux.  We have patches on imx (arm-soc) tree
defining pinctrl states either in DT or dummy states in board files
to make sure pinctrl API works fine for every imx-audmux users. 

-- 
Regards,
Shawn

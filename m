From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 24 Jan 2015 12:48:51 +0100 (CET)
Subject: [PATCH v2 RESEND 2/8] irqchip: Supply new driver for STi based
 devices
In-Reply-To: <20150123163231.GB11745@x1>
References: <1421920133-7914-1-git-send-email-lee.jones@linaro.org>
 <1421920133-7914-3-git-send-email-lee.jones@linaro.org>
 <alpine.DEB.2.11.1501231702280.5526@nanos> <20150123163231.GB11745@x1>
Message-ID: <alpine.DEB.2.11.1501241246240.5526@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Jan 2015, Lee Jones wrote:
> On Fri, 23 Jan 2015, Thomas Gleixner wrote:
> > The only technical comment I have is: shouldn't all the stuff except
> > the resume function be marked __init or is any of this required post
> > init?
> 
> It's not common to mark functions invoked at and affter *_probe() as
> __init.  At least, not as far as I'm aware.

Right, if the probe stuff is supposed to be functional post init, then
we of course need to keep it around. But I guess we have no mechanism
to distinguish the 'boot only' and 'keep post init' case. Might be
worthwhile to investigate.

Thanks,

	tglx

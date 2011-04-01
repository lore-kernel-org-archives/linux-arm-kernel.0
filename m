From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 1 Apr 2011 15:30:07 +0200
Subject: [PATCH v2 1/1] ARM: imx: add gpu device
In-Reply-To: <AANLkTi=x=E2mSqFC-r7vC1hGBL+rJJ=XNWEY6a_UT-nE@mail.gmail.com>
References: <1301465128-401-1-git-send-email-richard.zhao@freescale.com>
	<20110330073651.GR7285@pengutronix.de>
	<AANLkTikf63wTfM1z2cpV+GuK28y1wrT7UWvw4TanBj4R@mail.gmail.com>
	<20110331082601.GV7285@pengutronix.de>
	<AANLkTi=x=E2mSqFC-r7vC1hGBL+rJJ=XNWEY6a_UT-nE@mail.gmail.com>
Message-ID: <20110401133007.GA7285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mat,,

On Thu, Mar 31, 2011 at 07:36:33PM -0500, Matt Sealey wrote:
> We have a plan to port it to DRM, We even started for it. But it needs
> to work first, so we can get our reference on. Ports like this are
> best done slowly - you make it work, you do it piece by piece. We
> already did the GEM allocation and unified IPU and GPU memory
> allocation (after all framebuffer memory *is* texture memory on every
> other graphics card and the IPU/VPU/GPU need to be able to access each
> other's memory - they all share an EMI/AXI arbiter anyway). That in
> itself allows us to lock down the GPU using the AMD MMU which defines
> a 32MB-aligned window which the GPU can write into (otherwise the GPU
> can touch system memory). Then we just need to do the command stream
> stuff and properly port the IPU framebuffer to DRM Connectors and
> Encoders, so XRandR will magically work, we can stop using fbdevhw
> evil, and so on.

That's very good news. I hope you make good progress in this.

Once there is source code available which is useful to anything else but
provide a stub for a binary only userspace driver I'm of course open for
merging it.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

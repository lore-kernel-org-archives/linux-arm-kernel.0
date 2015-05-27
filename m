From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 May 2015 19:54:19 +0800
Subject: [PATCH v2 1/2] ARM: imx: enable smp for i.MX7D
In-Reply-To: <CAHrpEqS1ESjTdAq-ncm597kAt3D6GbmTSAtNchu-aTwFatKpdg@mail.gmail.com>
References: <1432147961-3547-1-git-send-email-Frank.Li@freescale.com>
 <20150525081928.GK3264@dragon>
 <CAHrpEqS1ESjTdAq-ncm597kAt3D6GbmTSAtNchu-aTwFatKpdg@mail.gmail.com>
Message-ID: <20150527115418.GG16165@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 10:01:00AM -0500, Zhi Li wrote:
> what's name do you prefer?

If we have to create a new driver, I prefer to name it after imx7.

> Totally difference.
> 
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/mach-imx/gpcv2.c?h=imx_3.14.28_7d_alpha&id=a34e259cc0a4e86ccb993c947991d2823d81eb14
> 
> Only simular part is that GPC irq mask, which only bit possition and
> register offfset change.

So at least GPC needs to be initialized as stacked IRQ domain.  Please
check out commit b923ff6af0d5 (ARM: imx6: convert GPC to stacked
domains) for how it should be done.

Shawn

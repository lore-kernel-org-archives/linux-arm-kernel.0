From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Jun 2013 15:29:09 +0800
Subject: [PATCH 2/2] ARM: dts: mx28: Fix sgtl5000 codec probe
In-Reply-To: <CAOMZO5DYNmiasRREC8jXH===2HG1aNvpxpFVU2u+q5ZAT8Wd3Q@mail.gmail.com>
References: <1371849720-14506-1-git-send-email-festevam@gmail.com>
 <CAOMZO5AN7+ZodLwxNbRKk4ixheFkL4T=OdphXXRRu_Qmv30JjQ@mail.gmail.com>
 <CAOMZO5DUsGpffGOkEjZX3JaKcJxV6GsH_pOyX=dhHxq3vB9xQA@mail.gmail.com>
 <201306221524.33879.marex@denx.de>
 <CAOMZO5DYNmiasRREC8jXH===2HG1aNvpxpFVU2u+q5ZAT8Wd3Q@mail.gmail.com>
Message-ID: <20130624072908.GH26254@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 11:04:41AM -0300, Fabio Estevam wrote:
> On Sat, Jun 22, 2013 at 10:24 AM, Marek Vasut <marex@denx.de> wrote:
> 
> > Yuck, I see. This is really ugly :(
> >
> > Just an idea here, can we not maybe defer the SGTL5000 I2C probe?
> 
> This was already discussed in the alsa-devel list, and the
> recommendation was that sgtl5000 should acquire its clock in i2c
> probe.

Yes, we should have sgtl5000 acquire its clock, but when it fails to do
so, there is nothing wrong with deferring it to see if mxs-saif would
provide the clock later.

That said, I do not like the patch, and we should try to have mxs-saif
driver implement and register the clock.

Shawn

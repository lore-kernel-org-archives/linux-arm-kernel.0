From: marex@denx.de (Marek Vasut)
Date: Sat, 22 Jun 2013 15:24:33 +0200
Subject: [PATCH 2/2] ARM: dts: mx28: Fix sgtl5000 codec probe
In-Reply-To: <CAOMZO5DUsGpffGOkEjZX3JaKcJxV6GsH_pOyX=dhHxq3vB9xQA@mail.gmail.com>
References: <1371849720-14506-1-git-send-email-festevam@gmail.com>
 <CAOMZO5AN7+ZodLwxNbRKk4ixheFkL4T=OdphXXRRu_Qmv30JjQ@mail.gmail.com>
 <CAOMZO5DUsGpffGOkEjZX3JaKcJxV6GsH_pOyX=dhHxq3vB9xQA@mail.gmail.com>
Message-ID: <201306221524.33879.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> On Sat, Jun 22, 2013 at 12:47 AM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Fri, Jun 21, 2013 at 11:31 PM, Marek Vasut <marex@denx.de> wrote:
> >> Should the SAIF block reset not happen in the driver?
> > 
> > We need to clear SFTRST and CLKGATE here in order to get MCLK output.
> 
> Just to clarify: the sgtl500 i2c probe happens prior to the mxs saif
> probe, so that's why we can't wait for the mxs-saif to turn on the
> clocks.

Yuck, I see. This is really ugly :(

Just an idea here, can we not maybe defer the SGTL5000 I2C probe?

Best regards,
Marek Vasut

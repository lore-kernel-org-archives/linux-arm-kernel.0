From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 22 Jun 2013 00:54:47 -0300
Subject: [PATCH 2/2] ARM: dts: mx28: Fix sgtl5000 codec probe
In-Reply-To: <CAOMZO5AN7+ZodLwxNbRKk4ixheFkL4T=OdphXXRRu_Qmv30JjQ@mail.gmail.com>
References: <1371849720-14506-1-git-send-email-festevam@gmail.com>
 <1371849720-14506-2-git-send-email-festevam@gmail.com>
 <201306220431.50879.marex@denx.de>
 <CAOMZO5AN7+ZodLwxNbRKk4ixheFkL4T=OdphXXRRu_Qmv30JjQ@mail.gmail.com>
Message-ID: <CAOMZO5DUsGpffGOkEjZX3JaKcJxV6GsH_pOyX=dhHxq3vB9xQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 12:47 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, Jun 21, 2013 at 11:31 PM, Marek Vasut <marex@denx.de> wrote:
>
>> Should the SAIF block reset not happen in the driver?
>
> We need to clear SFTRST and CLKGATE here in order to get MCLK output.

Just to clarify: the sgtl500 i2c probe happens prior to the mxs saif
probe, so that's why we can't wait for the mxs-saif to turn on the
clocks.

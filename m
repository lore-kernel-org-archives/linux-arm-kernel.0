From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Fri, 27 May 2016 23:26:41 +0530
Subject: [PATCH v3 4/4] soc: Add SoC driver for Freescale Vybrid platform
In-Reply-To: <475f53d2bb4c611bfe1c6652215b8626@agner.ch>
References: <cover.1463737502.git.maitysanchayan@gmail.com>
 <CAL_JsqKCwy=aXveTfnaQuZ5b3Ld9nzABgPfdPm1JX3CBuvzG+Q@mail.gmail.com>
 <20160527063301.GB1554@Sanchayan-Arch.localdomain>
 <9495361.v6aft1QR0M@wuerfel>
 <20160527100817.GA8294@Sanchayan-Arch.localdomain>
 <475f53d2bb4c611bfe1c6652215b8626@agner.ch>
Message-ID: <20160527175641.GA10705@Sanchayan-Arch.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stefan,

On 16-05-27 10:28:45, Stefan Agner wrote:
> On 2016-05-27 03:08, maitysanchayan at gmail.com wrote:
> > On 16-05-27 10:31:55, Arnd Bergmann wrote:
> >> On Friday, May 27, 2016 12:03:01 PM CEST maitysanchayan at gmail.com wrote:
> >> >
> >> > So if I understand correctly, the binding at the SoC level is fine.
> >> > Keeping that but removing the additional made-up properties, viz. below
> >> >
> >> > rom-revision: phandle to the on-chip ROM node
> >> > mscm: phandle to the MSCM CPU configuration node
> >> > nvmem-cells: phandles to two OCOTP child nodes ocotp_cfg0 and ocotp_cfg1
> >> > nvmem-cell-names: should contain string names "cfg0" and "cfg1"
> >> >
> >> > would be fine?
> >> >
> >> > We would have something similar to here
> >> > http://www.spinics.net/lists/devicetree/msg80655.html
> >> >
> >> > but now with the DT binding under SoC bus.
> >> >
> >>
> >>
> >> You look up the OTP device as a syscon here, which seems odd since there
> >> is already an nvmem driver for it. Shouldn't you use the nvmem API for
> >> that?
> >>
> >> 	Arnd
> > 
> > I need the following 
> > 
> > nvmem-cells: phandles to two OCOTP child nodes ocotp_cfg0 and ocotp_cfg1
> > nvmem-cell-names: should contain string names "cfg0" and "cfg1"
> > 
> > to be able to use the NVMEM consumer API.
> 
> I did not tested it, but it seems the NVMEM consumer API has some kind
> of non-DT fallback:
> http://lxr.free-electrons.com/source/drivers/nvmem/core.c#L827
> 
> Right now, it seems to me that it does not handle the case where we have
> a of_node but don't want to use it... You might need to add some extra
> handling if there is a of_node without nvmem-cell-names/nvmem-cells, and
> fall back to nvmem_cell_get_from_list.
> 

I have already looked at the core nvmem code for options but wanted to avoid
any additons if possible.

However if adding the nvmem properties at the SoC node level is frowned upon
I will make the necessary changes required.

Regards,
Sanchayan.

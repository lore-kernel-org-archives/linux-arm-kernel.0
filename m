From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 May 2016 10:31:55 +0200
Subject: [PATCH v3 4/4] soc: Add SoC driver for Freescale Vybrid platform
In-Reply-To: <20160527063301.GB1554@Sanchayan-Arch.localdomain>
References: <cover.1463737502.git.maitysanchayan@gmail.com>
 <CAL_JsqKCwy=aXveTfnaQuZ5b3Ld9nzABgPfdPm1JX3CBuvzG+Q@mail.gmail.com>
 <20160527063301.GB1554@Sanchayan-Arch.localdomain>
Message-ID: <9495361.v6aft1QR0M@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 27, 2016 12:03:01 PM CEST maitysanchayan at gmail.com wrote:
> 
> So if I understand correctly, the binding at the SoC level is fine.
> Keeping that but removing the additional made-up properties, viz. below
> 
> rom-revision: phandle to the on-chip ROM node
> mscm: phandle to the MSCM CPU configuration node
> nvmem-cells: phandles to two OCOTP child nodes ocotp_cfg0 and ocotp_cfg1
> nvmem-cell-names: should contain string names "cfg0" and "cfg1"
> 
> would be fine?
> 
> We would have something similar to here
> http://www.spinics.net/lists/devicetree/msg80655.html
> 
> but now with the DT binding under SoC bus.
> 


You look up the OTP device as a syscon here, which seems odd since there
is already an nvmem driver for it. Shouldn't you use the nvmem API for
that?

	Arnd

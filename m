From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Sat, 8 Sep 2018 12:06:15 +0200
Subject: [PATCH 0/2] Follow-up patches for Cedrus v9
In-Reply-To: <20180907163347.32312-1-contact@paulk.fr>
References: <20180907163347.32312-1-contact@paulk.fr>
Message-ID: <11104c03-97ac-8b36-7d75-dfecb8fcce10@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2018 06:33 PM, Paul Kocialkowski wrote:
> This brings the requested modifications on top of version 9 of the
> Cedrus VPU driver, that implements stateless video decoding using the
> Request API.
> 
> Paul Kocialkowski (2):
>   media: cedrus: Fix error reporting in request validation
>   media: cedrus: Add TODO file with tasks to complete before unstaging
> 
>  drivers/staging/media/sunxi/cedrus/TODO     |  7 +++++++
>  drivers/staging/media/sunxi/cedrus/cedrus.c | 15 ++++++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/staging/media/sunxi/cedrus/TODO
> 

So close...

When compiling under e.g. intel I get errors since it doesn't know about
the sunxi_sram_claim/release function and the PHYS_PFN_OFFSET define.

Is it possible to add stub functions to linux/soc/sunxi/sunxi_sram.h
if CONFIG_SUNXI_SRAM is not defined? That would be the best fix for that.

The use of PHYS_PFN_OFFSET is weird: are you sure this is the right
way? I see that drivers/of/device.c also sets dev->dma_pfn_offset, which
makes me wonder if this information shouldn't come from the device tree.

You are the only driver that uses this define directly, which makes me
suspicious.

Regards,

	Hans

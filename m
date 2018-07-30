From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Mon, 30 Jul 2018 20:41:31 +0530
Subject: [PATCH 0/9] Add Reset Controller support for Actions Semi Owl SoCs
In-Reply-To: <c3ae668a-6bcc-a0eb-1e00-14ef9d607316@suse.de>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
 <c3ae668a-6bcc-a0eb-1e00-14ef9d607316@suse.de>
Message-ID: <20180730151131.GA28633@mani>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On Mon, Jul 30, 2018 at 12:26:07PM +0200, Andreas F?rber wrote:
> Hi Mani,
> 
> Am 27.07.2018 um 20:45 schrieb Manivannan Sadhasivam:
> > This patchset adds Reset Controller (RMU) support for Actions Semi
> > Owl SoCs, S900 and S700. For the Owl SoCs, RMU has been integrated into
> > the clock subsystem in hardware. Hence, in software we integrate RMU
> > support into common clock driver inorder to maintain compatibility.
> 
> Can this not be placed into drivers/reset/ by using mfd-simple with a
> sub-node in DT?
> 

Actually I was not sure where to place this reset controller driver. When I
looked into other similar ones such as sunxi, they just integrated into the
clk subsystem. So I just chose that path. But yeah, this is hacky!

But this RMU is not MFD by any means. Since the CMU (Clock) and RMU (Reset)
are two separate IPs inside SoC, we shouldn't describe it as a MFD driver. Since
RMU has only 2 registers, the HW designers decided to use up the CMU memory
map. So, maybe syscon would be best option I think. What is your opinion?

Even if we go for syscon, we should place the reset driver within clk
framework as I can see other SoCs like Mediatek are doing the same. But again
I'm not sure!

Thanks,
Mani

> Regards,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)

From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Tue, 22 Sep 2009 16:09:16 +0200
Subject: SPI, DMA and an i.MX31
In-Reply-To: <87077C4F48609F4392621D9F99DDE20901202E02@tesla.star.galaxy.io>
References: <87077C4F48609F4392621D9F99DDE20901202DFF@tesla.star.galaxy.io>
	<BLU105-W229F8F8F533B107510C600BAE10@phx.gbl>
	<87077C4F48609F4392621D9F99DDE20901202E00@tesla.star.galaxy.io>
	<4AB7C020.2070205@gmail.com> <4AB839FF.4000803@windriver.com>
	<87077C4F48609F4392621D9F99DDE20901202E02@tesla.star.galaxy.io>
Message-ID: <59b21cf20909220709w54b9e259ube473b322d661a65@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

2009/9/22 Wolf, Rene, HRO-GP <rene.wolf@mbda-systems.de>:
> Hi @ all!
>
> Wow, there seams to be some interest in this :-)
>
>> Freescale has released a BSP for i.MX31 based on kernel 2.6.26. Don't
>> know how much it differs in the DMA areas but it might be good to
>> check it out and use that as well as a base for your work on i.MX31-DMA
>> in 2.6.31. (freescale.com/imx31 => Software & Tools => i.MX31PDK =>
>> Downloads)
>
> Jep. As far as I can remember I did check it and that was a binary only
> release or I just overlooked the interesting stuff... I will have a
> second look at it.

Depends on what you mean by "binary only", the source code for
Freescale's Linux is available in the BSP but no source for the SDMA
is included.

>
>> It would be very nice to have i.MX31 DMA support in mainline, that would
>> perhaps also make it possible to have ALSA sound support for i.MX31.
>
> Hmm, would that be ok by the GPL and stuff. Coz the actual 'firmware'
> is binary only, though it is packed as a 'short' array inside
> 'sdma_script_code.h' & 'sdma_script_code_pass2.h'?

That might be a problem. Binary firmware can be handled in Linux, as
an example one can load it from user space but that makes it difficult
to enable the SDMA before userspace has started. Another example is to
let the bootloader load the SDMA scripts but that's not a nice
solution. Don't know if this firmware can be accepted as a binary
within the kernel.

Perhaps there are other ways.

Regards, Magnus

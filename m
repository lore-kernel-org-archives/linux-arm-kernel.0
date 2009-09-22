From: bgat@billgatliff.com (Bill Gatliff)
Date: Tue, 22 Sep 2009 11:22:06 -0500
Subject: SPI, DMA and an i.MX31
In-Reply-To: <59b21cf20909220709w54b9e259ube473b322d661a65@mail.gmail.com>
References: <87077C4F48609F4392621D9F99DDE20901202DFF@tesla.star.galaxy.io>	<BLU105-W229F8F8F533B107510C600BAE10@phx.gbl>	<87077C4F48609F4392621D9F99DDE20901202E00@tesla.star.galaxy.io>	<4AB7C020.2070205@gmail.com>
	<4AB839FF.4000803@windriver.com>	<87077C4F48609F4392621D9F99DDE20901202E02@tesla.star.galaxy.io>
	<59b21cf20909220709w54b9e259ube473b322d661a65@mail.gmail.com>
Message-ID: <4AB8F9AE.1070006@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Magnus Lilja wrote:
>
> That might be a problem. Binary firmware can be handled in Linux, as
> an example one can load it from user space but that makes it difficult
> to enable the SDMA before userspace has started. Another example is to
> let the bootloader load the SDMA scripts but that's not a nice
> solution. Don't know if this firmware can be accepted as a binary
> within the kernel.
>   

It couldn't be a "binary" in the kernel per se, it would be a constant
character array that gets compiled into a binary chunk.  Sort of like
how, for example, Keyspan's drivers are done.  See
linux/firmware/README.AddingFirmware, linux/firmware/keyspan and
drivers/usb/serial/keyspan*.


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com

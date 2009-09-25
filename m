From: andy@warmcat.com (Andy Green)
Date: Fri, 25 Sep 2009 08:26:12 +0100
Subject: SPI, DMA and an i.MX31
In-Reply-To: <87077C4F48609F4392621D9F99DDE20901202E06@tesla.star.galaxy.io>
References: <4AB8F9AE.1070006@billgatliff.com>	<59b21cf20909221245i355ccea0r44737e9112fd17c0@mail.gmail.com>
	<87077C4F48609F4392621D9F99DDE20901202E06@tesla.star.galaxy.io>
Message-ID: <4ABC7094.9000701@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/09 11:51, Somebody in the thread at some point said:

Hi Rene -

> The drivers/mmc/host/mxcmmc.c from 2.6.31 uses some different dma api: all
> those fkt start with 'imx_', the sdma's from the ltib have a 'mxc' prefix.
> I tried to match them and wrap those 'mxc' in defines, mapping them to the
> 'imx' ones. Unfortunately for some fkts I didn't find a matching 'mxc' one.
> The driver compiles, but I guess it's pretty useless the way it is. May be
> I should have looked to the driver version in ltib, instead.
>
> After that I tried to register a SDMA channel with a device. As far as I
> can see that works. The Registered channel shows under
> '/proc/sdma/channels'. Freeing that also works.
>
> Next: Will try to start a SDMA transfer with SPI.

Thanks a lot for taking a look at it anyway.

Since this mxcmmc.c imx_ stuff is platform stuff cover mx1 and mx2, I 
guess there'll be trouble getting any mx3 DMA stuff accepted that 
doesn't play along with its existing game or change them all to some 
more standard method.

-Andy

From: agross@codeaurora.org (Andy Gross)
Date: Wed, 11 Jun 2014 23:02:17 -0500
Subject: [PATCH 1/4] spi: qup: Remove chip select function
In-Reply-To: <1400486858.1464.11.camel@iivanov-dev>
References: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
 <1400016884-9568-2-git-send-email-agross@codeaurora.org>
 <1400486858.1464.11.camel@iivanov-dev>
Message-ID: <20140612040217.GA32535@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 11:07:38AM +0300, Ivan T. Ivanov wrote:
<snip>
 
> > +- num-cs:	total number of chipselects
> 
> My understanding is that "num-cs" have to be parsed by
> master driver, not by core SPI driver.

Right.  I need to parse it and check vs the max cs and use that value to set the
master->num_chipselect

> 
> > -
> > -	/* Disable auto CS toggle and use manual */
> > -	iocontol &= ~SPI_IO_C_MX_CS_MODE;
> 
> Probably we should keep this?

Actually this is cleared in the probe during the initial settings of IO_CONTROL.
So this isn't necessary.


-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

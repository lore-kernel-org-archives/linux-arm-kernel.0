From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 18 Nov 2013 14:56:14 +0000
Subject: [PATCH 02/10] mtd: st_spi_fsm: Supply all register address and
 bit logic defines
In-Reply-To: <20131118144512.GB24408@sirena.org.uk>
References: <1384438956-31153-1-git-send-email-lee.jones@linaro.org>
 <1384438956-31153-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdaccxcTfKc-y7rPEH1H3yua3ubLvuvTzWnMs1rOwjiVNw@mail.gmail.com>
 <20131118093229.GB13640@lee--X1>
 <20131118133940.GC14306@sirena.org.uk>
 <20131118142447.GJ13640@lee--X1>
 <20131118144512.GB24408@sirena.org.uk>
Message-ID: <20131118145614.GM13640@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Nov 2013, Mark Brown wrote:

> On Mon, Nov 18, 2013 at 02:24:47PM +0000, Lee Jones wrote:
> 
> > For example, we have thought about inserting a layer which handles the
> > type of communication that'll be utilised i.e. true SPI, or our
> > bespoke FSM implementation for instance. This would enable us to issue
> > serial_flash_write(), serial_flash_write_then_read(), ... in the m25p80
> > driver and not care which protocol is used. However, in reality this
> > won't really save a great deal of code - not in our case at least.
> 
> Right, that's what I'm suggesting.  It's not so much for the code saving
> as for the data saving, allowing device trees that just say "flash chip
> X is connected" rather than requiring either the flash chip information
> in multiple places in the kernel or (worse) have the commands added to
> the DTs of individual boards using the flash chip.

I think it's a good idea for people using the m25p80, but still
doesn't effect us. All of our chips are dynamically probable. We are
moving completely away from saying anything is connected using DT or
platform data. The FSM will be registered and will dynamically add
devices based on what it can find. We have no plans to use any of the
m25p80 functionality, as it's almost completely different.

I'm keen on the reuse of frameworks and abstracting common code, but
there just isn't any in our case.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

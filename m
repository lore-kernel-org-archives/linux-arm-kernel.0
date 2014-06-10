From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 10 Jun 2014 21:59:59 +0200
Subject: [PATCH 1/2 v2] spi: s3c64xx: use "cs-gpios" from spi node instead
 of "cs-gpio"
In-Reply-To: <CAD=FV=X5nLM3Yqkvk+UqVZPFzVNHmPDn3y+euYDwZ3M2bG+0Cg@mail.gmail.com>
References: <1402394881-31564-1-git-send-email-ch.naveen@samsung.com>	<1402394881-31564-2-git-send-email-ch.naveen@samsung.com>	<53976154.60308@gmail.com>
 <CAD=FV=X5nLM3Yqkvk+UqVZPFzVNHmPDn3y+euYDwZ3M2bG+0Cg@mail.gmail.com>
Message-ID: <539763BF.1030209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.06.2014 21:58, Doug Anderson wrote:
> Tomasz,
> 
> On Tue, Jun 10, 2014 at 12:49 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> This is wrong. The "cs-gpios" property is supposed to be an array,
>> indexed by chip select number of SPI devices (indicated by their "reg"
>> properties).
>>
>> Moreover, is there a need to parse this manually in this driver? I can
>> see respective parsing code in of_spi_register_master().
> 
> I noticed this too (see my response), but I was confused about the
> fact that nobody else uses the array created by
> of_spi_register_master().  Any idea why?

Hmm, I can see of_spi_register_master() assigning allocated pointer to
master->cs_gpios, which is then used in spi_add_device() as follows:

	if (master->cs_gpios)
		spi->cs_gpio = master->cs_gpios[spi->chip_select];

Best regards,
Tomasz

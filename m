From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 18 Jul 2012 14:38:54 +0200
Subject: MXS i2c PIOQ/DMA mode selection via DT
In-Reply-To: <201207161605.44379.marek.vasut@gmail.com>
References: <201207161605.44379.marek.vasut@gmail.com>
Message-ID: <201207181438.54721.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hello,
> 
> There's been this patch going on, which adds DMA mode into MXS i2c driver:
> https://patchwork.kernel.org/patch/1174051/
> 
> Recent nitpick was about toggling the PIOQUEUE (almost like PIO, only
> transfer mode in current implementation) vs. DMA mode (newly added) on a
> per-bus basis.
> 
> Current implementation in the patch adds a DT property, "fsl,use-pio"
> (shall be changed to "fsl,use-pioqueue", but that's irrelevant) to select
> between the PIOQUEUE and DMA mode on per-bus basis.
> 
> There was now a suggestion to dump this property and use kernel module
> parameter instead. This obviously disallows to configure this behavior on
> per-bus basis. Consider a scenario where small transfers happens on one
> bus (possibly from a sensor) and large transfers on the other bus (eg. i2c
> EEPROM). In such scenario, it's beneficial to enable PIOQUEUE mode for the
> sensor and DMA mode for the EEPROM to minimize the overall overhead.
> 
> The mixed mode (PIOQ for small data and DMA for large data transfers) isn't
> supported yet.
> 
> Please advise.
> 
> Best regards,
> Marek Vasut

BUMP?

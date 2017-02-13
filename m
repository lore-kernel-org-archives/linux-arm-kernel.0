From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Feb 2017 12:52:39 +0000
Subject: [PATCH v2] ARM: spi/sun7i: Add Master Sample Data Mode for SPI
In-Reply-To: <20170211035447.3819-1-viniciusfre@gmail.com>
References: <20170211035447.3819-1-viniciusfre@gmail.com>
Message-ID: <20170213125239.f5vsxrfwz5t6gqyp@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 11, 2017 at 12:54:47AM -0300, Vinicius Maciel wrote:
> In order to work appropriately, the max11043 ADC chip and probably
> others, needs SPI master samples the data at the correct edge. From
> max11043 datasheet: "The data at DIN is latched on the rising edge
> of SCLK". Same to DOUT.
> 
> This patch add Master Sample Data Mode bit in normal sample mode.
> It will affect only A20.

This should be controlled by the SPI mode settings, different chips have
different requirements.  If the controller supports multiple modes then
it should expose that and let the drivers and system integrations
choose.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170213/aa159db6/attachment.sig>

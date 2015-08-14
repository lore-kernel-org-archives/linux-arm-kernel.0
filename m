From: broonie@kernel.org (Mark Brown)
Date: Fri, 14 Aug 2015 20:30:15 +0100
Subject: [PATCH] spi: imx: fix ecspi mode setup
In-Reply-To: <CAN8RqkDrc9sqsbv360yuu7cN3dg527vEomu+FakqnkbTgGZtzQ@mail.gmail.com>
References: <1436880205-25023-1-git-send-email-qxovxp@gmail.com>
 <20150714134934.GV11162@sirena.org.uk>
 <CAN8RqkDrc9sqsbv360yuu7cN3dg527vEomu+FakqnkbTgGZtzQ@mail.gmail.com>
Message-ID: <20150814193015.GN10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 07:06:36PM +0300, Andrew Kuksov wrote:
> >> Fixed problem with setting spi mode 0 or 1 after setting mode 2 or 3

> > What is the problem and how does this change fix it (this information
> > should be in the changelog)?

> SPI_MODE_0 and SPI_MODE_1 requires clock low when inactive. SPI_MODE_2
> and SPI_MODE_3 requires clk high when inactive.
> Currently driver can just set bits in fields SCLK_PHA (SPI Clock/Data
> Phase Control), SCLK_POL (SPI Clock Polarity Control),
> SCLK_CTL (controls the inactive state of SCLK) ans SS_POL (SPI SS
> Polarity Select) of ECSPIx_CONFIGREG register.
> This patch allows driver to clear corresponding bits in these fields.

Please provide a patch with a changelog more like this...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150814/950f0023/attachment.sig>

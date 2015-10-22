From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Oct 2015 02:08:47 +0900
Subject: [PATCH] spi: imx: fix ecspi mode setup
In-Reply-To: <CAN8RqkDrc9sqsbv360yuu7cN3dg527vEomu+FakqnkbTgGZtzQ@mail.gmail.com>
References: <1436880205-25023-1-git-send-email-qxovxp@gmail.com>
 <20150714134934.GV11162@sirena.org.uk>
 <CAN8RqkDrc9sqsbv360yuu7cN3dg527vEomu+FakqnkbTgGZtzQ@mail.gmail.com>
Message-ID: <20151022170847.GA29919@sirena.org.uk>
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

OK...  when I was asking for this to be in the changelog what I meant
was that you should send a new patch with a changelog including the
relevant description.  I've done that by hand now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151023/440bd96b/attachment.sig>

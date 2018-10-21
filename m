From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 21 Oct 2018 23:45:54 +0200
Subject: [PATCH 0/15] Add support for OLPC XO 1.75 Embedded Controller
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
Message-ID: <20181021214554.i2mb5yn2doabyt5a@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 10, 2018 at 07:22:45PM +0200, Lubomir Rintel wrote:
> Hi.
> 
> This patchset adds support for the Embedded Controller on an OLPC XO
> 1.75 machine. OLPC XO 1.75 is a MMP2 based ARM laptop. It plugs into
> the existing OLPC platform infrastructure, currently used by the x86
> based models.
> 
> The EC operates in SPI master mode, meaning the SOC is the SPI slave. It
> uses extra handshake signal to signal readiness of SOC to accept data
> from EC and to initiate a transaction if SOC wishes to submit data.
> 
> The SPI slave support for MMP2 was submitted separately:
> https://lore.kernel.org/lkml/20181010170936.316862-1-lkundrak at v3.sk/T/#t
> 
> THe "power: supply: olpc_battery: correct the temperature" patch was
> already sent out separately, but I'm including it because the last
> commit of the set depends on it.
> 
> Tested to work on an OLPC XO 1.75 and also tested not to break x86
> support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> unlikely this breaks it when XO 1 works.
> 
> Thanks in advance for reviews and feedback of any kind.

I reviewed the power-supply related patches (1, 10, 12-15) and think
they are fine apart from the things found by Andy Shevchenko.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181021/13fd8e3c/attachment.sig>

From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 18 Mar 2015 22:07:30 +0100
Subject: [PATCH 2/2] i2c: driver for the Conexant Digicolor I2C controller
In-Reply-To: <a106023efa9fd648f46021cd063437df798528de.1424092804.git.baruch@tkos.co.il>
References: <7da767503ac6085c10fbd1953ffd36621b8bf0c5.1424092804.git.baruch@tkos.co.il>
 <a106023efa9fd648f46021cd063437df798528de.1424092804.git.baruch@tkos.co.il>
Message-ID: <20150318210730.GA12960@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 16, 2015 at 03:20:04PM +0200, Baruch Siach wrote:
> This commit adds a driver for the I2C master controller on the CX92755 SoC. The
> CX92755 is one SoC in the Conexant Digicolor series. This driver should support
> other SoCs from that series.
> 
> Only 7bit slave addresses are currently supported.
> 
> Tested on the Equinox CX92755 EVK, using i2c-tools utilities to read and write
> the on-chip (sic) audio codec.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Looks mostly good.

> +static u32 dc_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}

You probably want to advertise I2C_FUNC_NOSTART here, too?

And if you could rebase to something after 4.0-rc1, that would be much
appreciated.

Thanks,

   Wolfram
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/c07b258b/attachment.sig>

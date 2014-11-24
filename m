From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 24 Nov 2014 18:27:54 +0100
Subject: [PATCH v2] Add support for SCCB devices into PXA27x I2C controller
In-Reply-To: <54725DE2.9090800@tul.cz>
References: <54711397.9060601@tul.cz> <20141123083112.GA1932@katana>
 <54725DE2.9090800@tul.cz>
Message-ID: <20141124172753.GA25434@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 23, 2014 at 11:21:22PM +0100, Petr Cvek wrote:

> I created this patch by fixing both I2C controller and SCCB device, so
> it seems I incorrectly used I2C_M_NOSTART instead I2C_M_STOP. Problem
> with I2C_M_STOP is that it causes bus freeze when using userspace
> utility "i2cget" on SCCB device (unfreeze can be done with i2c-pxa
> module reload). But this can be probably repaired in i2cget.

Please CC Jean Delvare, he maintains the I2C tools.

> Patched kernel was from vanilla 3.18.0-rc5 commit fc14f9c1272f62c3e8d01300f52467c0d9af50f9

Thanks but all these paragraphs describing the updates should have gone
below the "---" line. Your original commit message was more apropriate
and should have stayed.

>  static u32 i2c_pxa_functionality(struct i2c_adapter *adap)
>  {
> -	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
> +		I2C_FUNC_PROTOCOL_MANGLING | I2C_FUNC_NOSTART;

Okay, so NOSTART was previously implemented but not advertised? Please
update the commit log to say that this will be also fixed by your patch.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/21258621/attachment.sig>

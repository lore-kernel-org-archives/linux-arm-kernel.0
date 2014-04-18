From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Apr 2014 19:44:37 +0100
Subject: [PATCH 1/5] ASoC: alc5623: Add device tree binding
In-Reply-To: <20140418181735.GB32580@lunn.ch>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
 <1397749994-24983-2-git-send-email-andrew@lunn.ch>
 <20140418163351.GI12304@sirena.org.uk>
 <20140418181735.GB32580@lunn.ch>
Message-ID: <20140418184437.GZ12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 08:17:35PM +0200, Andrew Lunn wrote:

> The driver already has:

> static const struct i2c_device_id alc5623_i2c_table[] = {
>         {"alc5621", 0x21},
>         {"alc5622", 0x22},
>         {"alc5623", 0x23},
>         {}
> };
> MODULE_DEVICE_TABLE(i2c, alc5623_i2c_table);

> which is enough for the i2c layer to load the driver when it walks the
> nodes under the i2c bus driver in the DT.

You still need to add the compatible strings to the driver explicitly,
device names can be and are duplicated between manufacturers sometimes
and it makes things directly greppable.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140418/1d18de28/attachment.sig>

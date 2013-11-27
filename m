From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 27 Nov 2013 15:30:19 +0000
Subject: [PATCH 1/3] mfd: tps6586x: add version detection
In-Reply-To: <c26ecd550e9940ead950f3874d27a5b0@agner.ch>
References: <cover.1385508112.git.stefan@agner.ch>
 <ef881d39f78b75b4badeebb5be0264edc3906d86.1385508112.git.stefan@agner.ch>
 <20131127130954.GF3296@lee--X1>
 <cd69295e946b48451f449eacc02efa4a@agner.ch>
 <20131127135547.GK3296@lee--X1>
 <cfb203a896eda67c106794d89e668d56@agner.ch>
 <20131127143429.GN3296@lee--X1> <20131127143641.GO3296@lee--X1>
 <c26ecd550e9940ead950f3874d27a5b0@agner.ch>
Message-ID: <20131127153019.GR3296@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Nov 2013, Stefan Agner wrote:

> Am 2013-11-27 15:36, schrieb Lee Jones:
> <snip>
> >> Perhaps I should suggest to make TPS6586X_ANY a positive number then,
> >> as a negative value to me indicates more of an error than a generic
> >> parameter.
> I see, its especially confusing since the version is filled using the
> i2c_smbus_read_byte_data functions return value. The version field is a
> 8-Bit value according to the data sheet, I could use 0x100 as
> TPS6586X_ANY identifier.

How far are we away from using 0xFF?

I'd be happy to use that and change it _if_ we ever get close.

If it's likely that it'll be used, then sure 0x100 sounds okay too.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

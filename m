From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 28 Oct 2015 10:38:05 +0100
Subject: [PATCH v4 4/4] iio: humidity: si7020: added No Hold read mode
In-Reply-To: <1446015506-21371-1-git-send-email-nicola@corna.info>
References: <f113de76b2369d404909cfc5158feca4@rainloop.corna.info>
 <1446015506-21371-1-git-send-email-nicola@corna.info>
Message-ID: <5630977D.2020102@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2015 07:58 AM, Nicola Corna wrote:
[...]
> +			holdmode = !((*client)->adapter->quirks &&
> +					(*client)->adapter->quirks->flags &
[...]
> +		   client->adapter->quirks &&
> +		   client->adapter->quirks->flags & I2C_AQ_NO_CLK_STRETCH)

This is rather ugly, can we get a helper in the I2C core something along the
lines of

i2c_check_quirks(client->adapter, I2C_AQ_NO_CLK_STRETCH)

- Lars

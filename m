From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 12:13:24 +0100
Subject: [PATCH 07/20] regmap: Without bus read() or write(), force
 use_single_rw
In-Reply-To: <1439374365-20623-8-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-8-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812111324.GW10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:32PM +0200, Markus Pargmann wrote:
> The implementation of regmap bus read() and write() methods are
> optional. Therefore we have to handle busses which do not have these
> functions. If raw read() and write() is not supported we have to use
> reg_read and reg_write always.
> 
> This patch sets use_single_rw if read() or write() is not set.

> -	map->use_single_rw = config->use_single_rw;
> +	map->use_single_rw = config->use_single_rw || !bus->read || !bus->write;

This doesn't follow, we should be able to support write only or read
only buses.  There are some out there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/cf8e2b54/attachment-0001.sig>

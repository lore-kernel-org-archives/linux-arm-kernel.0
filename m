From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 1 Jun 2017 10:37:49 +0200
Subject: [PATCH v3 5/9] mtd: nand: tmio_nand.c: take in account partition
 parser types
In-Reply-To: <1496270458-6479-6-git-send-email-andrea.adami@gmail.com>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
 <1496270458-6479-6-git-send-email-andrea.adami@gmail.com>
Message-ID: <20170601083749.GC1477@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -	retval = mtd_device_parse_register(mtd, NULL, NULL,
> +	retval = mtd_device_parse_register(mtd,
> +					   data->types ? data->types : NULL,

This is superfluous. You want to check against 'data' instead as it is
done below. Otherwis you might get a NULL pointer dereference.

> +					   NULL,
>  					   data ? data->partition : NULL,
>  					   data ? data->num_partitions : 0);

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170601/b87a7b74/attachment.sig>

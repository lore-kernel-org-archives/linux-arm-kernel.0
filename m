From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 1 Jun 2017 10:35:19 +0200
Subject: [PATCH v3 4/9] mtd: nand: sharpsl.c: take in account partition
 parser types
In-Reply-To: <1496270458-6479-5-git-send-email-andrea.adami@gmail.com>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
 <1496270458-6479-5-git-send-email-andrea.adami@gmail.com>
Message-ID: <20170601083519.GB1477@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +					data->types ? data->types : NULL,

This is equal to just 'data_types'.

> +					NULL,
> +					data->partitions ?
> +					data->partitions : NULL,
> +					data->nr_partitions ?
> +					data->nr_partitions : 0);

All the ternary operators are superfluous.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170601/96867942/attachment.sig>

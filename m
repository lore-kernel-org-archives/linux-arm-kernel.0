From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 4 Dec 2014 19:34:07 +0100
Subject: [PATCH v2 3/3] i2c: cadence: Check for errata condition
 involving master receive
In-Reply-To: <1417610126-7957-4-git-send-email-harinik@xilinx.com>
References: <1417610126-7957-1-git-send-email-harinik@xilinx.com>
 <1417610126-7957-4-git-send-email-harinik@xilinx.com>
Message-ID: <20141204183406.GK7944@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +		/*
> +		 * This controller does not give completion interrupt after a
> +		 * master receive transfer if HOLD bit is set (repeated start),
> +		 * resulting in SW timeout. Hence, if a receive transfer is
> +		 * followed by any other transfer, an error is returned
> +		 * indicating that this sequence is not supported.
> +		 */
> +		for (count = 0; count < num-1; count++) {
> +			if (msgs[count].flags & I2C_M_RD)
> +				return -EOPNOTSUPP;
> +		}

Yeah, a lot better. Probably it would be good to inform the user with a
warning what went wrong?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/0accd3da/attachment.sig>

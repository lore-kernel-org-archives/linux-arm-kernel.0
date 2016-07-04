From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 4 Jul 2016 09:31:19 +0900
Subject: [PATCH] i2c: bcm2835: Set up the clock stretching timeout at boot.
In-Reply-To: <1464818845-5348-1-git-send-email-eric@anholt.net>
References: <1464818845-5348-1-git-send-email-eric@anholt.net>
Message-ID: <20160704003118.GA1381@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	/*
> +	 * SMBUS says "Devices participating in a transfer will
> +	 * timeout when any clock low exceeds the value of
> +	 * T_TIMEOUT,MIN of 25 ms."
> +	 */

SMBus has that timeout, but I2C doesn't. How about disabling the timeout
simply? Or using the max value if you want to keep the timeout
detection?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160704/92d7d6c0/attachment.sig>

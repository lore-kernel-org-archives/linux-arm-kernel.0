From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 00:09:03 +0000
Subject: [PATCH 11/18] spi/xilinx: Remove rx_fn and tx_fn pointer
In-Reply-To: <1422029330-10971-12-git-send-email-ricardo.ribalda@gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422029330-10971-12-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <20150127000903.GM21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 05:08:43PM +0100, Ricardo Ribalda Delgado wrote:

> +	switch (xspi->bits_per_word) {
> +	case 8:
> +		*(u8 *)(xspi->rx_ptr) = data;
> +		break;
> +	case 16:
> +		*(u16 *)(xspi->rx_ptr) = data;
> +		break;
> +	case 32:
>  		*(u32 *)(xspi->rx_ptr) = data;
> -		xspi->rx_ptr += 4;
> +		break;
>  	}

Perhaps I'm missing something here but we only seem to be incrementing
rx_ptr for the 32 bit case here...

> +	xspi->rx_ptr += xspi->bits_per_word/8;

...which looks to duplicate this which handles all cases.  Also there's
a coding style thing - spaces around the / please.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/22453ffc/attachment.sig>

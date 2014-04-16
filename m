From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Wed, 16 Apr 2014 19:35:32 +0100
Subject: [PATCH v4 12/21] serial: support for 16550A serial ports on
 LP-8x4x
In-Reply-To: <1397668667-27328-6-git-send-email-ynvich@gmail.com>
References: <1397668411-27162-7-git-send-email-ynvich@gmail.com>
 <1397668667-27328-1-git-send-email-ynvich@gmail.com>
 <1397668667-27328-6-git-send-email-ynvich@gmail.com>
Message-ID: <20140416193532.0782f045@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	baud = uart_get_baud_rate(port, termios, old,
> +				  port->uartclk / 16 / 0xffff,
> +				  port->uartclk / 16);
> +	switch (baud) {
> +	case 2400:
> +		len |= 1;
> +		break;
> +	case 4800:
> +		len |= 2;
> +		break;
> +	case 19200:
> +		len |= 4;
> +		break;
> +	case 38400:
> +		len |= 5;
> +		break;
> +	case 57600:
> +		len |= 6;
> +		break;
> +	case 115200:
> +		len |= 7;
> +		break;
> +	case 9600:
> +	default:
> +		len |= 3;
> +		break;
> +	};

Some explanation of this would be useful - eg why is it set to 7 for
115200 baud and 3 for 115201 baud ?

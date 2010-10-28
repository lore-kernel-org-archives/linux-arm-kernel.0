From: chris@alcor.co.uk (Chris Down)
Date: Thu, 28 Oct 2010 16:10:17 +0100
Subject: [PATCH] Documentation about RS485 serial communications
In-Reply-To: <4CC418A9.6090602@evidence.eu.com>
References: <20100408111310.524f7354@lxorguk.ukuu.org.uk>	<4CBD8EE4.5040808@evidence.eu.com>	<i9ka0s$4ua$1@dough.gmane.org>	<201010191727.53314.alexander.stein@systec-electronic.com>	<i9kk4o$svc$1@dough.gmane.org>
	<4CC418A9.6090602@evidence.eu.com>
Message-ID: <4CC99259.6080300@alcor.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a minor issue.

On 24/10/2010 12:29, Claudio Scordino wrote:
> +4. USAGE FROM USER-LEVEL
> +
> +   From user-level, RS485 configuration can be get/set using the previous
> +   ioctls. For instance, to set RS485 you can use the following code:
> +
> +	#include <linux/serial.h>
> +
> +	/* Driver-specific ioctls: */
> +	#define TIOCGRS485      0x542E
> +	#define TIOCSRS485      0x542F
> +
> +	/* Open your specific device (e.g., /dev/mydevice): */
> +	int fd = open ("/dev/mydevice", O_RDWR);
> +	if (fd < 0) {
> +		/* Error handling. See errno. */
> +	}
> +
> +	struct serial_rs485 rs485conf;
> +
> +	/* Set RS485 mode: */
> +	rs485conf.flags |= SER_RS485_ENABLED;
> +
> +	/* Set rts delay before send, if needed: */
This comment is misleading as the delay must be set regardless.
If it is not used it should be set to 0.

> +	rs485conf.flags |= SER_RS485_RTS_BEFORE_SEND;
> +	rs485conf.delay_rts_before_send = ...;
> +
> +	/* Set rts delay after send, if needed: */
The same applies here.

> +	rs485conf.flags |= SER_RS485_RTS_AFTER_SEND;
> +	rs485conf.delay_rts_after_send = ...;

Chris

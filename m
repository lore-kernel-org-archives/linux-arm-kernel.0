From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Oct 2014 17:48:14 +0100
Subject: [PATCH RESEND] tty: serial: 8250_mtk: Fix quot calculation
In-Reply-To: <1414773395-9916-1-git-send-email-matthias.brugger@bq.com>
References: <1414773395-9916-1-git-send-email-matthias.brugger@bq.com>
Message-ID: <9001280.dDNTE2ykLV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 October 2014 17:36:35 Matthias Brugger wrote:
> -               quot = DIV_ROUND_CLOSEST(port->uartclk, 256 * baud);
> +               quot = (port->uartclk / (256 * baud)) + 1;

Should this be DIV_ROUND_UP then?

	Arnd

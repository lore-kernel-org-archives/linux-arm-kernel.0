From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Jun 2010 15:17:28 +0100
Subject: [PATCH 4/6] U6715 platform serial driver It's a generic driver
	for all U6 platform (V2)
In-Reply-To: <1274948852-9179-5-git-send-email-philippe.langlais@stericsson.com>
References: <1274948852-9179-1-git-send-email-philippe.langlais@stericsson.com>
	<1274948852-9179-5-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <20100624141728.GC6523@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 10:27:30AM +0200, Philippe Langlais wrote:
> +struct u6_uart {
> +	struct clk *uartClk;
> +	struct clk *pClk_13M;
> +	struct clk *pClk_26M;
> +	struct clk *pClk_pclk;
> +	char   uart_name[7];
> +};

Passing struct clk's through platform data into drivers... what's the
point of the clk API again?

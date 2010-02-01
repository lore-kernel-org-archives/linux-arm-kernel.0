From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 2 Feb 2010 04:42:00 +0800
Subject: [PATCH - v5] support for Embedian MXM-8x10
In-Reply-To: <201001221010.45174.epeer@tmtservices.co.za>
References: <201001221010.45174.epeer@tmtservices.co.za>
Message-ID: <f17812d71002011242i53f4c2faoe47b3d6988cefaa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static struct spi_board_info mcp251x_board_info[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .modalias ? ? ? ?= "mcp251x",
> + ? ? ? ? ? ? ? .max_speed_hz ? ?= 65E5,

This looks weird to me, should be an integer here right?

> + ? ? ? ? ? ? ? .bus_num ? ? ? ? = 3,
> + ? ? ? ? ? ? ? .chip_select ? ? = 0,
> + ? ? ? ? ? ? ? .platform_data ? = &mcp251x_info,
> + ? ? ? ? ? ? ? .controller_data = &mcp251x_chip_info1,
> + ? ? ? ? ? ? ? .irq ? ? ? ? ? ? = gpio_to_irq(ICONTROL_MCP251x_nIRQ1)
> + ? ? ? },

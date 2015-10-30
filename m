From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Oct 2015 09:28:55 +0100
Subject: [PATCH v4 2/6] clk: sunxi: Add H3 clocks support
In-Reply-To: <1445964626-6484-3-git-send-email-jenskuske@gmail.com>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
 <1445964626-6484-3-git-send-email-jenskuske@gmail.com>
Message-ID: <3751073.AWmm18dvKK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 October 2015 17:50:22 Jens Kuske wrote:
> +               of_property_read_string_index(node, "clock-output-names",
> +                                             i, &clk_name);
> +
> +               if (index == 17 || (index >= 29 && index <= 31))
> +                       clk_parent = AHB2;
> +               else if (index <= 63 || index >= 128)
> +                       clk_parent = AHB1;
> +               else if (index >= 64 && index <= 95)
> +                       clk_parent = APB1;
> +               else if (index >= 96 && index <= 127)
> +                       clk_parent = APB2;
> +
> +               clk_reg = reg + 4 * (index / 32);
> 

Same as for the reset driver, this probably means you should have one
cell to indicate which bus it is for, and another cell for the
index.

	Arnd

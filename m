From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 11 Sep 2015 14:49:07 -0700
Subject: [PATCH 1/3] doc: dt: add documentation for Mediatek spi-nor
 controller
In-Reply-To: <1441705796-11365-2-git-send-email-bayi.cheng@mediatek.com>
References: <1441705796-11365-1-git-send-email-bayi.cheng@mediatek.com>
 <1441705796-11365-2-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <20150911214907.GE11487@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more thing:

On Tue, Sep 08, 2015 at 05:49:54PM +0800, Bayi Cheng wrote:
> +- clocks: spi nor source clock

^^ you only list one clock here

> +- clock-names: "spi_clk", "axi_clk", "mux_clk", "sf_clk"

But you have 4 names here.

...
> +	clocks = <&pericfg CLK_PERI_SPI>,
> +		 <&topckgen CLK_TOP_AXI_SEL>,
> +		 <&topckgen CLK_TOP_UNIVPLL2_D8>,
> +		 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;

And you provide 4 clocks.

> +	clock-names = "spi_clk", "axi_clk", "mux_clk", "sf_clk";

Please list all 4 under the "clocks" property, not just under the
"clock-names" property.

Brian

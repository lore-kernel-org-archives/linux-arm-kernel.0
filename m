From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 21 Jun 2018 17:01:11 -0300
Subject: [PATCH] ARM: dts: imx51: add CodaHx4 VPU
In-Reply-To: <1529610890.4022.7.camel@pengutronix.de>
References: <20171213142406.5088-1-p.zabel@pengutronix.de>
 <20171226041517.GD4210@X250>
 <1529610890.4022.7.camel@pengutronix.de>
Message-ID: <CAOMZO5Ahv2F-WeAPFgsBcpAeb2i==SAZ45QBLvnod7jYRG0fMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Thu, Jun 21, 2018 at 4:54 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> I forgot about this between the years, this patch is safe to be applied.

In order to get the internal RAM to be functional, I think we also
need to pass the IRAM clock in the iram node:

  iram: iram at 1ffe0000 {
      compatible = "mmio-sram";
      reg = <0x1ffe0000 0x20000>;
  +  clocks = <&clks IMX5_CLK_OCRAM>;
  };

Thanks

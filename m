From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Nov 2018 20:37:14 +0100
Subject: [PATCH 04/16] arm: dts: Add devicetree for RDA8810PL SoC
In-Reply-To: <20181119170939.19153-5-manivannan.sadhasivam@linaro.org>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-5-manivannan.sadhasivam@linaro.org>
Message-ID: <CAK8P3a1ZOTrUFKvBCdMX-1Fj5Pnk__+GJdee7pOieb2oiWkpuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 6:11 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add initial device tree for RDA8810PL SoC from RDA Microelectronics.

> +       aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +       };

Better move the aliases into the board file, there might be boards
that only expose one or two of them on physical connectors,
or that count them in a different order from the SoC.

      Arnd

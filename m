From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Nov 2018 09:55:18 +0100
Subject: [PATCH v2 06/15] arm: dts: Add devicetree for OrangePi 2G IoT
 board
In-Reply-To: <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
 <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
Message-ID: <CAK8P3a0OqD=mxJmc2hPTp2s1-i1MPZWsjDF37hjSDKrFpzGxWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 4:38 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> +       aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +       };
>
+
> +&uart2 {
> +       status = "okay";
> +       clocks = <&uart2_clk>;
> +};

This is clearly mismatched here: you mark only one uart as 'enabled, but
list three of them as aliases. Having 'serial0' point to a disabled uart
may easily break applications that expect the first one to be the
console.

Best make that

       serial0 = &uart2;

and drop the other ones if only one of them is exposed on the
board. If all three are usable, you should enable them all here,
and make sure that the numbering of the aliases matches the
labels on the board or its documentation.

        Arnd

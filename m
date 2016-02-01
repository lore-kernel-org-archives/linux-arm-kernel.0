From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Feb 2016 09:03:44 -0600
Subject: [PATCH 03/14] clk: sunxi: add bus gates for A83T
In-Reply-To: <1454203266-4450-4-git-send-email-vishnupatekar0510@gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-4-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20160201150344.GA4947@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 31, 2016 at 09:20:55AM +0800, Vishnu Patekar wrote:
> A83T has similar bus gates that of H3, including single gating register has
> different clock parent.
> 
> As per H3 and A83T datasheet, usbhost is under AHB2.
> 
> However,below shows allwinner source code assignment:
> bits: 26 (ehci0), 27 (ehci1), 29 (ohci0) => AHB1 for A83T.
> bits: 26 (ehci0), 27 (ehci1) => AHB1 for H3
> bits  29, 30, 31(ohci0,1,2) => AHB2 for H3.
> 
> until, this confusion is cleared keep it H3 way.
> 
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt | 1 +
>  drivers/clk/sunxi/clk-sun8i-bus-gates.c           | 2 ++
>  2 files changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

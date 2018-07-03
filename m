From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jul 2018 17:10:40 -0600
Subject: [PATCH v2] dt-bindings: serial: imx: clarify rs485 support usage
In-Reply-To: <e9beff38e9035c2f33d691f362e37d8e62aaa660.1530170732.git.baruch@tkos.co.il>
References: <e9beff38e9035c2f33d691f362e37d8e62aaa660.1530170732.git.baruch@tkos.co.il>
Message-ID: <20180703231040.GA5749@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 10:25:32AM +0300, Baruch Siach wrote:
> The i.MX UART peripheral uses the RST_B signal as input, and CTS_B as

s/RST_B/RTS_B/

> output. This is just like the DCE role in RS-232. This is true
> regardless of the "DTE mode" setting of this peripheral.
> 
> As a result, rs485 support hardware must use the CTS_B signal to control
> the RS-485 transceiver. This is in contrast to generic rs485 kernel
> code, documentation, and DT property names that consistently refer to
> the RTS as transceiver control signal.
> 
> Add a note in the DT binding document about that, to reduce the
> confusion somewhat.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2: Fix commit log typos (Lothar Wa?mann)
> ---
>  Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

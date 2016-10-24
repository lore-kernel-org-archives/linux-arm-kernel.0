From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 24 Oct 2016 20:06:21 +0800
Subject: [PATCH] ARM: dts: vf610: fix IRQ flag of global timer
In-Reply-To: <20161018015127.16981-1-stefan@agner.ch>
References: <20161018015127.16981-1-stefan@agner.ch>
Message-ID: <20161024120621.GI30578@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 06:51:27PM -0700, Stefan Agner wrote:
> The global timer IRQ (PPI[0], PPI 11 in device tree terms) is a
> rising edge interrupt. The ARM Cortex-A5 MPCore TRM in Chapter
> 10.1.2. Interrupt types and sources says:
> "Interrupt is rising-edge sensitive."
> 
> The bits seem to be read-only, hence this missconfiguration had
> no negative effect. However, with commit 992345a58e0c
> ("irqchip/gic: WARN if setting the interrupt type for a PPI fails")
> warnings such as this get printed:
> GIC: PPI11 is secure or misconfigured
> 
> With this change the new configuration matches the default
> configuration and no warning is printed anymore.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.

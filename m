From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 16 Dec 2013 09:54:05 +0900
Subject: [PATCH] pci: designware: fix missing msi irqs
In-Reply-To: <20131212182903.409515738@gmail.com>
References: <20131212182903.409515738@gmail.com>
Message-ID: <005b01cef9f9$52022bd0$f6068370$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 13, 2013 3:29 AM, Harro Haan wrote:
> 
> The interrupts were cleared after the irq handler was called.
> This means that new interrupts that occur after the handler handled
> the previous irq but before the interrupt is cleared will be missed.
> 
> Signed-off-by: Harro Haan <hrhaan@gmail.com>
> Cc: Mohit Kumar <mohit.kumar@st.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Richard Zhu <hong-xing.zhu@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Juergen Beisert <jbe@pengutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
> Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
> Cc: Sean Cross <xobs@kosagi.com>
> Cc: linux-pci at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org

Acked-by: Jingoo Han <jg1.han@samsung.com>

I was not able to reproduce the problem, however it looks
good. Also, there is no side effect on Exynos platform.

Mohit,
If you have some comments, please let us know.

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pcie-designware.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

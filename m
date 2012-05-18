From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 May 2012 08:49:01 +0100
Subject: [PATCH v2 3/6] mmc: dw_mmc: lookup for optional biu and ciu clocks
In-Reply-To: <1337267411-28226-4-git-send-email-thomas.abraham@linaro.org>
References: <1337267411-28226-1-git-send-email-thomas.abraham@linaro.org>
 <1337267411-28226-4-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120518074901.GA843@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 08:40:08PM +0530, Thomas Abraham wrote:
> +err_clk:
> +	if (!IS_ERR(host->ciu_clk))
> +		clk_disable_unprepare(host->ciu_clk);
> +	if (!IS_ERR(host->biu_clk))
> +		clk_disable_unprepare(host->biu_clk);
> +	clk_put(host->ciu_clk);
> +	clk_put(host->biu_clk);

+	if (!IS_ERR(host->ciu_clk)) {
+		clk_disable_unprepare(host->ciu_clk);
+		clk_put(host->ciu_clk);
+	}
+	if (!IS_ERR(host->biu_clk)) {
+		clk_disable_unprepare(host->biu_clk);
+		clk_put(host->biu_clk);
+	}

And the same in the other occurrence.

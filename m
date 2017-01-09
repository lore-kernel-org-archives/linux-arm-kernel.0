From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 9 Jan 2017 16:42:56 +0800
Subject: [PATCH v1 3/3] thermal: zx2967: add thermal driver for ZTE's
 zx2967 family
In-Reply-To: <843c634a-c624-e7db-99f6-8efdc19d7243@linaro.org>
References: <1483767488-19778-1-git-send-email-baoyou.xie@linaro.org>
 <1483767488-19778-3-git-send-email-baoyou.xie@linaro.org>
 <843c634a-c624-e7db-99f6-8efdc19d7243@linaro.org>
Message-ID: <20170109084254.GL20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 11:00:38AM +0800, Jun Nie wrote:
> >+static int zx2967_thermal_resume(struct device *dev)
> >+{
> >+	struct platform_device *pdev = to_platform_device(dev);
> >+	struct zx2967_thermal_priv *priv = platform_get_drvdata(pdev);
> >+	int error;
> >+
> >+	error = clk_prepare_enable(priv->clk_gate);
> >+	if (error)
> Use IS_ERR(ret) to check error.

No.  IS_ERR() checks on pointer, while clk_prepare_enable() returns
integer.

Shawn

> >+		return error;
> >+
> >+	error = clk_prepare_enable(priv->pclk);
> >+	if (error)
> Ditto.
> >+		return error;
> >+
> >+	dev_info(dev, "resumed\n");
> >+
> >+	return 0;
> >+}

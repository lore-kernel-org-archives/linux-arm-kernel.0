From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 16 Sep 2013 17:01:48 +0800
Subject: [PATCH v4 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
In-Reply-To: <5236AB28.5060708@kosagi.com>
References: <1379065222-7275-1-git-send-email-xobs@kosagi.com>
 <1379065222-7275-4-git-send-email-xobs@kosagi.com>
 <20130916060631.GF31147@S2101-09.ap.freescale.net>
 <5236AB28.5060708@kosagi.com>
Message-ID: <20130916090146.GL31147@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 02:54:32PM +0800, Sean Cross wrote:
> >>@@ -116,6 +116,22 @@
> >>  			arm,data-latency = <4 2 3>;
> >>  		};
> >>+		pcie: pcie at 0x01000000 {
> >>+			compatible = "fsl,imx6-pcie", "snps,dw-pcie";
> >We generally use particular SoC name to specify the compatible string.
> >So "fsl,imx6q-pcie" will be more appropriate.
> Any reason to specify imx6q in particular?  It's also present on the
> imx6d, imx6dl, and imx6s (basically, everything but the imx6sl).

The compatible naming is not about coverage but versioning.  We
generally encode the name of the SoC that firstly integrates the block
to specify the version.

Shawn

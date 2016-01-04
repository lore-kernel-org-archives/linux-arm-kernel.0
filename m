From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Jan 2016 15:35:02 +0000
Subject: next-20160104 build: 3 failures 15 warnings (next-20160104)
In-Reply-To: <E1aG3zo-0000gt-2t@optimist>
References: <E1aG3zo-0000gt-2t@optimist>
Message-ID: <20160104153502.GK16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 12:12:20PM +0000, Build bot for Mark Brown wrote:

Today's linux-next fails to build for arm64 due to 44d3d051253 (ARM64:
dts: mt8173: Add CPU OPP, clock and regulator supply properties) in one
of Raphael's trees:

> 	arm64-allmodconfig
> Error: ../arch/arm64/boot/dts/mediatek/mt8173.dtsi:132.24-25 syntax error
> Error: ../arch/arm64/boot/dts/mediatek/mt8173.dtsi:132.24-25 syntax error

> 	arm64-defconfig
> Error: ../arch/arm64/boot/dts/mediatek/mt8173.dtsi:132.24-25 syntax error

which is failing because at least CLK_INFRA_CA53SEL is used but never
defined, presumably there is some dependency which wasn't integrated.
Normally we merge DT changes via the architecture to help avoid these
issues.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/6ae7e456/attachment-0001.sig>

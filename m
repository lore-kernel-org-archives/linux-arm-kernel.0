From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Dec 2015 12:22:28 +0000
Subject: next-20151222 build: 3 failures 13 warnings (next-20151222)
In-Reply-To: <E1aBIky-0007nI-7t@optimist>
References: <E1aBIky-0007nI-7t@optimist>
Message-ID: <20151222122228.GL5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 08:57:20AM +0000, Build bot for Mark Brown wrote:

Today's linux-next fails to link an arm64 allmodconfig due to:

> ERROR: "of_irq_count" [drivers/pinctrl/qcom/pinctrl-ssbi-mpp.ko] undefined!
> ERROR: "of_irq_count" [drivers/pinctrl/qcom/pinctrl-ssbi-gpio.ko] undefined!
> ERROR: "of_irq_count" [drivers/pinctrl/qcom/pinctrl-spmi-mpp.ko] undefined!
> ERROR: "of_irq_count" [drivers/pinctrl/qcom/pinctrl-spmi-gpio.ko] undefined!

which are caused by ab4256cfeab91569 (pinctrl: qcom: pmic-gpio/mpp:
of_irq_count() == npins) which adds uses of irq_of_count() but that is
not exported so can't be used in modules.  I've just sent a patch adding
the export.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151222/f30bc86f/attachment.sig>

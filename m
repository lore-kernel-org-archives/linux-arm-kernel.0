From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Aug 2012 11:26:52 +0000
Subject: [PATCH 0/5] usb: phy: samsung: Introducing usb phy driver for
 samsung SoCs
In-Reply-To: <CAD6zSYN-prJO=dp8tJT8+4qcC3TxCXyVTU6-Xf5p20650Zb-ow@mail.gmail.com>
References: <1343826351-8756-1-git-send-email-p.paneri@samsung.com>
 <201208011520.02353.arnd@arndb.de>
 <CAD6zSYN-prJO=dp8tJT8+4qcC3TxCXyVTU6-Xf5p20650Zb-ow@mail.gmail.com>
Message-ID: <201208021126.52307.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 August 2012, Praveen Paneri wrote:
> Yes! I understand this problem and this is the reason these patches
> were sitting in my system for couple of weeks. In a  discussion with
> Thomas an idea of using the existing regulator framework to
> enable/disable numerous PHYs came up. For example the PMU unit
> of Exynos4210 has a register set dedicated just to control USBD_PHY,
> HDMI_PHY, MIPI_PHY, DAC_PHY and more. If a regulator with
> each phy control register as LDO is written, the phy driver becomes a
> static consumer and will modify as below.

This is roughly what I had in mind, yes. The part I'm not sure about
is the subsystem to use. One could obviously express the same logic
using the clock or gpio framework, which would work but be conceptually
wrong.

Some other parts of the PMU functionality are provided through
pm-domains rather than regulators and I guess in theory it could
all be controlled through pm-domains. Maybe someone else has a better
understanding than me what the tradeoffs are here and which subsystem
should be used for the PMU.

	Arnd

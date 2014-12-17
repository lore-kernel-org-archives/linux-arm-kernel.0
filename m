From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Dec 2014 23:16:12 +0100
Subject: [PATCH 4/5] PCI: designware: Add setup bus-related to
 pcie_host_ops
In-Reply-To: <1418812486-12394-5-git-send-email-gabriel.fernandez@linaro.org>
References: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
 <1418812486-12394-5-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1507589.aeTeyNn1QF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 December 2014 11:34:45 Gabriel FERNANDEZ wrote:
> ST sti SoCs PCIe IPs are built around DesignWare IP Core.
> But in these SoCs PCIe IP doesn't support IO.
> 
> To support this, add setup_bus() to pcie_host_ops.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>

The dw-pcie driver should be able to tell whether the device has
an I/O space or not, and do the right thing based on that. Don't
add an implementation specific callback for that.

	Arnd

From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 5 May 2015 17:16:46 -0500
Subject: [PATCH v3 3/5] PCI: st: Provide support for the sti PCIe
 controller
In-Reply-To: <1428657168-12495-4-git-send-email-gabriel.fernandez@linaro.org>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
 <1428657168-12495-4-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20150505221646.GE24643@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 11:12:46AM +0200, Gabriel FERNANDEZ wrote:
> sti pcie is built around a Synopsis Designware PCIe IP.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>

> +/* ST PCIe driver does not allow module unload */

Is there something that prevents module unload, or is it just untested?

> +static int __init pcie_init(void)
> +{
> +	return platform_driver_probe(&st_pcie_driver, st_pcie_probe);
> +}
> +device_initcall(pcie_init);

Can you use module_platform_driver_probe() or module_init() here?

> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
> +MODULE_DESCRIPTION("PCI express Driver for ST SoCs");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.9.1
> 

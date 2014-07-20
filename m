From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Jul 2014 12:26:49 -0700
Subject: [PATCH 1/2] PCI: spear: Fix Section mismatch compilation warning
 for probe()
In-Reply-To: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
References: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
Message-ID: <20140720192649.GA30124@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 20, 2014 at 05:29:47PM +0530, Viresh Kumar wrote:
> Following compilation warning occurs when compiled with:
> CONFIG_DEBUG_SECTION_MISMATCH=y
> 
>  WARNING: drivers/pci/host/built-in.o(.data+0xc0): Section mismatch in
>  reference from the variable spear13xx_pcie_driver to the function
>  .init.text:spear13xx_pcie_probe()
> 
> Both .probe() and pcie_init() are marked with __init, but spear13xx_pcie_driver
> isn't. And so section mismatch.
> 
> Fix it by marking spear13xx_pcie_driver with __initdata.
> 
> Fixes: 51b66a6 (PCI: spear: Add PCIe driver for ST Microelectronics SPEAr13xx)

Please use 12 significant digits, since 7 might not be sufficient later
on in time. I've fixed it up here.

> Reported-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Olof/Arnd,
> 
> Let me know if a PULL request is required for this, otherwise just apply them
> directly.

I've applied both of these on top of next/drivers, where your previous branch
was. No need for a pull request.


-Olof

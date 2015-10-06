From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 23:01:11 +0200
Subject: [PATCH v5 3/3] PCI: st: Provide support for the sti PCIe
 controller
In-Reply-To: <1444118168-13086-4-git-send-email-gabriel.fernandez@linaro.org>
References: <1444118168-13086-1-git-send-email-gabriel.fernandez@linaro.org>
 <1444118168-13086-4-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <5139149.TmJY1YjqAU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 October 2015 09:56:08 Gabriel Fernandez wrote:
> +
> +/*
> + * On ARM platforms, we actually get a bus error returned when the PCIe IP
> + * returns a UR or CRS instead of an OK.
> + */
> +static int st_pcie_abort_handler(unsigned long addr, unsigned int fsr,
> +                                struct pt_regs *regs)
> +{
> +       return 0;
> +}
> 

I'm not sure if we discussed this already for this driver. Usually
you should have a register in the PCI host that you can check to see
what caused the abort.

Try to make this as narrow as possible so you return nonzero for
any abort except the one you actually try to prevent.

	Arnd

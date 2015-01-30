From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 30 Jan 2015 16:15:04 -0600
Subject: [PATCH] ARM: integrator: remove unused variable
In-Reply-To: <1666566.z9ZP4KJ7VA@wuerfel>
References: <1666566.z9ZP4KJ7VA@wuerfel>
Message-ID: <CAErSpo7iqe07HQBpbGfr8=FwK3wF0dkCFvjAJRBvd7HusMjjvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 3:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The patch to add the new generic config space accessors removed
> a useless spinlock, but left the flags variable in place, which
> now causes a build warning:
>
> arch/arm/mach-integrator/pci_v3.c: In function 'pci_v3_preinit':
> arch/arm/mach-integrator/pci_v3.c:614:16: warning: unused variable 'flags' [-Wunused-variable]
>
> This removes it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 1ba525109219 ("ARM: integrator: Convert PCI to use generic config accessors")

Folded in, thanks!

>
> diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
> index dc7782f26cbb..2565f0e7b5cf 100644
> --- a/arch/arm/mach-integrator/pci_v3.c
> +++ b/arch/arm/mach-integrator/pci_v3.c
> @@ -611,7 +611,6 @@ static int __init pci_v3_setup(int nr, struct pci_sys_data *sys)
>   */
>  static void __init pci_v3_preinit(void)
>  {
> -       unsigned long flags;
>         unsigned int temp;
>         phys_addr_t io_address = pci_pio_to_address(io_mem.start);
>
>

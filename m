From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Jan 2013 11:43:40 +0000
Subject: [PATCH RFC 2/2] Improve bios32 support for DT PCI host bridge
 controllers
In-Reply-To: <20130118114019.GA9034@arm.com>
References: <20130118114019.GA9034@arm.com>
Message-ID: <20130118114340.GD23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 11:40:19AM +0000, Andrew Murray wrote:
>  static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
>  {
>  	struct pci_sys_data *sys = NULL;
> +	static int busnr;
>  	int ret;
> -	int nr, busnr;
> -
> -	for (nr = busnr = 0; nr < hw->nr_controllers; nr++) {
> +	int nr;
> +	for (nr = 0; nr < hw->nr_controllers; nr++) {

Please try to retain the originally formatting.  There should be a blank
line between "int nr;" and "for...".

From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Mar 2014 23:30:09 +0100
Subject: [PATCH v5 1/7] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <1393948204-11555-2-git-send-email-Liviu.Dudau@arm.com>
References: <1393948204-11555-1-git-send-email-Liviu.Dudau@arm.com>
 <1393948204-11555-2-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <201403042330.09607.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 March 2014, Liviu Dudau wrote:
> +int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
> +{
> +       return 0;
> +}
> +

How about returning an error here? You don't actually register the range.

	Arnd

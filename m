From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 8 Mar 2014 18:17:39 +0100
Subject: [PATCH v6 2/6] pci: OF: Fix the conversion of IO ranges into IO
 resources.
In-Reply-To: <1394020137-1830-3-git-send-email-Liviu.Dudau@arm.com>
References: <1394020137-1830-1-git-send-email-Liviu.Dudau@arm.com>
 <1394020137-1830-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <201403081817.39810.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 March 2014, Liviu Dudau wrote:
> +               unsigned long port = -1;
> +               if (!pci_register_io_range(range->cpu_addr, range->size))
> +                       port = pci_address_to_pio(range->cpu_addr);

I don't remember the outcome of my suggestion to just return 'port' from
pci_register_io_range(). In my mind that would be much simpler than
adding the range in a data structure just so we can look it up in the very
next line.

	Arnd

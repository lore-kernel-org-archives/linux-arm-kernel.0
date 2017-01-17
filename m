From: jarkko.nikula@linux.intel.com (Jarkko Nikula)
Date: Tue, 17 Jan 2017 13:18:42 +0200
Subject: [PATCH v2 3/3] spi: pca2xx-pci: Allow MSI
In-Reply-To: <1484593718.2133.156.camel@linux.intel.com>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <9f5bc54a5842b383dc81fa8586d6774c03d2c452.1484592296.git.jan.kiszka@siemens.com>
 <1484593718.2133.156.camel@linux.intel.com>
Message-ID: <1a9ed825-2585-8c76-c6ea-866de2e33e50@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2017 09:08 PM, Andy Shevchenko wrote:
> On Mon, 2017-01-16 at 19:44 +0100, Jan Kiszka wrote:
>> Now that the core is ready for edge-triggered interrupts, we can
>> safely
>> allow the PCI versions that provide this to enable the feature and,
>> thus, have less shared interrupts.
>>
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
I was looking at is there need to call pci_free_irq_vectors() but 
pcim_release() takes care of that since this driver uses 
pcim_enable_device().

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

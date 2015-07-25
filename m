From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 26 Jul 2015 01:55:54 +0200
Subject: [PATCH v2 13/25] acpi: switch from ioremap_cache to memremap
In-Reply-To: <20150725023909.8664.13169.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725023909.8664.13169.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <2011199.d8qtUaiDBv@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 24, 2015 10:39:09 PM Dan Williams wrote:
> In preparation for deprecating ioremap_cache() convert its usage in
> drivers/acpi and include/acpi/ to memremap.  This includes dropping the
> __iomem annotation throughout ACPI since the memremap can be treated as
> a normal memory pointer.
> 
> Finally, memremap automatically handles requests to map normal memory
> pages, so this also drops the calls to "should_use_kmap()".
> 
> Cc: Bob Moore <robert.moore@intel.com>
> Cc: Lv Zheng <lv.zheng@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/arm64/include/asm/acpi.h |    5 +--
>  drivers/acpi/apei/einj.c      |    9 +++--
>  drivers/acpi/apei/erst.c      |    6 ++--
>  drivers/acpi/nvs.c            |    6 ++--
>  drivers/acpi/osl.c            |   70 +++++++++++------------------------------
>  include/acpi/acpi_io.h        |    6 ++--
>  6 files changed, 35 insertions(+), 67 deletions(-)

Need to talk to Bob/Lv about the name change in acpi_io.h.

Apart from that I have no objections.

Thanks,
Rafael

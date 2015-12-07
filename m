From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 7 Dec 2015 12:00:01 +0000
Subject: [Xen-devel] [PATCH v3 06/62] acpi: Refactor acpi_os_map_memory
 to be architecturally independent
In-Reply-To: <1447753261-7552-7-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-7-git-send-email-shannon.zhao@linaro.org>
Message-ID: <566574C1.30700@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Current acpi_os_map_memory is specific to x86. Refactor it to be
> architecturally independent.

The function acpi_os_unmap_memory should also be arch-independent.

Otherwise, with the implementation you did on ARM (see patch #7), you
will destroy by mistake the mapping in the page table for those regions.

Regards,

-- 
Julien Grall

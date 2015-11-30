From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 30 Nov 2015 14:47:52 +0000
Subject: [Xen-devel] [PATCH v3 07/62] arm/acpi: Add arch_acpi_os_map_memory
 helper function for ARM
In-Reply-To: <alpine.DEB.2.02.1511231137000.1107@kaball.uk.xensource.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-8-git-send-email-shannon.zhao@linaro.org>
 <alpine.DEB.2.02.1511231137000.1107@kaball.uk.xensource.com>
Message-ID: <565C6198.3070805@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23/11/15 11:37, Stefano Stabellini wrote:
> On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>

> could you please add a couple of lines to the commit message mentioning
> why __va(phys) is an acceptable implementation of arch_acpi_os_map_memory?

FWIW, I already asked this question multiple time on the previous series
without clear answer.

__va should only be used when the memory is direct-mapped to Xen (i.e
accessible directly). On ARM64, this is only the case for the RAM. Can
someone confirm the ACPI will always reside to the RAM?

Regards,

-- 
Julien Grall

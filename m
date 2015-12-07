From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Mon, 7 Dec 2015 16:58:30 +0800
Subject: [Xen-devel] [PATCH v3 07/62] arm/acpi: Add arch_acpi_os_map_memory
 helper function for ARM
In-Reply-To: <565C6198.3070805@citrix.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>	<1447753261-7552-8-git-send-email-shannon.zhao@linaro.org>
 <alpine.DEB.2.02.1511231137000.1107@kaball.uk.xensource.com>
 <565C6198.3070805@citrix.com>
Message-ID: <56654A36.6070708@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2015/11/30 22:47, Julien Grall wrote:
> Hi,
> 
> On 23/11/15 11:37, Stefano Stabellini wrote:
>> > On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
>>> >> From: Shannon Zhao <shannon.zhao@linaro.org>
>> > could you please add a couple of lines to the commit message mentioning
>> > why __va(phys) is an acceptable implementation of arch_acpi_os_map_memory?
> FWIW, I already asked this question multiple time on the previous series
> without clear answer.
> 
> __va should only be used when the memory is direct-mapped to Xen (i.e
> accessible directly). On ARM64, this is only the case for the RAM. Can
> someone confirm the ACPI will always reside to the RAM?
I checked this with the UEFI SPEC. It says in 2.3.6 AArch64 Platforms:
"If ACPI is supported :
? ACPI Tables loaded at boot time can be contained in memory of type
EfiACPIReclaimMemory (recommended) or EfiACPIMemoryNVS."

So I think it means the ACPI tables will always reside in RAM.

Thanks,
-- 
Shannon

From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 26 Apr 2018 11:27:01 +0100
Subject: [PATCH v8 04/13] arm64/acpi: Create arch specific cpu to acpi id
 helper
In-Reply-To: <20180425233121.13270-5-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-5-jeremy.linton@arm.com>
Message-ID: <16324b54-42d4-d9bc-6d57-de52431dc209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/04/18 00:31, Jeremy Linton wrote:
> Its helpful to be able to lookup the acpi_processor_id associated
> with a logical cpu. Provide an arm64 helper to do this.
> 

As I pointed out in the earlier version, this patch is not required.
The acpi_id stored in the acpi_processor can be used for this.
Won't the below change make it work ? I can't think of any reason why it
shouldn't.

Regards,
Sudeep

-->8

diff --git i/drivers/acpi/pptt.c w/drivers/acpi/pptt.c
index 0fc4b2654665..f421f58b4ae6 100644
--- i/drivers/acpi/pptt.c
+++ w/drivers/acpi/pptt.c
@@ -432,7 +432,7 @@ static void cache_setup_acpi_cpu(struct
acpi_table_header *table,
 {
        struct acpi_pptt_cache *found_cache;
        struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-       u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+       u32 acpi_cpu_id = per_cpu(processors, cpu)->acpi_id;
        struct cacheinfo *this_leaf;
        unsigned int index = 0;
        struct acpi_pptt_processor *cpu_node = NULL;

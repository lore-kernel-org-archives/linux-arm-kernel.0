From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 17 Nov 2015 14:25:58 +0000
Subject: [PATCH v3 24/62] arm: Introduce a generic way to use a device
 from acpi
In-Reply-To: <564B29EA.3060107@huawei.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-25-git-send-email-shannon.zhao@linaro.org>
 <564B2023.8010801@citrix.com> <564B29EA.3060107@huawei.com>
Message-ID: <564B38F6.9070101@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/15 13:21, Shannon Zhao wrote:
>> AFAICT, it does only works for SPCR table used for UART device. For the
>> GIC you've hardcoded the value and I can't find any version number in
>> the table.
>>
> No, I didn't hardcode the GIC version. Since ACPI 6.0 introduces GIC
> version in generic distributor table, it could get the version from
> that. Please see [PATCH v3 28/62].

+    if ( dist->version == ACPI_MADT_GIC_VERSION_V2 )
+        rc = acpi_device_init(DEVICE_GIC, NULL, GIC_V2);
+    else if ( dist->version == ACPI_MADT_GIC_VERSION_V3 )
+        rc = acpi_device_init(DEVICE_GIC, NULL, GIC_V3);

Every single time a new GIC version will be added, we will had to add
another else if. I'm sorry but it's what I call hardcoding.

Regards,

-- 
Julien Grall

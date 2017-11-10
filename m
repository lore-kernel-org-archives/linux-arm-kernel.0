From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 10 Nov 2017 09:03:18 -0500
Subject: [PATCH V2 2/3] dmaengine: qcom_hidma: add support for the new
 revision
In-Reply-To: <e781fe6c-a4ad-4a96-c705-dfcd9a8d10b0@arm.com>
References: <1510158582-5343-1-git-send-email-okaya@codeaurora.org>
 <1510158582-5343-2-git-send-email-okaya@codeaurora.org>
 <e781fe6c-a4ad-4a96-c705-dfcd9a8d10b0@arm.com>
Message-ID: <3ca59a37-e8f8-a2cf-fa3a-f4ee6d544dcd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+linux-acpi, +Rafael for context

On 11/8/2017 12:51 PM, Robin Murphy wrote:
> Apologies if I wasn't very clear, but what I meant to imply by dropping the of_device_get_match_data() hint was to follow one of the common patterns where you either just have some version token:
> 
> ????enum foo_ver {
> ??????? FOO_V1,
> ??????? ...
> ????}
> 
> ????struct acpi_device_id foo_acpi_ids[] = {
> ??????? { "_FOO0001", FOO_V1 },
> ??????? ...
> ????}
> 
> ????struct of_device_id foo_of_match[] = {
> ??????? { .compatible = "foo,v1", .data = (void *)FOO_V1 },
> ??????? ...
> ????}
> 
> ????int foo_probe(struct device *dev) {
> ??????? ...
> ??????? foodev->version = (enum foo_ver)
> ??????????????? of_device_get_match_data(&dev->of_node)
> ??????? ...
> ????}
> 
> ????int foo_reset(struct foodev *foodev) {
> ??????? if (foodev->version == FOO_V1)
> ??????????? writel(0, foodev->base + 0x20);
> ??????? else
> ??????????? writel(0, foodev->base + 0x30);
> ????}

I did post v3 with this approach. However, I could not really find a ACPI function that
returns the driver data very similar to of_device_get_match_data(). The only thing
that is closer is acpi_match_device().

I introduced this new function as part of the v3 series. 

Let me know if I'm missing something.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

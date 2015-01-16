From: thomas.lendacky@amd.com (Tom Lendacky)
Date: Fri, 16 Jan 2015 09:16:06 -0600
Subject: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <20150116145545.GR7091@arm.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6v_BvCQqp8d=LaQ8HeaOU1Zh_HPpwFTdwOjHUbqXsnQ8g@mail.gmail.com>
 <20150115182346.GE2329@e104818-lin.cambridge.arm.com>
 <54B8BB24.2020408@linaro.org> <54B9240A.7060003@amd.com>
 <20150116145545.GR7091@arm.com>
Message-ID: <54B92B36.6080700@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 01/16/2015 08:55 AM, Will Deacon wrote:
> Hi Tom,
>
> On Fri, Jan 16, 2015 at 02:45:30PM +0000, Tom Lendacky wrote:
>> I have tested ACPI-enablement patches for the amd-xgbe/amd-xgbe-phy
>> drivers that I'm about to submit upstream with the V7 patch series
>> on the AMD Seattle server platform. There does not appear to be support
>> for the _CCA attribute in this patch series. The amd-xgbe driver will
>> setup the device domain and cache attributes based on the presence of
>> this attribute, but it requires the arch support to assign the proper
>> DMA operations in order for it to all work correctly.
>>
>> Overriding the _CCA attribute in the driver, I was able to successfully
>> test the driver and this patch series.
>
> Hopefully this will all be addressed when the IORT parts of ACPI have
> settled down (the current proposal allows for these attributes to be
> described as well as their interaction with things like IOMMUs).
>
> In the meantime, are you falling back to non-coherent DMA? If so, what
> attributes have you settled on? We need to be really careful not to
> corrupt data during cache invalidatation when mapping a non-coherent
> buffer for the CPU.
>

The override I used in the driver was to set the device to use AxDOMAIN
of 3 and AxCACHE of 0 so that the caches are not accessed.

Tom

> Will
>

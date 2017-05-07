From: jcm@jonmasters.org (Jon Masters)
Date: Sat, 6 May 2017 20:06:46 -0400
Subject: [PATCH 0/2] Fix incorrect warning from dma-debug
In-Reply-To: <57305FD8.7070006@arm.com>
References: <1462705196-10857-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <57305A4B.70401@arm.com> <57305FD8.7070006@arm.com>
Message-ID: <477ded30-eef2-3598-3a8d-95d206e11efb@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2016 06:00 AM, Robin Murphy wrote:
> On 09/05/16 10:37, Robin Murphy wrote:
>> Hi Niklas,
>>
>> On 08/05/16 11:59, Niklas S?derlund wrote:
>>> Hi,
>>>
>>> While using CONFIG_DMA_API_DEBUG i came across this warning which I
>>> think is a false positive. As shown dma_sync_single_for_device() are
>>> called from the dma_map_single() call path. This triggers the warning
>>> since the dma-debug code have not yet been made aware of the mapping.
>>
>> Almost right ;) The thing being mapped (the SPI device's buffer) and the
>> thing being synced (the IOMMU's PTE) are entirely unrelated. Due to the
>> current of_iommu_init() setup, the IOMMU is probed long before
>> dma_debug_init() gets called, therefore DMA debug is missing entries for
>> some of the initial page table mappings and gets confused when we update
>> them later.

What was the eventual followup/fix for this? We're seeing similar traces
to this during internal testing of 4.11 kernels.

Jon.

-- 
Computer Architect

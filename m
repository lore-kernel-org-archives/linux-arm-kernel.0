From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon, 19 Nov 2012 17:12:03 +0900
Subject: [PATCH 4/4] iommu/exynos: enhancements of System MMU driver with
 DT
In-Reply-To: <20121117124918.GC11220@8bytes.org>
References: <002401cdc245$32dbf3e0$9893dba0$%cho@samsung.com>
 <20121117124918.GC11220@8bytes.org>
Message-ID: <CAHQjnONgB_OM-hVtf8UYLr=HexxQtAiDtf_VKZfr02mUCi4=Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, November 17, 2012, Joerg Roedel <joro@8bytes.org> wrote:
> On Wed, Nov 14, 2012 at 05:51:12PM +0900, Cho KyongHo wrote:
>> This commit enhances power management of System MMU and its client
>> devices with the following changes:
>>  - Each System MMU device becomes the parent device of its client
>>    device while probe(). Thus, exynos-iommu driver must be initialized
>>    before client devices.
>>  - System MMU driver does not pm_runtime_get/put() by itself and runtime
>>    power gating is performed by client devices.
>>  - System is safe when suspend/resume without any care by client device
>>    drivers.
>>
>> In addition, System MMUs can be seperate into several groups that are
>> belongs to a single client device like FIMC-IS block. If such blocks are
>> controlled by a single device descriptor, all System MMUs in the blocks
>> must be enabled/disabled by a single device descriptor. The problem is
>> that clock gating and power gating may be not the same among all System
>> MMUs in the blocks. Thus, System MMUs are grouped by clock gating and
>> power gating and they are chained by parent-child relationships.
>>
>> exynos-iommu driver now also supports debugfs to identify the state of
>> each System MMU.
>>
>> The last big change is to support DT. The desription of the properties
>> of DT nodes are described in the source file.
>>
>> Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
>> ---
>>  drivers/iommu/Kconfig        |   17 +-
>>  drivers/iommu/exynos-iommu.c | 1420
+++++++++++++++++++++++++++++++-----------
>>  2 files changed, 1077 insertions(+), 360 deletions(-)
>
> This patch does multiple things and is quite large. Please split it down
> into reasonable chunks and resubmit.
>
> Patches 1-3 look good to me and I do not mind taking them for 3.8.
> Please let me know if you prefer these patches standalone in 3.8 or
> together with this patch split up.
>

Thank you for review.
I am splitting the fourth patch and will post it by tomorrow.

The current driver does not be probed with the first 3 patches.
I want them to be in 3,8 together.

Cho KyongHo
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121119/7f605367/attachment-0001.html>

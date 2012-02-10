From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 10 Feb 2012 11:00:47 -0800
Subject: [PATCH] ARM: EXYNOS: Adds Samsung TRATS board support
In-Reply-To: <4F3559E7.7060904@samsung.com>
References: <1324624169-16102-1-git-send-email-riverful.kim@samsung.com>
 <1327652483-15655-1-git-send-email-riverful.kim@samsung.com>
 <CAJuYYwRn7Luhj0223-i9u3ETutb8qgFUY7FEBq-ZOUi74DouMA@mail.gmail.com>
 <CAH9JG2VLxmsafu09RmU5GPXnQUMnJo8XZSQcKTkBD2ZpnZ6yPQ@mail.gmail.com>
 <4F3559E7.7060904@samsung.com>
Message-ID: <CAJuYYwQJp0N2bptjbnHFubyg2YUROkUqiy_OaTaRfyvrvehD5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Karol,

On 10 February 2012 09:54, Karol Lewandowski <k.lewandowsk@samsung.com> wrote:
> On 10.02.2012 09:01, Kyungmin Park wrote:
>
>> + Karol for DT support later
>>
>> On Fri, Feb 10, 2012 at 3:58 AM, Thomas Abraham
>> <thomas.abraham@linaro.org> wrote:
>>> Dear Mr. HeungJun Kim,
>>>
>>> On 27 January 2012 00:21, HeungJun, Kim <riverful.kim@samsung.com> wrote:
>>>> This patch adds Samsung Mobile TRATS board support.
>>>>
>>>> Signed-off-by: HeungJun, Kim <riverful.kim@samsung.com>
>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>> ---
>>>> ?arch/arm/mach-exynos/Kconfig ? ? ?| ? 11 ++
>>>> ?arch/arm/mach-exynos/Makefile ? ? | ? ?1 +
>>>> ?arch/arm/mach-exynos/mach-trats.c | ?344 +++++++++++++++++++++++++++++++++++++
>>>> ?3 files changed, 356 insertions(+), 0 deletions(-)
>>>> ?create mode 100644 arch/arm/mach-exynos/mach-trats.c
>>>
>>> The exynos4 dt-enabled board file can support most of the features
>>> added in this board file. The other option that could be considered
>>> here would be to add DT support for this board file, and use AUX_DATA
>>> to supply platform data for drivers that do not have dt support yet.
>>> It would be better to use dt support for new board support that we
>>> add.
>
>
> Thanks to Thomas' work TRATS can be booted today using exynos4-dt.
> However, we are still missing some bits needed to make it fully functional:
>
> ?- sdhci-s3c patchset[1] is needed for eMMC support
>
> ? http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/9216
>
> ?- irq-eint[2] and max8997-pmic[3] for regulators
>
> ? [2] http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/8197
> ? [3] http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/8865
>
> These patches (created entirely by Thomas) would allow me to write
> description (dts) that should cover what mach-trats.c did.
>
> However, due to ongoing irqdomain and related changes I assume this
> might take a while.
>
> Thomas, may I ask about your plans wrt to irqdomains and wakeup/eints
> (this [2] patchset)?

I am in the process of converting max8997, wake-interrupts and
interrupt combiner to the updated irqdomains support posted by Grant
Likely. I will be working on the updated patches for this in the next
week.

Thanks,
Thomas.

>
> Regards,
> --
> Karol Lewandowski | Samsung Poland R&D Center | Linux/Platform

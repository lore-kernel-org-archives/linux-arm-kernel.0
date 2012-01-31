From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 1 Feb 2012 08:56:43 +0900
Subject: [PATCH 1/2] ARM: EXYNOS: add support GPIO for EXYNOS5250
In-Reply-To: <20120131224043.GD8338@n2100.arm.linux.org.uk>
References: <1328025040-4751-1-git-send-email-kgene.kim@samsung.com>
 <1328025040-4751-2-git-send-email-kgene.kim@samsung.com>
 <20120131224043.GD8338@n2100.arm.linux.org.uk>
Message-ID: <CAH9JG2W3Uk=J6GR4C6O6w-vkrG+b=j3ow5mEFbC21EFKS52Sdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Wed, Feb 01, 2012 at 12:50:39AM +0900, Kukjin Kim wrote:
>> From: Sangsu Park <sangsu4u.park@samsung.com>
>>
>> This patch adds follwing.
>> - IO-map for EXYNOS5250 GPIO support
>> - EXYNOS5250 GPIO bank size/number definitions
>> - memory map definition for S5P GPIO4
>>
>> Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>
> Do you actually need these static mapping definitions?  The samsung
> gpiolib initialization is called from a core_initcall(), and at this
> time ioremap() is fully capable of working.

If it assumes it has 8 gpios, you can make it simple calculate it like this.

enum exynos5_gpios {
     EXYNOS5_GPIO_A,
     ...
};

EXYNOS5_GPIO_A_START(n)          (EXYNOS5_GPIO_A * 8)

with this one, it can make a simple gpio driver when using irq domain for GPIO.

Thank you,
Kyungmin Park
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

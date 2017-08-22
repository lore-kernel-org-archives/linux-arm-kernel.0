From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 22 Aug 2017 11:27:06 +0200
Subject: [PATCH v9 0/5] Add runtime PM support for clocks (on Exynos SoC
 example)
In-Reply-To: <CAMuHMdUy5hi3fLVW6J1o=D194ASjr7Vz-pjWtddHyybK4RZxxA@mail.gmail.com>
References: <CGME20170821080538eucas1p1e273ef22920493ee406ef546bcc230e5@eucas1p1.samsung.com>
 <1503302703-13801-1-git-send-email-m.szyprowski@samsung.com>
 <CAMuHMdUy5hi3fLVW6J1o=D194ASjr7Vz-pjWtddHyybK4RZxxA@mail.gmail.com>
Message-ID: <e53af278-061d-bc9b-6f05-65c5e5491d00@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On 2017-08-22 11:21, Geert Uytterhoeven wrote:
> On Mon, Aug 21, 2017 at 10:04 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Patches for clocks drivers change the way the clock provider is initialized.
>> Instead of CLK_OF_DECLARE based initialization, a complete platform device driver
>> infrastructure is being used. This is needed to let driver to use runtime PM
>> feature and integrate with generic power domains. The side-effect of this change
>> is a delay in clock provider registeration during system boot, so early
>> initialized drivers might get EPROBEDEFER error when requesting their clocks.
>> This was an issue for IOMMU drivers, but IOMMU deferred probe support has been
>> finally merged to v4.13-rc1 and now it is handled correctly.
> Any chances you have PHY devices falling back to polling due to this,
> cfr. https://patchwork.kernel.org/patch/9734175/?

At least in case of Exynos5433 all related PHY drivers correctly handle 
deferred
probe and don't fallback to half-functional mode.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

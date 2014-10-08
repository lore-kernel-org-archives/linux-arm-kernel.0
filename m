From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Wed, 8 Oct 2014 16:48:10 +0530
Subject: [PATCH v4 0/6] Add initial support for pinctrl on Exynos7
In-Reply-To: <CACRpkdZ1zH9NBpCLnvzv6g1Ja01kgrdV0GU8_FY2Hak-5GT_ZQ@mail.gmail.com>
References: <1412087450-10495-1-git-send-email-a.kesavan@samsung.com>
 <CAM4voamZhSzEANSpij6oHjEjouqCL+shxHv11Qb8ZiLG81P37g@mail.gmail.com>
 <CACRpkdZ1zH9NBpCLnvzv6g1Ja01kgrdV0GU8_FY2Hak-5GT_ZQ@mail.gmail.com>
Message-ID: <CAM4voanSRw16AiSR5WXjfAB3i-+yVGGFKstoGNNTquRpx6qoNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, Oct 8, 2014 at 3:52 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Oct 6, 2014 at 5:42 AM, Abhilash Kesavan
> <kesavan.abhilash@gmail.com> wrote:
>> On Tue, Sep 30, 2014 at 8:00 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
>>> Changes since v3:
>>>         - Changed variable name from exynos_wkup_irq_chip to irq_chip
>>>         - Added acked-by tag from Tomasz Figa
>>>
>>> Changes since v2:
>>>         - Added a .irq_chip field to the samsung_pin_bank struct
>>>         - Consolidated the wakeup and gpio irqd_ops
>>>
>>> Changes since v1:
>>>         - Marked the newly created irq_chip instances as __initdata
>>>         - Used kmemdup to keep a copy of the irq_chip
>>>         - Change the pinctrl name from sd0_rdqs to sd0_ds as per UM
>>>         - Moved the pinctrl enablement for exynos7 into a separate patch
>>>         - Added tested-by and reviewed-by tags from Thomas Abraham
>
> OK...
>
>> Does this series look OK to you ?
>
> I'm waiting for review comments form Tomasz Figa.

Tomasz had ack'ed my v3 patchset
(http://www.spinics.net/lists/linux-samsung-soc/msg37387.html). This
version fixed the minor issues raised by Tomasz in v3 as well.

>
> I have just applied his 5 refactoring patches as the first base
> for v3.19, I don't know if this stuff will fit nicely on top of these
> or not, expect to find out during review. Tomasz patches have
> priority since they have been in-flight for a while and he is listed
> as maintainer for this driver.
>
> So could you make sure to get Tomasz review tag and make
> sure that these patches work on top of his patches? His
> patches are on my "devel" branch in the pin control tree, but
> will not be pushed to linux-next until the merge window ends.

I will re-base this series on your "devel" branch and post a new
version after testing.

Regards,
Abhilash

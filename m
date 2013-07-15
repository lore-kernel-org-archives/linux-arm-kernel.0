From: grundler@chromium.org (Grant Grundler)
Date: Mon, 15 Jul 2013 09:18:41 -0700
Subject: [PATCH v7 3/9] iommu/exynos: fix page table maintenance
In-Reply-To: <009a01ce814d$840b48c0$8c21da40$@samsung.com>
References: <002b01ce797b$44d4ad10$ce7e0730$@samsung.com>
 <1933986.4vddYccClk@amdc1032>
 <009a01ce814d$840b48c0$8c21da40$@samsung.com>
Message-ID: <CANEJEGs_8a9dPCYtDT8u2NEv5HUUD5gcdmRmbsrKU-_aagztgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 4:21 AM, Cho KyongHo <pullip.cho@samsung.com> wrote:
...
>> Maybe you could add LV1TABLE_SIZE define and use it here (there is
>> already a LV2TABLE_SIZE define)?
>
> Yes. But, LV2TABLE_SIZE is used in more places than one.
> I do not feel that it is needed to define LV1TABLE_SIZE for the single line.

Cho,
#define's are part of the code "documentation". Doesn't really matter
how often it's used. I think Bartlomiej's suggestion is a good one.

Key is to use "consistent" names so they makes sense to someone not
familiar with the code. In this case, we want to show this use is the
same way LV2TABLE_SIZE is used and serves the same purpose.

cheers.
grant

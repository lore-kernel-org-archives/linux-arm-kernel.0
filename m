From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Aug 2015 14:40:07 +0200
Subject: [PATCH 1/2] drivers: PL061: add support for platform driver
 probing
In-Reply-To: <1438585198-8764-2-git-send-email-zhaoshenglong@huawei.com>
References: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
 <1438585198-8764-2-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <CACRpkdY6ZfB-gnnr49He+BYELy4fhiV0g5jkEHhyVsJOc_SBFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 3, 2015 at 8:59 AM, Shannon Zhao <zhaoshenglong@huawei.com> wrote:

> From: Shannon Zhao <shannon.zhao@linaro.org>
>
> Since PL061 currently only supports AMBA driver, to support using GPIO
> PL061 by DT or ACPI, it needs to add support for platform driver.
> A DT binding is provided with this patch, ACPI support is added in a
> separate one.
>
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

I already stated in 0/2 what the problem is with this, and it's obviously adding
a huge codechunk, very similar to the AMBA probe path.

We need to investigate if ACPI can just spawn AMBA/PrimeCell type devices
instead.

Yours,
Linus Walleij

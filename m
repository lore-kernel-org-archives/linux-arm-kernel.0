From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 17:46:46 +0200
Subject: [PATCH] ARM: ux500: Fix regression while init PM domains
In-Reply-To: <CACRpkdau60y2foj06R7=BTAJ4sob+QNLOadCDajnznZtdohdYA@mail.gmail.com>
References: <1507263625-16756-1-git-send-email-ulf.hansson@linaro.org>
 <CACRpkdau60y2foj06R7=BTAJ4sob+QNLOadCDajnznZtdohdYA@mail.gmail.com>
Message-ID: <CAK8P3a17dK5yJdm9Cgu67UXmb1hL+OjU_OK28wcm2qcBndekxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 9, 2017 at 1:31 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Oct 6, 2017 at 6:20 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> The commit afece3ab9a36 ("PM / Domains: Add time accounting to various
>> genpd states") causes a boot regression for ux500.
>>
>> The problem occurs when the ux500 machine code calls pm_genpd_init(), which
>> since the above change triggers a call to ktime_get(). More precisely,
>> because ux500 initializes PM domains in the init_IRQ() phase of the boot,
>> timekeeping has not yet been initialized.
>>
>> Fix the problem by moving the initialization of the PM domains to after
>> timekeeping has been initialized.
>>
>> Fixes: afece3ab9a36 ("PM / Domains: Add time accounting to various genpd..")
>> Cc: Thara Gopinath <thara.gopinath@linaro.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> ARM SoC folks: please apply this directly for fixes!

Applied, thanks!

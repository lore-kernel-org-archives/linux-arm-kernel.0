From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 15 May 2018 10:06:48 +0200
Subject: [PATCH] PM / Domains: Don't return -EEXIST at attach when PM
 domain exists
In-Reply-To: <20180515005342.GM98604@atomide.com>
References: <1526309557-7995-1-git-send-email-ulf.hansson@linaro.org>
 <20180515005342.GM98604@atomide.com>
Message-ID: <CAJZ5v0iaF9NfajAUT_m8E_AKySnjV-A6xpiXXz=_8LGe8oD1qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 2:53 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Ulf Hansson <ulf.hansson@linaro.org> [180514 14:55]:
>> As dev_pm_domain_attach() isn't the only way to assign PM domain pointers
>> to devices, clearly we must allow a device to have the pointer already
>> being assigned. For this reason, return 0 instead of -EEXIST.
>>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Tested-by: Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Fixes the issue for me too:
>
> Tested-by: Tony Lindgren <tony@atomide.com>

I've applied the patch with the tag above, thanks!

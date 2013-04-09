From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 9 Apr 2013 11:38:27 +0530
Subject: [PATCH v3] mmc: dw_mmc: let device core setup the default pin
 configuration
In-Reply-To: <CAD=FV=U7kf_b92w7rDFkZN8Wr4sDTq5_=pMHaP948dT5CZbHsg@mail.gmail.com>
References: <1365170015-3009-1-git-send-email-thomas.abraham@linaro.org>
 <CAD=FV=U7kf_b92w7rDFkZN8Wr4sDTq5_=pMHaP948dT5CZbHsg@mail.gmail.com>
Message-ID: <CAJuYYwTAUnjwGsxfHho2jQXvkQfV2Kcvx-QfqCDqq7D7Fu0x7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 April 2013 21:38, Doug Anderson <dianders@google.com> wrote:
> Thomas,
>
> Since I commented on previous versions of this patch, I would have
> loved to have been CCed on this new version.  ;)

Hi Doug,

Sorry for missing out on CC'ing you in the v3 patch. It just slipped my mind.

>
> On Fri, Apr 5, 2013 at 6:53 AM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> With device core now able to setup the default pin configuration,
>> the pin configuration code based on the deprecated Samsung specific
>> gpio bindings is removed.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> Changes since v2:
>> - Changed patch subject from "mmc: dwmmc: let..." to "mmc: dw_mmc: let..."
>> - Rebased to Chris's latest mmc-next branch.
>>
>>  drivers/mmc/host/dw_mmc-exynos.c |   38 --------------------------------------
>>  drivers/mmc/host/dw_mmc.c        |   12 ++----------
>>  drivers/mmc/host/dw_mmc.h        |    3 ---
>>  3 files changed, 2 insertions(+), 51 deletions(-)
>
> This patch applies fine but fails to compile on linux-next
> "next-20130408".  You lost the race with:
>    f2f942c mmc: dw_mmc: Check return value of regulator_enable
>
> ...that patch adds a "goto err_setup_bus" and you've renamed that
> label.  I guess you get another fun rebase.
>
> NOTE: this patch is even more urgent than it was before.  It looks
> like pincontrol stuff has now landed in linux-next which means that
> Exynos5 devices that need eMMC/SD will no longer boot until this patch
> goes in.

Ok. I have posted the v4 version of this patch taking care of this.
Thanks for pointing this out.

Regards,
Thomas.

>
> -Doug

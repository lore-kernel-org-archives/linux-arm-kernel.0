From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 10 May 2012 16:25:59 +0530
Subject: [PATCH 4/7] mmc: dw_mmc: add samsung exynos5250 specific
 extentions
In-Reply-To: <CAOesGMiJrfCgLHmBix1WUrpF-0D9tG5r6xi-3zsiM7KQjkO=ug@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
 <1335935266-25289-5-git-send-email-thomas.abraham@linaro.org>
 <CAOesGMiJrfCgLHmBix1WUrpF-0D9tG5r6xi-3zsiM7KQjkO=ug@mail.gmail.com>
Message-ID: <CAJuYYwQsOpDWzsNnnJuNYvD+ag6qO5bTOBt52AYV7V2u9bv9bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 May 2012 23:40, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Tue, May 1, 2012 at 10:07 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> The instantiation of the Synopsis Designware controller on Exynos5250
>> include extension for SDR and DDR specific tx/rx phase shift timing
>> and CIU internal divider. In addition to that, the option to skip the
>> command hold stage is also introduced. Add support for these Exynos5250
>> specfic extenstions.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?.../devicetree/bindings/mmc/synposis-dw-mshc.txt ? | ? 33 +++++++++++++++++++-
>> ?drivers/mmc/host/dw_mmc-pltfm.c ? ? ? ? ? ? ? ? ? ?| ? ?8 +++++
>> ?drivers/mmc/host/dw_mmc.c ? ? ? ? ? ? ? ? ? ? ? ? ?| ? 32 ++++++++++++++++++-
>> ?drivers/mmc/host/dw_mmc.h ? ? ? ? ? ? ? ? ? ? ? ? ?| ? 13 ++++++++
>> ?include/linux/mmc/dw_mmc.h ? ? ? ? ? ? ? ? ? ? ? ? | ? ?6 +++
>> ?5 files changed, 89 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
>> index c1ed70e..465fc31 100644
>> --- a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
>> @@ -7,6 +7,8 @@ Required Properties:
>>
>> ?* compatible: should be one of the following
>> ? ? ? ?- synopsis,dw-mshc: for controllers compliant with synopsis dw-mshc.
>> + ? ? ? - synopsis,dw-mshc-exynos5250: for controllers with Samsung
>> + ? ? ? ? Exynos5250 specific extentions.
>
> It makes more sense to use your own manufacturer prefix here:
>
> samsung,exynos5250-dw-mshc
>

Ok. I will modify the compatible value as you have suggested.

Thanks,
Thomas.

>
> -Olof

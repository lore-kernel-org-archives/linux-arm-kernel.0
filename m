From: dianders@chromium.org (Doug Anderson)
Date: Tue, 24 Jun 2014 14:33:20 -0700
Subject: [PATCH] ARM: DTS: correct the capability string for mmc0
In-Reply-To: <034701cf8ed7$70c78330$52568990$@samsung.com>
References: <1403522420-1208-1-git-send-email-ch.naveen@samsung.com>
 <034701cf8ed7$70c78330$52568990$@samsung.com>
Message-ID: <CAD=FV=XJpx_otzW-dWNj1rnXMYab7vPGjo2KNirwyVKtEKat2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 23, 2014 at 4:36 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Naveen Krishna Chatradhi wrote:
>>
>> MMC capability for HS200 is parsed in mmc/core/host.c as
>> dts string "mmc-hs200-1_8v".
>>
>> This patch corrects the dts string for Exynos5420 based peach-pit
>> and Exynos5800 based peach-pi boards.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5420-peach-pit.dts |    2 +-
>>  arch/arm/boot/dts/exynos5800-peach-pi.dts  |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-
>> peach-pit.dts
>> index 7649982..7dea480 100644
>> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> @@ -173,7 +173,7 @@
>>       status = "okay";
>>       num-slots = <1>;
>>       broken-cd;
>> -     caps2-mmc-hs200-1_8v;
>> +     mmc-hs200-1_8v;
>>       supports-highspeed;
>>       non-removable;
>>       card-detect-delay = <200>;
>> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-
>> peach-pi.dts
>> index 2c2c137..bb3ee76 100644
>> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
>> @@ -171,7 +171,7 @@
>>       status = "okay";
>>       num-slots = <1>;
>>       broken-cd;
>> -     caps2-mmc-hs200-1_8v;
>> +     mmc-hs200-1_8v;
>>       supports-highspeed;
>>       non-removable;
>>       card-detect-delay = <200>;
>> --
>> 1.7.9.5
>
> Applied, thanks.

As an FYI: this patch (while correct) will likely cause sporadic boot
failures until Sonny and my patches land:

* https://patchwork.kernel.org/patch/4323921/
  mmc: dw_mmc: Make sure we don't get stuck when we get an error

* https://patchwork.kernel.org/patch/4213211/
  mmc: dw_mmc: change to use recommended reset procedure

In the very least we got sporadic boot failures locally when we
enabled hs200 and didn't have the "don't get stuck" patch.  I will
also note that it would have been nice had this patch title included
the words exynos and/or pit/pi in it.

-Doug

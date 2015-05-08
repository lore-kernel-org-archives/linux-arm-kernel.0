From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 8 May 2015 09:09:15 +0900
Subject: [PATCH 1/1] ARM: dts: Add keep-power-in-suspend to WiFi SDIO node
 for Snow
In-Reply-To: <CAD=FV=XJXHjXxirjwPfrJ3=xOj46GTqdSxxFstzjTVJ9HP1Q=w@mail.gmail.com>
References: <1430929979-18119-1-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=XJXHjXxirjwPfrJ3=xOj46GTqdSxxFstzjTVJ9HP1Q=w@mail.gmail.com>
Message-ID: <CAJKOXPc88v_VzqE54sup4JHAgqwYCn0g_zpKgJwpny3egaZAbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-07 1:36 GMT+09:00 Doug Anderson <dianders@chromium.org>:
> Javier,
>
> On Wed, May 6, 2015 at 9:32 AM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>> The Marvell mwifiex driver prevents the system to enter into a suspend
>> state if the card power is not preserved during a suspend/resume cycle.
>>
>> So Suspend-to-RAM and Suspend-to-idle are failing on Exynos5250 Snow.
>>
>> Add the keep-power-in-suspend Power Management property to the SDIO/MMC
>> node so the mwifiex suspend handler doesn't fail and the system is able
>> to enter into a suspend state.
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>
>> Kukjin and Krzysztof,
>>
>> I didn't notice that Snow was also missing this property when I did the
>> same change for Peach Pit and and Pi Chromebooks [0], sorry about that.
>>
>> Best regards,
>> Javier
>>
>> [0]: https://lkml.org/lkml/2015/4/7/377
>> ---
>>  arch/arm/boot/dts/exynos5250-snow.dts | 1 +
>>  1 file changed, 1 insertion(+)
>
> Reviewed-by: Doug Anderson <dianders@chromium.org>

Thanks, applied to dts-fixes branch, I'll try to push it sooner than
later but it depends on status of previous pull requests.

Best regards,
Krzysztof

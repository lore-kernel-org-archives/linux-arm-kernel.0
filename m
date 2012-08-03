From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 3 Aug 2012 13:54:07 -0300
Subject: [PATCH] MXS: Fix mxs_defconfig MMAP_MIN_ADDR
In-Reply-To: <CAOMZO5DZui3x554WcHsseSfXDgYeaq1va-QzVy1CQajE3M3=kQ@mail.gmail.com>
References: <1344009354-13249-1-git-send-email-marex@denx.de>
 <CAOMZO5DZui3x554WcHsseSfXDgYeaq1va-QzVy1CQajE3M3=kQ@mail.gmail.com>
Message-ID: <CAOMZO5AzaDcxJJV+Z-bHH58=xRq5RY6BanEjMd4uUhN+K9ZNZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 3, 2012 at 1:46 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Marek,
>
> On Fri, Aug 3, 2012 at 12:55 PM, Marek Vasut <marex@denx.de> wrote:
>> Initially reported by Detlev Zundel <dzu@denx.de>, this caused breakage
>> when "su - testuser" was called. "testuser" being a regular user account,
>> the command ended with SIGKILL.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Wolfgang Denk <wd@denx.de>
>> ---
>>  arch/arm/configs/mxs_defconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
>> index ccdb635..f212802 100644
>> --- a/arch/arm/configs/mxs_defconfig
>> +++ b/arch/arm/configs/mxs_defconfig
>> @@ -34,7 +34,7 @@ CONFIG_NO_HZ=y
>>  CONFIG_HIGH_RES_TIMERS=y
>>  CONFIG_PREEMPT_VOLUNTARY=y
>>  CONFIG_AEABI=y
>> -CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
>> +CONFIG_DEFAULT_MMAP_MIN_ADDR=32768
>
> No need to set it to 32768.
>
> If you just remove the 'CONFIG_DEFAULT_MMAP_MIN_ADDR=65536' then this
> symbol will be 32768.

Sorry, ignore what I said. I just realized that the default is 4096.

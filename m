From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 5 Jul 2017 14:52:46 -0700
Subject: [PATCH] rtc: brcmstb-waketimer: fix settime function
In-Reply-To: <20170705211327.guccztud22hcmfjy@piout.net>
References: <20170628200839.3114345-1-arnd@arndb.de>
 <20170705211327.guccztud22hcmfjy@piout.net>
Message-ID: <aa080524-e532-6f72-f81b-35a0d3e919fb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2017 02:13 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 28/06/2017 at 22:07:34 +0200, Arnd Bergmann wrote:
>> gcc warns about an unused variable in the new driver:
>>
>> drivers/rtc/rtc-brcmstb-waketimer.c: In function 'brcmstb_waketmr_settime':
>> drivers/rtc/rtc-brcmstb-waketimer.c:142:6: error: unused variable 'ret' [-Werror=unused-variable]
>>
>> The same function also doesn't handle overflow correctly, this makes
>> it return -EINVAL when passed a time that doesn't fit within the
>> range of the register.
>>
>> Fixes: 9f4ad359c801 ("rtc: brcmstb-waketimer: Add Broadcom STB wake-timer")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/rtc/rtc-brcmstb-waketimer.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>
> 
> I've squashed it in the original commit, I hope this is fine for you.

Works for me, thanks Alexandre!
-- 
Florian

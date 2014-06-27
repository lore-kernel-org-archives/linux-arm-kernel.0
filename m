From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 27 Jun 2014 11:32:56 +0200
Subject: [PATCH v5 02/14] mfd: max77686: Allow the max77686 rtc to wakeup
 the system
In-Reply-To: <20140627092149.GH19645@lee--X1>
References: <1403806546-31122-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403806546-31122-3-git-send-email-javier.martinez@collabora.co.uk>
 <20140627092149.GH19645@lee--X1>
Message-ID: <53AD3A48.4090307@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

On 06/27/2014 11:21 AM, Lee Jones wrote:
> On Thu, 26 Jun 2014, Javier Martinez Canillas wrote:
> 
>> From: Doug Anderson <dianders@chromium.org>
>> 
>> The max77686 includes an RTC that keeps power during suspend.  It's
>> convenient to be able to use it as a wakeup source.
>> 
>> NOTE: due to wakeup ordering problems this patch alone doesn't work so
>> well on exynos5250-snow.  You also need something that brings the i2c
>> bus up before the max77686 wakeup runs.
>> 
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>> 
>> Changes since v4: None
>> 
>> Changes since v3:
>>  - Keep the note that this patch needs another change due wakeup
>>    ordering problems.
>> 
>>  drivers/rtc/rtc-max77686.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
> 
> This patch doesn't actually touch the MFD subsystem directly.  Can you
> change the $SUBJECT line accordingly please?
> 

You're right, I'll change the $subject.

Best regards,
Javier

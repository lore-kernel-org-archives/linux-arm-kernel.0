From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Mon, 23 Feb 2015 13:23:21 +0100
Subject: [alsa-devel] [PATCH] ASoC: max98088: Add master clock handling
In-Reply-To: <54EAE4DF.3040607@collabora.co.uk>
References: <1424283959-16289-3-git-send-email-afaerber@suse.de>
 <1424373526-4135-1-git-send-email-afaerber@suse.de>
 <54E6A9AB.4070401@gmail.com> <54EAE4DF.3040607@collabora.co.uk>
Message-ID: <54EB1BB9.4030205@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 23.02.2015 um 09:29 schrieb Javier Martinez Canillas:
> On 02/20/2015 04:27 AM, Tushar Behera wrote:
>> On 02/20/2015 12:48 AM, Andreas F?rber wrote:
>>> If master clock is provided through device tree, then update
>>> the master clock frequency during set_sysclk.
>>>
>>> Cc: Tushar Behera <tushar.behera@linaro.org>
>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>> ---
>>>  sound/soc/codecs/max98088.c | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>
>> Looks good.
>>
>> Acked-by: Tushar Behera <trblinux@gmail.com>
>>
> 
> Looks good to me as well.
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Thanks guys. One self-doubt: Is there any downside to returning
-EPROBE_DEFER after regcache_mark_dirty(max98088->regmap)? I.e., should
I move the last hunk some lines up to be the very first thing executed?

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)

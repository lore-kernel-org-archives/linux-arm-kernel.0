From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 13 Nov 2012 17:38:04 +0800
Subject: [PATCH v5 2/3] ASoC: atmel-ssc-dai: register dai and pcm directly
In-Reply-To: <20121113092038.GU18224@opensource.wolfsonmicro.com>
References: <1352706028-750-1-git-send-email-voice.shen@atmel.com>
 <1352706028-750-3-git-send-email-voice.shen@atmel.com>
 <20121113083031.GP18224@opensource.wolfsonmicro.com>
 <50A20E82.9020704@atmel.com>
 <20121113092038.GU18224@opensource.wolfsonmicro.com>
Message-ID: <50A214FC.90201@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2012 17:20, Mark Brown wrote:
> On Tue, Nov 13, 2012 at 05:10:26PM +0800, Bo Shen wrote:
>> On 11/13/2012 16:30, Mark Brown wrote:
>
>>> Why are you changing this?  Single devices are supposed to specify -1 as
>>> their id.
>
>> This is for non-dt support, using the id to tell which ssc will be
>> used to remap into audio subsystem. Maybe this is a mixed up usage,
>> however I can not find good solution, any suggestions?
>
> The machine driver should know which SSC it is using all by itself, it's
> specific to a particular machine.  This is how it's been doing it since
> it was written...

So, you mean, I should hard code this into machine driver, am I right?

>> This is a similar implement as 7840487cd6298f9f931103b558290d8d98d41c49
>
> Don't quote raw commit IDs, they're not legible by humans.
>
>> Yes, this patch is a little more than registration, however when
>> change the registration method, the related code will be affected,
>> so also clean up them in this patch, do I need to split this patch?
>
> Yes, one change per patch.  Having many unrelated changes in one patch
> makes it very difficult to review anything.

OK, I will split this patch.

Best Regards,
Bo Shen

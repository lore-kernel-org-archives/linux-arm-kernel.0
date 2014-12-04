From: rajeevkumar.linux@gmail.com (rajeev kumar)
Date: Thu, 4 Dec 2014 12:10:17 +0530
Subject: [PATCH 2/5] ASoC: dwc: Don't allow negative use counts
In-Reply-To: <20141203172526.GC7712@sirena.org.uk>
References: <547F3C9F.8080102@arm.com>
	<20141203172526.GC7712@sirena.org.uk>
Message-ID: <CAA7nrtjrQ5SpDrZRPb58zqmZrWahY3XOMWnmdH70WLr3q46_bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 3, 2014 at 10:55 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Dec 03, 2014 at 04:38:55PM +0000, Andrew Jackson wrote:
>
>>       case SNDRV_PCM_TRIGGER_STOP:
>>       case SNDRV_PCM_TRIGGER_SUSPEND:
>>       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> -             dev->active--;
>> +             if (dev->active > 0)
>> +                     dev->active--;
>
> How is this triggering - this sounds like you're papering over some
> other bug somewhere?

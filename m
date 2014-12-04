From: rajeevkumar.linux@gmail.com (rajeev kumar)
Date: Thu, 4 Dec 2014 12:13:46 +0530
Subject: [PATCH 2/5] ASoC: dwc: Don't allow negative use counts
In-Reply-To: <CAA7nrtjrQ5SpDrZRPb58zqmZrWahY3XOMWnmdH70WLr3q46_bA@mail.gmail.com>
References: <547F3C9F.8080102@arm.com> <20141203172526.GC7712@sirena.org.uk>
 <CAA7nrtjrQ5SpDrZRPb58zqmZrWahY3XOMWnmdH70WLr3q46_bA@mail.gmail.com>
Message-ID: <CAA7nrth+h32Un2C4z106wL181eru7hwFDxMdS00X55h5Zw=-Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 4, 2014 at 12:10 PM, rajeev kumar
<rajeevkumar.linux@gmail.com> wrote:
> On Wed, Dec 3, 2014 at 10:55 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Wed, Dec 03, 2014 at 04:38:55PM +0000, Andrew Jackson wrote:
>>
>>>       case SNDRV_PCM_TRIGGER_STOP:
>>>       case SNDRV_PCM_TRIGGER_SUSPEND:
>>>       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>>> -             dev->active--;
>>> +             if (dev->active > 0)
>>> +                     dev->active--;
>>
>> How is this triggering - this sounds like you're papering over some
>> other bug somewhere?

This check can be removed as it is not going to triggered.

B'rgds
~Rajeev

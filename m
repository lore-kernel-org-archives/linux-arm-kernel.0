From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Thu, 04 Dec 2014 09:07:51 +0000
Subject: [PATCH 2/5] ASoC: dwc: Don't allow negative use counts
In-Reply-To: <CAA7nrth+h32Un2C4z106wL181eru7hwFDxMdS00X55h5Zw=-Vg@mail.gmail.com>
References: <547F3C9F.8080102@arm.com>	<20141203172526.GC7712@sirena.org.uk>	<CAA7nrtjrQ5SpDrZRPb58zqmZrWahY3XOMWnmdH70WLr3q46_bA@mail.gmail.com>
 <CAA7nrth+h32Un2C4z106wL181eru7hwFDxMdS00X55h5Zw=-Vg@mail.gmail.com>
Message-ID: <54802467.4000702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/14 06:43, rajeev kumar wrote:
> On Thu, Dec 4, 2014 at 12:10 PM, rajeev kumar
> <rajeevkumar.linux@gmail.com> wrote:
>> On Wed, Dec 3, 2014 at 10:55 PM, Mark Brown <broonie@kernel.org> wrote:
>>> On Wed, Dec 03, 2014 at 04:38:55PM +0000, Andrew Jackson wrote:
>>>
>>>>       case SNDRV_PCM_TRIGGER_STOP:
>>>>       case SNDRV_PCM_TRIGGER_SUSPEND:
>>>>       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>>>> -             dev->active--;
>>>> +             if (dev->active > 0)
>>>> +                     dev->active--;
>>>
>>> How is this triggering - this sounds like you're papering over some
>>> other bug somewhere?
> 
> This check can be removed as it is not going to triggered.

As I said in my email to Mark, I couldn't convince myself that STOP/SUSPEND would only be called once so it seemed like a loophole which /might/ result in the device not functioning correctly.

If this can never happen, I'll drop the patch.

	Andrew

> B'rgds
> ~Rajeev
> 

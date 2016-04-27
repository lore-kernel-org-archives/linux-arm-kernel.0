From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Wed, 27 Apr 2016 17:10:35 -0300
Subject: [PATCH 1/5] leds: triggers: Allow to switch the trigger to
 "panic" on a kernel panic
In-Reply-To: <571F1593.8000400@samsung.com>
References: <1459801326-5541-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1459801326-5541-2-git-send-email-ezequiel@vanguardiasur.com.ar>
 <20160424092551.GB23015@amd> <20160424092951.GA25596@amd>
 <571DBFAE.7060605@samsung.com>
 <CAAEAJfC=O1akKKdW-9P7OkFZyDfE-ApbWhdYr7HPhszDrFcV1Q@mail.gmail.com>
 <571F1593.8000400@samsung.com>
Message-ID: <CAAEAJfCnMMHc7yLf7fPCRUw7e4LAASJYLjE-vLwTU_KPLax3zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 April 2016 at 04:15, Jacek Anaszewski <j.anaszewski@samsung.com> wrote:
> Hi Ezequiel,
>
> On 04/25/2016 06:27 PM, Ezequiel Garcia wrote:
>>
>> On 25 April 2016 at 03:56, Jacek Anaszewski <j.anaszewski@samsung.com>
>> wrote:
>>>
>>> On 04/24/2016 11:29 AM, Pavel Machek wrote:
>>>>
>>>>
>>>> On Sun 2016-04-24 11:25:51, Pavel Machek wrote:
>>>>>
>>>>>
>>>>> On Mon 2016-04-04 17:22:02, Ezequiel Garcia wrote:
>>>>>>
>>>>>>
>>>>>> This commit adds a new led_cdev flag LED_BLINK_AT_PANIC, which
>>>>>> allows to mark a specific LED to be switched to the "panic"
>>>>>> trigger, on a kernel panic.
>>>>>>
>>>>>> This is useful to allow the user to assign a regular trigger
>>>>>> to a given LED, and still blink that LED on a kernel panic.
>>>>>>
>>>>>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>    drivers/leds/led-triggers.c | 52
>>>>>> +++++++++++++++++++++++++++++++++++++++++++++
>>>>>>    include/linux/leds.h        |  1 +
>>>>>
>>>>>
>>>>>
>>>>> Could we get this out of the core? I'm pretty sure most users are not
>>>>> interested...
>>>
>>>
>>>
>>> Good point.
>>>
>>
>> Not sure how we can get it out of the core, and still implement it.
>>
>> The goal is to run-time switch user-specified LEDs and blink them when
>> the kernel panics, and so it needs to mess up with some core private
>> structures.
>>
>> Unless we don't want this feature at all.
>>
>
> It seems that the entire added code can be easily moved to a separate
> module, let's say led-panic-notifier.c ? It should select
> LEDS_TRIGGER_PANIC, as it would make no sense to have the former enabled
> without the latter.
>

OK, let me try that.
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar

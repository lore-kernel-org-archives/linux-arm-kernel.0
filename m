From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 8 Mar 2017 23:20:36 +0100
Subject: [PATCH 1/2] ARM: dts: BCM53573: Don't use nonexistent
 "default-off" LED trigger
In-Reply-To: <42bce8ea-f1dc-2018-33f1-d296ccd7b677@gmail.com>
References: <20170308064105.26619-1-zajec5@gmail.com>
 <42bce8ea-f1dc-2018-33f1-d296ccd7b677@gmail.com>
Message-ID: <CACna6rz7Bm4DT4Mo3zgU+14uFHMDbQNEX6ejiY=RD-d1WMKcSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 March 2017 at 18:31, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 03/07/2017 10:41 PM, Rafa? Mi?ecki wrote:
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>
>> Such a trigger doesn't exist in Linux and is not needed as LED is being
>> turned off by default. This could cause errors in LEDs core code when
>> trying to set default trigger.
>>
>> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
>
> Since you are fixing something, what's the proper Fixes: tag for this
> commit? Likewise for the second patch.

This problem was exposed by the commit f363a870eaef ("leds: core: use
deferred probing if default trigger isn't available yet") pushed to
the:
https://git.kernel.org/cgit/linux/kernel/git/j.anaszewski/linux-leds.git/log/?h=for-next

I reported problems caused by this commit in e-mail thread
New problems after f363a870eaef ("leds: core: use deferred probing if
default trigger isn't available yet")
(I can't access linux-leds archive) and it was dropped after my report.

So there is nothing to point in the "Fixes:".

-- 
Rafa?

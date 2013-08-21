From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Aug 2013 01:04:23 +0200
Subject: [PATCH v2] pinctrl: queue GPIO operations instead of defering
In-Reply-To: <5214FCB6.4040200@wwwdotorg.org>
References: <1376751410-14560-1-git-send-email-linus.walleij@linaro.org>
 <52127035.7000909@wwwdotorg.org> <5214FCB6.4040200@wwwdotorg.org>
Message-ID: <CACRpkdbNh6ooBh-dhT=KKHQMZ=uK_AQMsreTg56kVXE5cE1ohQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 7:45 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/19/2013 01:21 PM, Stephen Warren wrote:
>> On 08/17/2013 08:56 AM, Linus Walleij wrote:
>>> We currently defer probing of the caller if a pinctrl GPIO
>>> request or direction setting comes in before the range mapping
>>> a certain GPIO to a certain pin controller is available.
>>>
>>> This can end up with a circular dependency: the GPIO driver
>>> needs the pin controller to be ready and the pin controller
>>> need the GPIO driver to be ready. This also happens if
>>> pin controllers and GPIO controllers compiled as modules
>>> are inserted in a certain order.
>>>
>>> To break this circular dependence, queue any GPIO
>>> operations coming to the framework until the range is ready,
>>> instead of deferring the probe of the caller.
>>
>> I just noticed that next-20130819 is failing on the Tegra114 Dalmore
>> board because of this patch. The kernel log is below. Reverting this
>> patch solves the problem
>
> Linus, any thoughts here?

None whatsoever, but logically it should be that your pinctrl+GPIO
driver pair depends on the GPIO driver coming first and having it's probing
deferred.

I'll rip out that patch for the time being...

Yours,
Linus Walleij

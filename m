From: robherring2@gmail.com (Rob Herring)
Date: Sat, 1 Feb 2014 16:24:23 -0600
Subject: [PATCH] ARM: hisi: don't select SMP
In-Reply-To: <CAOesGMgQG=ozUDZzp2Pu7uLt3EZRxaBM-kO3XZJ0y+RDdaLqeA@mail.gmail.com>
References: <1391205990-22506-1-git-send-email-robherring2@gmail.com>
 <20140131225116.GA6284@quad.lixom.net>
 <CAL_JsqJPVDQ1_gpMKWxMpUYcU0HyedrNvOsu0qa2gZnXnDUHbA@mail.gmail.com>
 <CAOesGMgQG=ozUDZzp2Pu7uLt3EZRxaBM-kO3XZJ0y+RDdaLqeA@mail.gmail.com>
Message-ID: <CAL_JsqJqPMLaL=8rwayJhKbZu+nLXozpTiATc9OvZv6JLNkOgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 1, 2014 at 10:43 AM, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Feb 1, 2014 at 7:52 AM, Rob Herring <robherring2@gmail.com> wrote:
>> On Fri, Jan 31, 2014 at 4:51 PM, Olof Johansson <olof@lixom.net> wrote:
>>> On Fri, Jan 31, 2014 at 04:06:30PM -0600, Rob Herring wrote:
>>>> From: Rob Herring <robh@kernel.org>
>>>>
>>>> SMP is a user configurable option, not a hardware feature and should not
>>>> be selected.
>>>>
>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>
>>> Yep, you're right. applied to fixes.
>>
>> After doing some randconfig builds I found HAVE_ARM_TWD and
>> HAVE_ARM_SCU need to have "if SMP" added here. I also found OMAP and
>> SH-Mobile are still using LOCAL_TIMER which has been gone for a year.
>> I guess everyone tests with other platforms enabled or don't notice
>> they are using broadcast timer. Patch is coming.
>
> Yep, I noticed the same yesterday but please send the patch over and
> I'll apply it before sending up the current batch.
>
> The OMAP platform that uses LOCAL_TIMER is OMAP5, and 5 isn't
> functional in mainline yet -- I can guarantee you that nobody is
> testing it. :(

Actually that is needed for OMAP4 as ARM_TWD is the Cortex-A9 timers.

Rob

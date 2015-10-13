From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 13 Oct 2015 15:26:07 +0100
Subject: [PATCH 2/2] ARM: dts: change gpio-key,wakeup property to boolean
In-Reply-To: <CAL_JsqKDrvxas-x9QoLEs3yuDtEY+0u5qJZ4ZPiRQX0SrMKY2w@mail.gmail.com>
References: <1444743164-17735-1-git-send-email-sudeep.holla@arm.com>
 <1444743164-17735-2-git-send-email-sudeep.holla@arm.com>
 <CAL_JsqKDrvxas-x9QoLEs3yuDtEY+0u5qJZ4ZPiRQX0SrMKY2w@mail.gmail.com>
Message-ID: <561D147F.6090907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/10/15 15:07, Rob Herring wrote:
> On Tue, Oct 13, 2015 at 8:32 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Keyboard driver for GPIO buttons(gpio-keys) checks for the legacy
>> "gpio-key,wakeup" boolean property to enable gpio buttons as wakeup
>> source.
>>
>> Few dts files assign value "1" to gpio-key,wakeup and in one instance a
>> value "0" is assigned probably assuming it won't be enabled as a wakeup
>> source. Since the presence of the boolean property indicates it is
>> enabled, value of "0" have no value.
>>
>> This patch removes the property where value "0" is assigned and removes
>> the value "1" in most of the other cases.
>
> Why don't you just change everything to wakeup-source.
>

Agreed, I wanted to do that but was not sure if that's acceptable.
I will update it, now I know that you are fine with it.

I also plan to find all the variety of bindings we have and fix them
retaining only those which are handled in the current kernel code as
legacy support.

-- 
Regards,
Sudeep

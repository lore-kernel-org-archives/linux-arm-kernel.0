From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 27 Jun 2016 16:44:20 +0200
Subject: [RFC PATCH] clocksource: arm_arch_timer: disable the evtstrm via
 the cmdline
In-Reply-To: <20160620133002.GB20071@e104818-lin.cambridge.arm.com>
References: <1466171011-30468-1-git-send-email-will.deacon@arm.com>
 <5766FBC6.6000405@linaro.org> <20160620082157.GC29165@arm.com>
 <5767E89F.5020809@linaro.org>
 <20160620133002.GB20071@e104818-lin.cambridge.arm.com>
Message-ID: <57713BC4.5040909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2016 03:30 PM, Catalin Marinas wrote:
> On Mon, Jun 20, 2016 at 02:59:11PM +0200, Daniel Lezcano wrote:
>> On 06/20/2016 10:21 AM, Will Deacon wrote:
>>> On Sun, Jun 19, 2016 at 10:08:38PM +0200, Daniel Lezcano wrote:
>>>> On 06/17/2016 03:43 PM, Will Deacon wrote:
>>>>
>>>> [ Cc'ed tglx ]
>>>>
>>>>> Disabling the eventstream can be useful for debugging and development
>>>>> purposes
>>>>
>>>> If it is for debugging and development, why upstream this change ?
>>>
>>> Mainly because it's desirable to be able to debug systems remotely, on
>>> machines that you don't have direct access to and where recompiling the
>>> kernel isn't necessarily an option. There are plenty of "no*" kernel
>>> parameters already that fall into a similar category.
>>
>> if the kernel is in development and debug, why this option can't be part of
>> debugging code ?
>
> Because we may actually be debugging the hardware rather than the
> software. With the event stream enabled, WFE is woken up periodically.
> This can be a handy feature for user locking primitives or a simple
> workaround for hardware bugs (and we've seen them before). But the side
> effect is that it may be potentially hiding hardware issues.
>
> For hardware testing/validation, you'd want to sometimes disable this
> feature to check whether your event generation (usually as a result of
> exclusive monitor clearing) is working as expected. It's much easier to
> do with a command line option.
>
>> I'm not a big fan of the all the specific driver options for the kernel
>> parameters. If there is a real need to disable some parts of a driver, it
>> would be much more interesting to write a framework for that and then use it
>> from arm_arch_timer, thus giving the other drivers the opportunity to
>> provide the same feature.
>
> Well, how many non-ARM timer drivers have an exclusive monitor event
> stream feature to make sense for a framework?

Ok.

What about an option like:

clocksource.arch_arm.evtstream = 0/1




-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

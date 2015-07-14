From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 14 Jul 2015 09:22:08 -0600
Subject: [PATCH v2] coresight: replicator: Use module_platform_driver
In-Reply-To: <CAK-LDbJNySRdg1bSEDxhxbTuQrXbSYGwBudv31mUwhvQd9k4aQ@mail.gmail.com>
References: <20150709195944.GA4470@vaishali-Ideapad-Z570>
 <1436473148.20619.116.camel@tiscali.nl>
 <CAK-LDb+HSbM2zV8WxipLb8v7g+eL=5vMHcKGttEOdnCjSXSwPA@mail.gmail.com>
 <1436518813.20619.134.camel@tiscali.nl>
 <CAK-LDb+Yg+wQJ_bM3Usc=hoK-jDOxHy5AsUOAbmg+-dVnOM4KA@mail.gmail.com>
 <CANLsYkzTDKh8iSupUz6QckGNJfh5iZtPxVebX4Uo1Jg3FhNqqA@mail.gmail.com>
 <CAK-LDbL4vsz7sqY8Y9cFtCiYYYCX89ydDZLNSk3Gt0H91dPghA@mail.gmail.com>
 <CANLsYkyZoC5H2QHHPnSh6jon=H+GYm4o2oEWLhrY28Y32FcBRw@mail.gmail.com>
 <CAK-LDbJNySRdg1bSEDxhxbTuQrXbSYGwBudv31mUwhvQd9k4aQ@mail.gmail.com>
Message-ID: <CANLsYkyPaJSDqsHVKOgzqPQ_KVM8oN9zCX6ABst+fDq9Md+91A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 July 2015 at 05:49, Vaishali Thakkar <vthakkar1994@gmail.com> wrote:
> On Mon, Jul 13, 2015 at 9:01 PM, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
>>
>> On 10 July 2015 at 09:51, Vaishali Thakkar <vthakkar1994@gmail.com> wrote:
>> > On Fri, Jul 10, 2015 at 8:00 PM, Mathieu Poirier
>> > <mathieu.poirier@linaro.org> wrote:
>> >> On 10 July 2015 at 05:47, Vaishali Thakkar <vthakkar1994@gmail.com> wrote:
>> >>> On Fri, Jul 10, 2015 at 2:30 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
>> >>>> On vr, 2015-07-10 at 08:53 +0530, Vaishali Thakkar wrote:
>> >>>>> I thought about this solution before sending this patch. But I was not
>> >>>>> sure about it. Thanks for the explanation. I will send v3 with this
>> >>>>> change.
>> >>>>>
>> >>>>> Can I add Suggested By: Paul Bolle <pebolle@tiscali.nl>
>> >>>>
>> >>>> That should be "Suggested-by:". The net effect would be that, if my
>> >>>> suggestion turns out to be unwise, fan mail will also hit my INBOX,
>> >>>> right? Anyhow, fine with me.
>> >>>
>> >>> Ok. Thanks.
>> >>>
>> >>>> By the way, there's more module specific stuff in
>> >>>> drivers/hwtracing/coresight/. And there's no tristate symbol to be found
>> >>>> in its Kconfig file. So I'd guess there are a few other cleanups
>> >>>> possible too, if someone cared enough to have a closer look at that.
>> >>>>
>> >>>
>> >>> Yes. It seems that introducing something like builtin_amba_driver()
>> >>> can be useful for files which are using module_amba_driver now . But I'm
>> >>> not sure if Mathieu is ok with it or not? If it seems useful to him, then I
>> >>> can go for it.
>> >>
>> >> The ETB drivers could use a "module_amba_driver()"...
>> >
>> > Why? Is there any specific reason behind this?
>> > How about other drivers?? Will it be beneficial to introduce
>> > builtin_amba_driver() for the others?
>>
>> All the other drivers (aside from the replicator) have been moved to
>> "module_amba_driver()" to avoid boilerplate code.  The only one that
>> was forgotten is the ETB.  A fix for ETM3x is already part of the 4.2
>> cycle.
>>
>
> I see. Ok.
>
>>
>> As for builtin_amba_driver(), that will be up to Russell to decide.
>> Other than not calling the second half of the module_driver() macro, I
>> don't see what else it could do.
>
> I think there was a good conversation between Paul Gortmaker and other
> developers when he first introduced the idea of adding such macro
> (builtin_platform_driver). His commit explains that idea in a good way too.
> But yes I believe that it is a matter of taste. And at the end of the day it is
> upon maintainers whether such change is good for their drivers or not.
> Anyways I will be happy to work on this thing if Russell or you decides
> to go for builtin_amba_driver.

I personally think there is better (and more interesting) work to do
in the kernel for someone who wants to learn.  The staging directory
is full of drivers begging to be upstreamed.  Most of them even have a
tally of things to do before they can be taken out of staging.  On top
of things their original author will likely welcome help to work on
them.

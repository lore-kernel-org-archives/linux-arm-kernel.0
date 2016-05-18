From: dianders@chromium.org (Doug Anderson)
Date: Tue, 17 May 2016 21:13:12 -0700
Subject: [PATCH] mmc: dw_mmc: Consider HLE errors to be data and command
 errors
In-Reply-To: <573BCEB5.8020905@samsung.com>
References: <1426002490-2014-1-git-send-email-dianders@chromium.org>
 <5502CA4E.9060401@samsung.com>
 <CAD=FV=VX3ix-j4y95W1q8b-aVuVEN+4xsd8WLx2xcE7KPNJwRw@mail.gmail.com>
 <5506707D.40708@samsung.com> <55189F04.8000404@samsung.com>
 <CAD=FV=WFAZqAsXOqunt0fxw87M-FruwUrxuzW0MJsG6UvfSjzA@mail.gmail.com>
 <CAD=FV=UJGcwa_biSCGhD=kS-T+fppCniBFfOHb5ohnwSwSwMMA@mail.gmail.com>
 <573BCEB5.8020905@samsung.com>
Message-ID: <CAD=FV=XFUKXRRRyVLOTV1ORtYfG1ngEqic-CYLp9S=C=8eJYkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 17, 2016 at 7:08 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 05/18/2016 09:47 AM, Doug Anderson wrote:
>> Jaehoon,
>>
>> On Mon, Mar 30, 2015 at 8:47 AM, Doug Anderson <dianders@chromium.org> wrote:
>>> Jaehoon,
>>>
>>> On Sun, Mar 29, 2015 at 5:55 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>> Dear Doug,
>>>>
>>>> I'm considering to control HLE error..So holding this patch.
>>>> If this is absolutely necessary patch, let me know, plz.
>>>>
>>>> Best Regards,
>>>> Jaehoon Chung
>>>
>>> Sounds OK.  I have certainly applied this locally and the driver isn't
>>> robust against insertions / removals without it, but once the card is
>>> inserted things are OK so it's probably not urgent that it be applied
>>> upstream.  Hopefully we can figure out a better solution...
>>
>> I'm now testing a nice new rebased kernel and I'm hitting this again.
>>
>> Of course I'll just pick my same patch to my new kernel tree, but
>> since it's been a year and nobody has done anything better, would you
>> consider landing my patch?  It is certainly better than nothing.
>
> Sure, it's right.
> I think that main reason of HLE is wait_prvdata_complete. (I'm guessing..)
> On other hands, dwmmc controller is handling something wrong. (I found that HLE is occurred the similar case.)
> After find the main solution, it's not bad that your patch is applied on dwmmc controller.
>
> Ulf have sent PR for next..So if we needs to apply this, i will apply on fix.

It's not new, so I'd say just queue it up for the next version
whenever it's convenient.

-Doug

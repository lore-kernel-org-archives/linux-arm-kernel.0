From: rafael@kernel.org (Rafael J. Wysocki)
Date: Sat, 26 Sep 2015 00:19:56 +0200
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <20150925214438.GH5951@linux>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <4357538.Wlf88yQie6@vostro.rjw.lan>
 <CAKohpok2Z2m7GZt1GzZzofeHEioF=XJEq8YVgtY=VtS9tmpb_Q@mail.gmail.com>
 <2524822.pQu4UKMrlb@vostro.rjw.lan> <20150925214438.GH5951@linux>
Message-ID: <CAJZ5v0i+xJ4U13vCVsvXc7S8wP0AokbmNXPidBkDwbjXMM8fCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 11:44 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 25-09-15, 22:58, Rafael J. Wysocki wrote:
>> Say you have three adjacent fields in a structure, x, y, z, each one byte long.
>> Initially, all of them are equal to 0.
>>
>> CPU A writes 1 to x and CPU B writes 2 to y at the same time.
>>
>> What's the result?
>
> But then two CPUs can update the same variable as well, and we must
> have proper locking in place to fix that.

Right.

So if you allow something like debugfs to update your structure, how
do you make sure there is the proper locking?

Is that not a problem in all of the places modified by the [2/2]?

How can the future users of the API know what to do to avoid potential
problems with it?

>
> Anyway, that problem isn't here for sure as its between two
> unsigned-longs. So, should I just move it to bool and resend ?

I guess it might be more convenient to fold this into the other patch,
because we seem to be splitting hairs here.

Thanks,
Rafael

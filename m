From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 26 Sep 2015 11:40:00 -0700
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <CAJZ5v0i+xJ4U13vCVsvXc7S8wP0AokbmNXPidBkDwbjXMM8fCw@mail.gmail.com>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <4357538.Wlf88yQie6@vostro.rjw.lan>
 <CAKohpok2Z2m7GZt1GzZzofeHEioF=XJEq8YVgtY=VtS9tmpb_Q@mail.gmail.com>
 <2524822.pQu4UKMrlb@vostro.rjw.lan> <20150925214438.GH5951@linux>
 <CAJZ5v0i+xJ4U13vCVsvXc7S8wP0AokbmNXPidBkDwbjXMM8fCw@mail.gmail.com>
Message-ID: <CAKohpok0A3JRhVCabscfJGuhJerWmypsQnwdqJcmvBBWdpvPwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 September 2015 at 15:19, Rafael J. Wysocki <rafael@kernel.org> wrote:
> So if you allow something like debugfs to update your structure, how
> do you make sure there is the proper locking?

Not really sure at all.. Isn't there some debugfs locking that will
jump in, to avoid updation of fields to the same device?

> Is that not a problem in all of the places modified by the [2/2]?

Right, but its not new AFAICT.

We already have u32 fields in those structs and on 64 bit machines
we have the same read-update-write problems for two consecutive
u32's. Right?

> How can the future users of the API know what to do to avoid potential
> problems with it?

No idea really :)

>> Anyway, that problem isn't here for sure as its between two
>> unsigned-longs. So, should I just move it to bool and resend ?
>
> I guess it might be more convenient to fold this into the other patch,
> because we seem to be splitting hairs here.

I can and that's what I did. But then Arnd asked me to separate it
out. I can fold it back if that's what you want.

--
viresh

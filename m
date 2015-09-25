From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 25 Sep 2015 22:58:42 +0200
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <CAKohpok2Z2m7GZt1GzZzofeHEioF=XJEq8YVgtY=VtS9tmpb_Q@mail.gmail.com>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <4357538.Wlf88yQie6@vostro.rjw.lan>
 <CAKohpok2Z2m7GZt1GzZzofeHEioF=XJEq8YVgtY=VtS9tmpb_Q@mail.gmail.com>
Message-ID: <2524822.pQu4UKMrlb@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 25, 2015 01:25:49 PM Viresh Kumar wrote:
> On 25 September 2015 at 13:33, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > You're going to change that into bool in the next patch, right?
> 
> Yeah.
> 
> > So what if bool is a byte and the field is not word-aligned
> 
> Its between two 'unsigned long' variables today, and the struct isn't packed.
> So, it will be aligned, isn't it?
> 
> > and changing
> > that byte requires a read-modify-write.  How do we ensure that things remain
> > consistent in that case?
> 
> I didn't understood why a read-modify-write is special here? That's
> what will happen
> to most of the non-word-sized fields anyway?
> 
> Probably I didn't understood what you meant..

Say you have three adjacent fields in a structure, x, y, z, each one byte long.
Initially, all of them are equal to 0.

CPU A writes 1 to x and CPU B writes 2 to y at the same time.

What's the result?

Thanks,
Rafael

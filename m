From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 25 Sep 2015 13:25:49 -0700
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <4357538.Wlf88yQie6@vostro.rjw.lan>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <20150925185256.GG5951@linux> <4331507.W3ZDWldbWu@vostro.rjw.lan>
 <4357538.Wlf88yQie6@vostro.rjw.lan>
Message-ID: <CAKohpok2Z2m7GZt1GzZzofeHEioF=XJEq8YVgtY=VtS9tmpb_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 September 2015 at 13:33, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> You're going to change that into bool in the next patch, right?

Yeah.

> So what if bool is a byte and the field is not word-aligned

Its between two 'unsigned long' variables today, and the struct isn't packed.
So, it will be aligned, isn't it?

> and changing
> that byte requires a read-modify-write.  How do we ensure that things remain
> consistent in that case?

I didn't understood why a read-modify-write is special here? That's
what will happen
to most of the non-word-sized fields anyway?

Probably I didn't understood what you meant..

--
viresh

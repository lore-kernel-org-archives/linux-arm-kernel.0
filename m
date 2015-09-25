From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 25 Sep 2015 14:44:38 -0700
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <2524822.pQu4UKMrlb@vostro.rjw.lan>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <4357538.Wlf88yQie6@vostro.rjw.lan>
 <CAKohpok2Z2m7GZt1GzZzofeHEioF=XJEq8YVgtY=VtS9tmpb_Q@mail.gmail.com>
 <2524822.pQu4UKMrlb@vostro.rjw.lan>
Message-ID: <20150925214438.GH5951@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25-09-15, 22:58, Rafael J. Wysocki wrote:
> Say you have three adjacent fields in a structure, x, y, z, each one byte long.
> Initially, all of them are equal to 0.
> 
> CPU A writes 1 to x and CPU B writes 2 to y at the same time.
> 
> What's the result?

But then two CPUs can update the same variable as well, and we must
have proper locking in place to fix that.

Anyway, that problem isn't here for sure as its between two
unsigned-longs. So, should I just move it to bool and resend ?

-- 
viresh

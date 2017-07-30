From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 30 Jul 2017 17:31:03 +0300
Subject: [PATCH 0/5] earlycon hang under some conditions
In-Reply-To: <1500357778-23169-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1500357778-23169-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <CAHp75VdHqD67jcoaQ5EwdTVdoyLNF0DCTQDvTxWikiaOnPs75g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 9:02 AM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> I was testing earlycon with 8250 dw serial console. And it hangs in
> these cases:
> 1/ kernel hang when calling early write function after free_initmem:
> a) the earlycon not disabled after the init code(due to keep_bootcon or
>    not specify a real console to switch to)
> b) the early write func is marked as __init, for example 8250_early.

> This serial fix 1/ case only.

Here is another opinion.
I can tell that conditions to get into the trouble are quite unusual or rare.

Any rationale behind why one needs such a combination of parameters?

P.S. For doulble output ask Sergey and Petr (they are quite concerned
about it). Actually strange I didn't see their names in Cc list for
console related stuff,

-- 
With Best Regards,
Andy Shevchenko

From: keescook@chromium.org (Kees Cook)
Date: Fri, 15 Jul 2016 12:14:23 -0700
Subject: [kernel-hardening] Re: [PATCH v2 02/11] mm: Hardened usercopy
In-Reply-To: <1468609254.32683.34.camel@gmail.com>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-3-git-send-email-keescook@chromium.org>
 <20160714232019.GA28254@350D>
 <CAGXu5jKzD_rCMNJQU1bB5KDfKTsb+AaidZwe=FAfGMqt_FkfqQ@mail.gmail.com>
 <1468609254.32683.34.camel@gmail.com>
Message-ID: <CAGXu5jLiD1xEb=dDuf+_2JVzmkH_6O5-m=p=AVvi7qgQ+SV4UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 12:00 PM, Daniel Micay <danielmicay@gmail.com> wrote:
>> This could be a BUG, but I'd rather not panic the entire kernel.
>
> It seems unlikely that it will panic without panic_on_oops and that's
> an explicit opt-in to taking down the system on kernel logic errors
> exactly like this. In grsecurity, it calls the kernel exploit handling
> logic (panic if root, otherwise kill all process of that user and ban
> them until reboot) but that same logic is also called for BUG via oops
> handling so there's only really a distinction with panic_on_oops=1.
>
> Does it make sense to be less fatal for a fatal assertion that's more
> likely to be security-related? Maybe you're worried about having some
> false positives for the whitelisting portion, but I don't think those
> will lurk around very long with the way this works.

I'd like it to dump stack and be fatal to the process involved, but
yeah, I guess BUG() would work. Creating an infrastructure for
handling security-related Oopses can be done separately from this (and
I'd like to see that added, since it's a nice bit of configurable
reactivity to possible attacks).

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security

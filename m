From: luto@kernel.org (Andy Lutomirski)
Date: Fri, 5 Oct 2018 10:44:07 -0700
Subject: [RFC PATCH 1/9] kernel: add support for patchable function
 pointers
In-Reply-To: <CAHmME9pgJ_2GGDUVsbQXcNRfh3yACqFG+5uemFRMZkb8LdH95g@mail.gmail.com>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org>
 <20181005141433.GS19272@hirez.programming.kicks-ass.net>
 <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net>
 <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com>
 <CALCETrWaewXsdJsf3SocgZ0ggnvZk86L+5-LWPRbjdnG2mB7jw@mail.gmail.com>
 <CAKv+Gu-oHBtgGbWXJu6+z4+BNhBZyY5VvF_v6cJJUGk_5YX1eQ@mail.gmail.com>
 <CALCETrU=fm+ZG4WZJfG-5GwL7kv5_GS1aZYu=L42d5BuSbhJDQ@mail.gmail.com>
 <CAKv+Gu8eHPEsUbkhN=61z9FvhdCo2e3VOdemp4g0bzdO1EJFYQ@mail.gmail.com>
 <CALCETrVMBULVP9qEQDVuisxAMzdheM1qQ97AZFs-xcO0eaXiiA@mail.gmail.com>
 <CAHmME9pgJ_2GGDUVsbQXcNRfh3yACqFG+5uemFRMZkb8LdH95g@mail.gmail.com>
Message-ID: <CALCETrWjCY2Wceiqu99C+g5RdnrZuRujYO_+jBvuJFRB1LTG4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 5, 2018 at 10:38 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Fri, Oct 5, 2018 at 7:29 PM Andy Lutomirski <luto@kernel.org> wrote:
> > (None of this is to say that I disagree with Jason, though -- I'm not
> > entirely convinced that this makes sense for Zinc.  But maybe it can
> > be done in a way that makes everyone happy.)
>
> Zinc indeed will continue to push in the simpler and more minimal
> direction. Down the line I'm open to trying and benching a few
> different ways of going about it with dynamic patching -- something
> that will be pretty easy to experiment with given the lean structure
> of Zinc -- but for the initial merge I intend to do it the way it is,
> which is super fast and pretty straightforward to follow.
>

I *think* the only change to Zinc per se would be that the calls like
chacha20_simd() would be static calls or patchable functions or
whatever we want to call them.  And there could be a debugfs to
override the default selection.

Ard, I don't think that sticking this in udev rules makes sense.  The
kernel has bascially complete information as to what the right choice
is, and that will change over time as the implementation gets tuned,
and the udev rules will never get updated in sync.

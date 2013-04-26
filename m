From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 26 Apr 2013 19:48:12 +0200
Subject: gpio-pxa initcall level change and machine init breakage
In-Reply-To: <CACRpkdYEi7i_kSuUy4dBW-tE4BxifJY5wFdYVyLe6La5=HwEmg@mail.gmail.com>
 (Linus Walleij's message of "Thu, 25 Apr 2013 23:22:13 +0200")
References: <5172B398.7060706@newsguy.com>
 <CAD6h2NSRA9w7GZLQGgK-+TvEAsxwOHow5_26JyVUA6YQyj3OQg@mail.gmail.com>
 <517466F6.3000003@newsguy.com>
 <CAD6h2NSy0=3P-PHdCiJJQG_jvGaFnr7uex+Uxs=0F-VsUxtPWg@mail.gmail.com>
 <CACRpkdbk24kR75fanvXVAocnuozNq_=jWDSPHPCWhbZCOrN5_Q@mail.gmail.com>
 <5176E438.80800@newsguy.com>
 <CACRpkdYLCKKZZFi6Y-viPUvrwupJGzfxr3f20a1emp-9qE0YBg@mail.gmail.com>
 <87ppxiz9l5.fsf@free.fr>
 <CACRpkdYEi7i_kSuUy4dBW-tE4BxifJY5wFdYVyLe6La5=HwEmg@mail.gmail.com>
Message-ID: <87li85yyhv.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Thu, Apr 25, 2013 at 9:36 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> This was done by pull request to Torvalds yesterday ...
Thanks, that's a relief.

>
>>  (b) inform board maintainers that they must fix their board code (for example
>>  give them 1 window)
>>  (c) put back the patch. Board maintainers who did not amend their board
>>  code cannot say anymore they didn't know it. Board maintainers will also have
>>  time to rise objections if they think they cannot change their board code
>>  (which I do not believe is possible, but who knows ...)
>
> So when it comes to the PXA there is maybe this list of things that
> would be nice to change, and this is likely on top of it ... moving the
> PXA machines over to device tree would be more important if people
> who like them want them so stay around, because non-device tree
> platforms will at some point become deprecated, and fixing the platforms
> to support device tree will inevitably lead to this problem being fixed
> as well.
Yeah, probably. That's a good long term goal too.
Now you reverted, I'm under pressure to fix mioa701 to get rid of gpio calls in
its board setup code :)

As for device tree conversion, well that's another story.
For my case for example I'll have to redevelop the bootloader (IPL+SPL) in order
for suspend to RAM to work ... no world is perfecgt.

Cheers.

-- 
Robert

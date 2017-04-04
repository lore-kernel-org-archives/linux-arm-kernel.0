From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 4 Apr 2017 21:04:24 +0300
Subject: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
In-Reply-To: <1491328749.7125.66.camel@tzanussi-mobl.amr.corp.intel.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <87pogur0y9.fsf@firstfloor.org>
 <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
 <92fb1e4a-d6df-f55b-c0a1-9c1eb78e3943@longlandclan.id.au>
 <CAMuHMdUTW7Fh+3kWKFCToqhaz-+58--=Sx1Zv0KRnVY4bDKOGQ@mail.gmail.com>
 <CAHp75VdCPHW-jZ7FCrEjqHQ6ULxH_U9EsBHTjb4a=Nhs_kYFGg@mail.gmail.com>
 <1491325150.7125.62.camel@tzanussi-mobl.amr.corp.intel.com>
 <CAHp75VcUorx5D2ive8eNWhtu2BzSbYAm+y9_KeFYdkTMgsg0SA@mail.gmail.com>
 <1491328749.7125.66.camel@tzanussi-mobl.amr.corp.intel.com>
Message-ID: <CAHp75VfQVdMRZnbDFyH9m=HfSuoiUxqhf2y+H07u4u6xPd7DUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 4, 2017 at 8:59 PM, Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
> On Tue, 2017-04-04 at 20:08 +0300, Andy Shevchenko wrote:
>> On Tue, Apr 4, 2017 at 7:59 PM, Tom Zanussi <tom.zanussi@linux.intel.com> wrote:
>> > On Tue, 2017-04-04 at 00:05 +0300, Andy Shevchenko wrote:

>> > I was focused at that point mainly on the kernel static size, and using
>> > a combination of Josh Triplett's tinification tree, Andi Kleen's LTO and
>> > net-diet patches, and my own miscellaneous patches that I was planning
>> > on eventually upstreaming, I ended up with a system that I could boot to
>> > shell with a 455k text size:
>> >
>> > Memory: 235636K/245176K available (455K kernel code, 61K rwdata,
>> > 64K rodata, 132K init, 56K bss, 3056K reserved, 0K cma-reserved)

>> Thanks for sharing your experience. The question closer to this
>> discussion what did you do against TTY/UART/(related) layer(s)?
>>
>
> I'd have to go back and take a look, but nothing special AFIAR.
>
> No patches or hacks along those lines, and the only related thing I see
> as far as config is:
>
>         cfg/pty-disable.scc \
>
> which maps to:
>
>         # CONFIG_UNIX98_PTYS is not set

But on your guestimation how much can we squeeze TTY/UART layer if we
do some compile-time configuration?
Does it even make sense or better to introduce something like minitty
special layer instead?

I believe you did some research during time of that project?

-- 
With Best Regards,
Andy Shevchenko

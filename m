From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 14 Nov 2014 09:17:40 +0100
Subject: [PATCH] PM / Domains: Change prototype for the ->attach_dev()
 callback
In-Reply-To: <6900237.LSPrkZ5QMk@vostro.rjw.lan>
References: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
 <3267963.fqUYb7m9Rv@vostro.rjw.lan>
 <7hsihx1bvo.fsf@deeprootsystems.com>
 <6900237.LSPrkZ5QMk@vostro.rjw.lan>
Message-ID: <CAMuHMdWR=o+JAN=ogbqeUR+8Ye=VG+Dri+D0Nmhd5mruYEzUtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On Thu, Nov 6, 2014 at 1:54 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, November 05, 2014 03:11:23 PM Kevin Hilman wrote:
>> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>> > On Wednesday, November 05, 2014 02:43:31 PM Kevin Hilman wrote:
>> >> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
>> >> > On Thu, Oct 30, 2014 at 01:38:30PM -0700, Kevin Hilman wrote:
>> >> >> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>> >> >> > On Thursday, October 30, 2014 01:02:49 PM Ulf Hansson wrote:
>> >> >> >> Convert the prototype to return and int. This is just an initial step,
>> >> >> >> needed to support error handling.
>> >> >> >>
>> >> >> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> >> >>
>> >> >> Acked-by: Kevin Hilman <khilman@linaro.org>
>> >> >>
>> >> >> >> This patch is intended as fix for 3.18 rc[n]. Why?
>> >> >> >>
>> >> >> >> There are other SOC specific patches around that adds genpd support and which
>> >> >> >> implements the ->attach_dev() callback. To prevent having an "atomic" patch
>> >> >> >> during the next release cycle, let's change the prototype now instead.
>> >> >> >>
>> >> >> >> Further patches will add the actual error handling in genpd and these can then
>> >> >> >> be reviewed and tested thoroughly.
>> >> >> >
>> >> >> > So we have no users of ->attach_dev at the moment, right?
>> >> >>
>> >> >> Not in mainline, but there are a couple getting ready to hit -next, so
>> >> >> we wanted to fix this before they arrive so that adding the error
>> >> >> handling will be easier.
>> >> >
>> >> > BTW, while we are at it, can we also pass the domain itself to
>> >> > attach_dev() and detach_dev()? If anything it helps with debugging (you
>> >> > can print domain name from the callbacks).
>> >>
>> >> Agreed, and it makes it match the other callbacks (power_off, power_on)
>> >> which currently take struct generic_pm_domain *domain.
>> >>
>> >> Updated version of $SUBJECT patch below.
>> >
>> > The subject and changelog need to be updated too IMO.
>> >
>>
>> Right.  Here you go.
>
> I've replaced the Ulf's original with this one, thanks!

When do you plan to send a pull request for this to Linus?

There are PM domain drivers blocked on entering -next due to this
dependency. As they have to pass through arm-soc first, and the arm-soc
merge window will close soon, time is running out.

Alternatively, you could provide an immutable branch containing this fix
to unblock dependents.

Thanks for your understanding.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

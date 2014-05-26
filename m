From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 May 2014 19:14:15 +0530
Subject: [PATCH 2/4] cpufreq: add i.MX5 cpufreq driver
In-Reply-To: <1401109863.4829.46.camel@weser.hi.pengutronix.de>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
 <1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
 <CAKohpoksbFHyX=r0=URMedJNi68c3xAX4OrXzSFqgf1-bCm4+Q@mail.gmail.com>
 <1401101131.4829.29.camel@weser.hi.pengutronix.de>
 <CAKohponTUsYLf-8_iSnttwK8oXyJEZVWpF+a=vLC7r_jZ8AzOQ@mail.gmail.com>
 <1401107748.4829.39.camel@weser.hi.pengutronix.de>
 <CAKohpo=ncHUmtJOEw4FZG1BWUSuiQK4n+ETEMJWJj9UoPz2cnw@mail.gmail.com>
 <1401109863.4829.46.camel@weser.hi.pengutronix.de>
Message-ID: <CAKohponzJma6yNueMef2Q4k+qT-n7boV0tx0pCqjFmuQWj6TXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 May 2014 18:41, Lucas Stach <l.stach@pengutronix.de> wrote:

Just to mention that I am trying to help you and am not opposing any
change. We can add this field if its really required and I am just trying
to understand your problem and if we can solve it with current code.

> No, setting voltage-tolerance to zero means I don't accept any tolerance
> at all. Though in practice I have a variable tolerance as I just have a
> fixed maximum voltage for the chip.
>
> For example the i.MX53 has a fixed maximum voltage of 1.4V on the cpu
> rail, so for the slowest OPP the acceptable voltage range is 0.8V to
> 1.4V, for the fastest OPP the range is 1.3V to 1.4V.
>
> So if someone connects a fixed 1.3V regulator, I want to still be able
> to use all OPPs, even though the slowest OPP wants 0.8V ideally. If I
> were to use a tolerance I would have to set is to some relatively strict
> value, in order to not exceed the maximum voltage at the highest OPP,
> but this would mean I could not use the slowest OPP because it's out of
> the tolerance range.

I understood the problem now. But I feel there is nothing imx specific here.
It should be a general concern and I want to know how are people
working around it currently.

IOW can we say that you want tolerance to work only on the positive
side? But no tolerance on the -ve side ?

Also, your example dts says that you do have different voltage levels
for each frequency but actually the regulator may only support a
single voltage. i.e. 1.4 volts.

--
viresh

From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 May 2014 18:26:55 +0530
Subject: [PATCH 2/4] cpufreq: add i.MX5 cpufreq driver
In-Reply-To: <1401107748.4829.39.camel@weser.hi.pengutronix.de>
References: <1401099308-9658-1-git-send-email-l.stach@pengutronix.de>
 <1401099308-9658-2-git-send-email-l.stach@pengutronix.de>
 <CAKohpoksbFHyX=r0=URMedJNi68c3xAX4OrXzSFqgf1-bCm4+Q@mail.gmail.com>
 <1401101131.4829.29.camel@weser.hi.pengutronix.de>
 <CAKohponTUsYLf-8_iSnttwK8oXyJEZVWpF+a=vLC7r_jZ8AzOQ@mail.gmail.com>
 <1401107748.4829.39.camel@weser.hi.pengutronix.de>
Message-ID: <CAKohpo=ncHUmtJOEw4FZG1BWUSuiQK4n+ETEMJWJj9UoPz2cnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 May 2014 18:05, Lucas Stach <l.stach@pengutronix.de> wrote:
> Ok I can push down the clock handling into the imx5 clk driver.

Great !!

> This leaves two more differences between imx5-cpufreq and cpufreq-cpu0:
>
> 1. Disabling of OPPs that could not be supported by the connected
> regulator. I think this part can easily be made generic and pushed into
> cpu0, as it should be beneficial to other SoCs too.

Sure.

> 2. Usage of a fixed max voltage, rather than a voltage-tolerance. i.MX5
> has a fixed maximum voltage, which is valid across all operating points.
> I'm really opposed to using a tolerance value, where we instead could
> have a well defined range. So for merging imx5-cpufreq into cpufreq-cpu0
> this driver really need to handle this case.
> Does adding a separate property for this, while keeping the
> voltage-tolerance for the existing users, sound like a change you would
> accept?

It looks you can just send voltage-tolerance to "zero" and this should work
for you.. No need of another field.

Thanks a lot for making our (/me & Rafael) life easier :)

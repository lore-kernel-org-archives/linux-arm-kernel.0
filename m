From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 8 Mar 2013 12:20:42 +0800
Subject: [PATCH V2] cpufreq: ARM big LITTLE: Add generic cpufreq driver
 and its DT glue
In-Reply-To: <Pine.LNX.4.64.1303072248560.20470@axis700.grange>
References: <6cba8f153cfd4b0d3075a34a6dfe287bdec2eb06.1362676407.git.viresh.kumar@linaro.org>
 <Pine.LNX.4.64.1303072248560.20470@axis700.grange>
Message-ID: <CAKohpo=-_uzTi6QR4MnXPd5yAZFTcw-3ZZL-TAVY+drV-bDjNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 March 2013 05:56, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> I like generic drivers :)

Me too :)

> cpufreq-cpu0 is yet another such generic
> (cpufreq) driver. Now, comparing the functionality of the two:

Great!!

> we see, that this driver "only" switches CPU clock frequencies. Whereas
> the cpufreq-cpu0 driver also manipulates a regulator (if available)
> directly. I understand, power-saving is also an important consideration
> for big.LITTLE systems. So, I presume, you plan to implement voltage
> switching in cpufreq notifiers?

So the platform on which we are currently testing these is ARM TC2 Soc
and this switching is done by the firmware instead. And so didn't went
for regulator hookups initially.. Obviously in future regulator hookups would
find some space in this driver but not required for now.

> Now, my question is: is this (notifier)
> actually the preferred method and the cpufreq-cpu0 driver is doing it
> "wrongly?"

What notifiers are you talking about? I believe using the regulator framework
is the right way of doing this. And that would be part of this code later on.

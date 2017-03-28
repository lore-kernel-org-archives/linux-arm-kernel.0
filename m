From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 28 Mar 2017 22:50:50 +0200
Subject: [RFC 3/8] cpufreq: imx6q: Set max suspend_freq to avoid changes
 during suspend
In-Reply-To: <1490731431.15830.9.camel@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <20170323043427.GE12094@vireshk-i7> <1490731431.15830.9.camel@nxp.com>
Message-ID: <45185440.SBt0mf6LXq@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 28, 2017 11:03:51 PM Leonard Crestez wrote:
> On Thu, 2017-03-23 at 10:04 +0530, Viresh Kumar wrote:
> > On 22-03-17, 18:53, Leonard Crestez wrote:
> > > If the cpufreq driver tries to modify voltage/freq during suspend/resume
> > > it might need to control an external PMIC via I2C or SPI but those
> > > devices might be already suspended.
> > > 
> > > To avoid this scenario we just increase cpufreq to highest setpoint
> > > before suspend. This issue can easily be triggered by ldo-bypass but in
> > > theory any regulator set_voltage call can end up having to modify
> > > external supply voltages.
> > > 
> > > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > > ---
> > >  drivers/cpufreq/imx6q-cpufreq.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> The first couple of patches are obvious fixes despite being marked as
> RFC. It would be great if you could apply them to your tree separately

Why?

> from the rest of the series but I'm not sure what the process is here.

Well, you have to talk to me.

Thanks,
Rafael

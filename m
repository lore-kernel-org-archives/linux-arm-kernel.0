From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Jul 2012 14:38:13 +0800
Subject: [PATCH 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <CAMQu2gy4p+rL-sDAsGCnqSn_2eXwSqf---OS0BSXuDoacjd6_g@mail.gmail.com>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-4-git-send-email-shawn.guo@linaro.org>
 <CAMQu2gw32LogXJJa+K5ZjmCZzBNK3FY2wYwZXU8fsftsVzEO2Q@mail.gmail.com>
 <20120720123317.GA32263@S2101-09.ap.freescale.net>
 <CAJOA=zMQKLTumW7Nx68+yxHC5Yk4QyiL2mf1+TSZfVOAtnXDWA@mail.gmail.com>
 <CAMQu2gy4p+rL-sDAsGCnqSn_2eXwSqf---OS0BSXuDoacjd6_g@mail.gmail.com>
Message-ID: <20120721063811.GA619@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2012 at 10:34:29AM +0530, Shilimkar, Santosh wrote:
> On Fri, Jul 20, 2012 at 9:20 PM, Turquette, Mike <mturquette@ti.com> wrote:
> > How about cpufreq-single-thread.c and CONFIG_CPUFREQ_SINGLE_THREAD?
> > That makes sense for both UP and SMP.
> >
> Indeed. This sounds more appropriate and also reflects what actually happens
> with a UP or shared clock SMP case.
> 
While I agree with this observation, the suggested naming does not
reflect the rationale of CPU0 though, which is really important for
driver to work, and is exactly the thing I like about *_CPU0 naming.

The driver needs the following stuff around CPU0 to be functional.

- Device tree node /cpus/cpu at 0
- clk lookup with dev_id being "cpu0"
- regulator with id being "cpu0"

I think the *_CPU0 naming does a better job on emphasising those in the
first place.

-- 
Regards,
Shawn

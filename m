From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 9 Mar 2013 11:06:55 +0800
Subject: [PATCH V2] cpufreq: ARM big LITTLE: Add generic cpufreq driver
 and its DT glue
In-Reply-To: <Pine.LNX.4.64.1303080706310.24111@axis700.grange>
References: <6cba8f153cfd4b0d3075a34a6dfe287bdec2eb06.1362676407.git.viresh.kumar@linaro.org>
 <Pine.LNX.4.64.1303072248560.20470@axis700.grange>
 <CAKohpo=-_uzTi6QR4MnXPd5yAZFTcw-3ZZL-TAVY+drV-bDjNw@mail.gmail.com>
 <Pine.LNX.4.64.1303080706310.24111@axis700.grange>
Message-ID: <CAKohpomVitj=mMmT3Z_QPgxzDyXkKN6xYReyJxO1Nc3ei=zCww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 March 2013 14:11, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Also in your driver you're doing
>
>                 cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>                 ...
>                 cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>
> So, theoretically you could install such notifiers to adjust CPU voltages
> (using regulators too). But adding regulator calls directly to the driver
> would make it consistent with cpufreq-cpu0.c.

Yes

>  so, if this doesn't violate
> any concepts, I think, it would be good to add those when suitable systems
> appear.

That's what i thought :)

From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 31 Aug 2016 03:26 +0200
Subject: Kernel warning in cpufreq_add_dev()
In-Reply-To: <20160824131316.GI25143@ubuntu>
References: <20160819110032.GM1041@n2100.armlinux.org.uk>
 <2310664.2BksGViL4r@vostro.rjw.lan> <20160824131316.GI25143@ubuntu>
Message-ID: <1496109.Jd9MGDryNS@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 24, 2016 06:43:16 PM Viresh Kumar wrote:
> On 22-08-16, 19:32, Rafael J. Wysocki wrote:
> > But it will be called in that path during physical CPU hot-add, won't it?
> 
> What about something like this instead (completely untested) ?

Inline, please?

> @Russell: Can you please try this ??

I was thinking about something similar, but won't the WARN_ON()s in
cpufreq_add/remove_dev_symlink() still trigger, say if there's more
than one CPU in a policy and both happen to be online initially?

Thanks,
Rafael

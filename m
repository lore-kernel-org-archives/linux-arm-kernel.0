From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Mar 2013 00:51:19 +0000
Subject: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver
 and its DT glue
In-Reply-To: <CAKohpo=cBkHZnSa8ZsM=k7RRN+RZDXFUWDM82EXXBSQcM-8Vhw@mail.gmail.com>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
 <20130305105251.GL17833@n2100.arm.linux.org.uk>
 <CAKohpo=cBkHZnSa8ZsM=k7RRN+RZDXFUWDM82EXXBSQcM-8Vhw@mail.gmail.com>
Message-ID: <20130307005119.GY17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 08:32:37AM +0800, Viresh Kumar wrote:
> On 5 March 2013 18:52, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Tue, Mar 05, 2013 at 12:52:41PM +0800, Viresh Kumar wrote:
> >> +     clk[cluster] = clk_get(NULL, name);
> >> +     if (!IS_ERR_OR_NULL(clk[cluster])) {
> >
> > NAK.  Two reasons.
> >
> > 1. IS_ERR_OR_NULL.  You know about this, it's been on the list several
> >    times.
> 
> Hey, i had a second thought about this one and i have some other opinion
> here. This is a cpufreq driver and we need clock support for sure here, we
> can't work without it. And so here is the latest fixup:

NAK.  You just don't understand.

From: slash.tmp@free.fr (Mason)
Date: Fri, 15 May 2015 15:58:23 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <20150515131521.GK2067@n2100.arm.linux.org.uk>
References: <5554858A.9010207@free.fr> <20150514115456.GB23999@linux>
 <55549DEE.6010202@free.fr>
 <CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com>
 <20150514144239.GZ2067@n2100.arm.linux.org.uk> <5555BC7E.7010601@free.fr>
 <20150515095159.GF2067@n2100.arm.linux.org.uk> <5555CC1A.5040604@free.fr>
 <20150515115852.GJ2067@n2100.arm.linux.org.uk> <5555EA68.7030006@free.fr>
 <20150515131521.GK2067@n2100.arm.linux.org.uk>
Message-ID: <5555FB7F.901@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Dropping cpufreq and linux-pm ]

On 15/05/2015 15:15, Russell King - ARM Linux wrote:

> I guess I was wrong.  I'm no expert on the kernel's time code.  That's
> why I've suggested to you several times that you do the research
> yourself, rather than me having to do that research for you and then
> write an email about it.  It's kind of wasting my time, and you're not
> paying me for this kind of support service...

Sorry if my questions appeared to be asking you to do
my research for me. I was hoping some of the ARM guys
might eventually chime in, as they wrote most of the
TWD code.

Anyway, thanks to you and Viresh for pointing out the
most likely culprit for my problem. I'll take a hard
look at clockevents source code next week.

> What I'm saying is that I have a platform here running a modern kernel
> which _does_ use the TWD, and it _does_ appear to be running in high-res
> mode.

Thanks for providing evidence that it does work. I am
now hopeful to get it working. I'll start by applying
my patch to a more recent kernel.

For the record, if I remove the CLOCK_EVT_FEAT_C3STOP
flag, then the system does provide hrtimers, but this
seems to be a red herring.

Regards.

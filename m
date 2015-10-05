From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 5 Oct 2015 08:13:03 -0700
Subject: Dropping "depends on SMP" for HAVE_ARM_TWD -- take 2
In-Reply-To: <20151005114940.GA4448@afzalpc>
References: <560E53E3.7070207@free.fr> <560E8584.8000207@free.fr>
 <20151002180255.GK12338@codeaurora.org> <560ED1FB.9010000@free.fr>
 <yw1xbncgluad.fsf@unicorn.mansr.com>
 <20151003103219.1e10bdeb@arm.com> <560FA4B5.1040709@free.fr>
 <20151003111231.544ae8e2@arm.com>
 <20151005054652.GI26391@xsjsorenbubuntu>
 <20151005114940.GA4448@afzalpc>
Message-ID: <20151005151303.GJ26391@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-10-05 at 05:19PM +0530, Afzal Mohammed wrote:
> Hi,
> 
> On Sun, Oct 04, 2015 at 10:46:52PM -0700, S?ren Brinkmann wrote:
> > On Sat, 2015-10-03 at 11:12AM +0100, Marc Zyngier wrote:
> 
> > > Indeed, I cannot see any code that does that in the GT driver. But if
> > > you have an A9 MP, you probably want to stick to TWD, which gives you a
> > > per-cpu timer instead of a global timer that will require IPIs to other
> > > CPUs.
> > 
> > I think the TWD only provides a clock_event device. Clocksource and
> > schedclock would have to be provided by something else.
> 
> If no clocksource, sched clock is provided, default jiffies based ones
> would be sufficient for single core, no ?, though not a preferred one.

Yes that is correct. My point was more, that twd+cpufreq is a rather
easy case since it doesn't provide a clocksource/schedclock. A driver
that provides those needs quite some more work if it depends on the CPU
frequency and needs to be usable with cpufreq.

	S?ren

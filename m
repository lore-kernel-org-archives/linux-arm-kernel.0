From: johlstei@codeaurora.org (johlstei)
Date: Thu, 05 Jan 2012 11:34:14 -0800
Subject: [PATCH v2 00/15] Make SMP timers standalone
In-Reply-To: <CACRpkdYjQPoY60XdhTwgLYbTrQMhC=Wxk5Y=hP2Vr0DngUJbxg@mail.gmail.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>	<20111222193216.GO2577@n2100.arm.linux.org.uk>	<4F048EC4.40900@arm.com>	<20120105011704.GA8870@codeaurora.org>
 <CACRpkdYjQPoY60XdhTwgLYbTrQMhC=Wxk5Y=hP2Vr0DngUJbxg@mail.gmail.com>
Message-ID: <4F05FB36.7020509@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2012 02:26 AM, Linus Walleij wrote:
> On Thu, Jan 5, 2012 at 2:17 AM, David Brown<davidb@codeaurora.org>  wrote:
>> On Wed, Jan 04, 2012 at 05:39:16PM +0000, Marc Zyngier wrote:
>>> I do. But on some non-SMP platforms, the local timer and the global
>>> timer can actually be the same (MSM is one example of this, and the UP
>>> version of the Cortex A15 is another).
>> On SMP MSM, we use the CPU0 local timer as the global timer.  They are
>> the same on non-SMP as well,
> Does this mean your CPU0 local timer is always on, always clocked?
> And do you use ARMs SMP TWD IP block for that?
>
Yes, CPU0's local timer is always on. We use it as a global clocksource, 
as well
as for udelay on both cores. It is not ARM's SMP TWD block, it is our 
own. The
timer blocks can each be read from both CPUs, but can only generate IRQs 
to one
or the other.

Jeff
